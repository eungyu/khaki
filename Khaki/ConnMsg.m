//
//  ConnMsg.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamInBuffer.h"
#import "StreamOutBuffer.h"
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

- (void) serialize:(StreamOutBuffer *) buf {
  [buf appendInt:self.protocol];
  [buf appendLong:self.lastXid];
  [buf appendInt:self.timeout];
  [buf appendLong:self.sessionId];
  [buf appendBuffer:self.passwd];
  [buf appendBool:self.readonly];
}

- (void) deserialize:(StreamInBuffer *) buf {
  self.protocol  = [buf readInt];
  self.timeout   = [buf readInt];
  self.sessionId = [buf readLong];
  
  NSLog(@"protocol=%u, lastXid=%llu, timeout=%u, sessionId=%llu, sessionId=0x%02llx", self.protocol, self.lastXid, self.timeout, self.sessionId, self.sessionId);
}

@end
