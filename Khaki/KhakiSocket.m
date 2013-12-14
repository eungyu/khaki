//
//  KhakiSocket.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "KhakiSocket.h"

@interface KhakiSocket()
  @property (nonatomic, readwrite) dispatch_semaphore_t writability;
  @property (nonatomic, readwrite) dispatch_semaphore_t readability;
@end

@implementation KhakiSocket {
  CFReadStreamRef  _readStream;
  CFWriteStreamRef _writeStream;
}

- (id) init {
  self = [super init];
  if (self) {
    _connected = false;
    _writability = dispatch_semaphore_create(0);
    _readability = dispatch_semaphore_create(0);
  }
  return self;
}

- (void)connectToHost:(NSString *) host onPort:(NSInteger) port
{
  CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)host, (int) port, &_readStream, &_writeStream);

  if (!CFWriteStreamOpen(_writeStream) || !CFReadStreamOpen(_readStream)) {
    NSLog(@"Error, streams not open");
    return;
  }

  self.inputStream  = (__bridge NSInputStream *) _readStream;
  self.outputStream = (__bridge NSOutputStream *) _writeStream;
  
  [self.inputStream setDelegate:self];
  [self.outputStream setDelegate:self];

  // network stream events are handled in background thread with high priority
  // so that blocking calls from main threads do not interfere with packet ops
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [_inputStream scheduleInRunLoop:loop forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:loop forMode:NSDefaultRunLoopMode];
    
    [loop run];
    
    [self.inputStream open];
    [self.outputStream open];
  });
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSStreamDelegate
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {

  switch (event) {
    case NSStreamEventHasSpaceAvailable: {
      dispatch_semaphore_signal(self.writability);
      NSLog(@"Marking writable");
      break;
    }
    case NSStreamEventHasBytesAvailable: {
      dispatch_semaphore_signal(self.readability);
      NSLog(@"Marking readable");
      break;
    }
    case NSStreamEventEndEncountered:
    case NSStreamEventErrorOccurred:
    {
      // TODO: Handle error and EOF
      break;
    }
    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Byte I/O
#pragma mark -
////////////////////////////////////////////////////////////////////////////////

- (NSInteger) writeBytes:(const void *) bytes withMaxLen:(NSInteger) maxlen {
  return [_outputStream write:bytes maxLength:maxlen];
}

- (NSInteger) readBytesToBuffer:(uint8_t *) buf withMaxLen:(NSInteger) maxlen {
  return [_inputStream read:buf maxLength:maxlen];
}
@end
