//
//  Khaki.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Khaki.h"
#import "KhakiSocket.h"

@implementation Khaki {
  KhakiSocket *_socket;
  dispatch_queue_t _eventLoopQueue;
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

    _port = 2181;
    _host = [parts objectAtIndex:0];

    if ([parts count] > 1) {
      _port = [[parts objectAtIndex:1] intValue];
    }
    
    _socket = [[KhakiSocket alloc] init];
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
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Event Loops
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (void) sendloop {
  while (true) {
    dispatch_semaphore_wait(_socket.writability, DISPATCH_TIME_FOREVER);
    NSLog(@"Send message");
  }
}

- (void) recvloop {
  while (true) {
    dispatch_semaphore_wait(_socket.readability, DISPATCH_TIME_FOREVER);
    NSLog(@"Recv message");
  }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helper Functions
#pragma mark -
////////////////////////////////////////////////////////////////////////////////


@end
