//
//  Khaki.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Khaki.h"
#import "KhakiSocket.h"

#import "Ping.h"
#import "GetMsg.h"
#import "ConnMsg.h"
#import "ReplyHeader.h"
#import "PendingMessageQueue.h"

@implementation Khaki {
  NSNumber _xid;
  
  KhakiSocket *_socket;
  NSMutableArray *_outbound;
  
  dispatch_queue_t _eventLoopQueue;
  dispatch_semaphore_t _sendsema;
  dispatch_source_t _pingTimer;

  PendingMessageQueue *_pending;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public API
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (id) initWithZkConnectString:(NSString *) zkAddr {
  self = [super init];
  if (self) {
    NSArray *parts = [zkAddr componentsSeparatedByString:@":"];

    _xid  = [NSNumber numberWithInt:1];
    _port = 2181;
    _host = [parts objectAtIndex:0];

    if ([parts count] > 1) {
      _port = [[parts objectAtIndex:1] intValue];
    }
    
    _socket = [[KhakiSocket alloc] init];
    _outbound = [[NSMutableArray alloc] init];
    _sendsema = dispatch_semaphore_create(0);
    _pending = [[PendingMessageQueue alloc] init];
    _eventLoopQueue = dispatch_queue_create("event.queue", DISPATCH_QUEUE_CONCURRENT);
  }
  return self;
}

- (void) connect {
  _socket = [[KhakiSocket alloc] init];
  [_socket connectToHost:self.host onPort:self.port];
  
  dispatch_async(_eventLoopQueue, ^{
    [self sendloop];
  });
  
  dispatch_async(_eventLoopQueue, ^{
    [self recvloop];
  });
  
  [self sendConnMsg];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Event Loops
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

// the holy command loop
- (void) exec {
  GetMsg *command = [[GetMsg alloc] init];
  command.path = @"/Hello/World";
  
  // send

  // wait for notification (async)
  
  // return
}

// the holy send loop
- (void) sendloop {
  while (true) {
    // wait until there is outbound message available
    dispatch_semaphore_wait(_sendsema, DISPATCH_TIME_FOREVER);

    // wait until socket is writable
    dispatch_semaphore_wait(_socket.writability, DISPATCH_TIME_FOREVER);

    NSData *data = nil;
    @synchronized(_outbound) {
      data = [_outbound objectAtIndex:0];
      [_outbound removeObjectAtIndex:0];
    }
    
    NSLog(@"Sending message");
    NSInteger nbytes = [_socket writeBytes:[data bytes] withMaxLen:[data length]];
    
    NSLog(@"%ld byte sent", nbytes);
    
    // TODO: handle unfinished bytes
  }
}

// the holy receive loop
- (void) recvloop {
  while (true) {
    dispatch_semaphore_wait(_socket.readability, DISPATCH_TIME_FOREVER);
    
    uint8_t buf[1024];
    NSInteger len = [_socket readBytesToBuffer:buf withMaxLen:1024];

    if (len > 0) {
      uint32_t msglen = OSReadBigInt32(buf, 0);
      NSLog(@"Read message of %d bytes", msglen);
      
      NSMutableData *data = [[NSMutableData alloc] initWithLength:0];
      [data appendBytes: (const void *) &buf[sizeof(uint32_t)] length:msglen];
      
      if (!_socket.connected) {
        ConnMsg *conn = [[ConnMsg alloc] init];
        [conn deserialize:data];
        [_socket setConnected:true];
        [self setupPingTimer];
      }
      else
      {
        ReplyHeader *header = [[ReplyHeader alloc] init];
        [header deserialize:data];

        int headerLength = [ReplyHeader getHeaderLength];
        NSRange payloadRange = NSMakeRange(headerLength, msglen - headerLength);
        NSData *payload = [data subdataWithRange:payloadRange];
        [self handlePayload:payload withHeader:header];
      }
      
    }
    
  }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helper Functions
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (NSInteger) getNextXid {

  NSInteger xid = 0;
  @synchronized(_xid) {
    xid = [_xid intValue] + 1;
    _xid = [NSNumber numberWithInteger:xid];
  }

  return xid;
}

- (void) sendMessage:(NSData *) data {

  @synchronized(_outbound) {
    [_outbound addObject:data];
  }

  dispatch_semaphore_signal(_sendsema);
}

- (void) handlePayload:(NSData *) payload withHeader:(ReplyHeader *) header {
  
  int xid = [header xid];
  switch (xid) {
    case -2:
      NSLog(@"Received PING");
      return;
    default:
      break;
  }
  
  // submit response to pending queue
  [_pending submit:xid with:payload];
}

- (void) sendConnMsg {
  ConnMsg *conn = [[ConnMsg alloc] init];
  conn.timeout = 30000;
  
  NSData *msg = [conn serialize];
  [self sendMessage:msg];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Periodic Timers
#pragma mark -
////////////////////////////////////////////////////////////////////////////////


- (void) setupPingTimer {
  _pingTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
  
  if (_pingTimer) {
    dispatch_source_set_timer(_pingTimer, dispatch_time(DISPATCH_TIME_NOW, 0), 5ull * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_pingTimer, ^{
      NSLog(@"Sending PING");
      Ping *ping = [[Ping alloc] init];
      NSData *data = [ping serialize];
 
      [self sendMessage:data];
    });
    dispatch_resume(_pingTimer);
  }
  
}

@end
