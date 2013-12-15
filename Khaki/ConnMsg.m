//
//  ConnMsg.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamBufferIn.h"
#import "StreamBufferOut.h"
#import "ConnMsg.h"

@implementation ConnMsg {
  
}

- (id) init {
  self = [super init];
  if (self) {
    _protocol  = 0;
    _timeout   = 30000;
    _lastXid   = 0;
    _sessionId = 0;
    _passwd = [@"" stringByPaddingToLength:16 withString: @"\0" startingAtIndex:0];
    _readonly = false;
  }
  return self;
}

- (NSData *) serialize {
  
  StreamBufferOut *data = [[StreamBufferOut alloc] init];
  
  [data appendInt:self.protocol];
  [data appendLong:self.lastXid];
  [data appendInt:self.timeout];
  [data appendLong:self.sessionId];
  [data appendBuffer:self.passwd];
  [data appendBool:self.readonly];
  
  return [data buffer];
}

- (void) deserialize:(NSData *) incoming {
  
  StreamBufferIn *data = [[StreamBufferIn alloc] initWithNSData:incoming];
  
  self.protocol = [data readInt];
  self.timeout = [data readInt];
  self.sessionId = [data readLong];
  
  NSLog(@"protocol=%u, lastXid=%llu, timeout=%u, sessionId=%llu, sessionId=0x%02llx", self.protocol, self.lastXid, self.timeout, self.sessionId, self.sessionId);
}

@end
