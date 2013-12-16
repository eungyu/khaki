//
//  Ping.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Ping.h"
#import "OpCode.h"
#import "StreamOutBuffer.h"
#import "StreamInBuffer.h"

@implementation Ping

- (void) serialize:(StreamOutBuffer *) buf {
  [buf appendInt:-2];       // xid,  hacking for now
  [buf appendInt:OP_PING];  // PING type
}

- (void) deserialize:(StreamInBuffer *) buf {
  int xid   = [buf readInt];
  long zxid = [buf readLong];
  int error = [buf readInt];
  
  NSLog(@"xid=%d, zxid=%ld, error=%d", xid, zxid, error);
}

@end
