//
//  KhakiSocket.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "KhakiSocket.h"

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
  
  [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  
  [self.inputStream open];
  [self.outputStream open];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {

  switch (event) {
    case NSStreamEventHasSpaceAvailable: {
      dispatch_semaphore_signal(self.writability);
      break;
    }
    case NSStreamEventHasBytesAvailable: {
      dispatch_semaphore_signal(self.readability);
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

@end
