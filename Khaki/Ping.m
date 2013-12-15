//
//  Ping.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Ping.h"
#import "OpCode.h"
#import "StreamBufferOut.h"
#import "StreamBufferIn.h"

@implementation Ping

- (NSData *) serialize {
  StreamBufferOut *data = [[StreamBufferOut alloc] init];
  
  [data appendInt:-2];       // xid,  hacking for now
  [data appendInt:OP_PING];  // PING type
  
  return [data buffer];
}

- (void) deserialize:(NSData *) incoming {
  StreamBufferIn *data = [[StreamBufferIn alloc] initWithNSData:incoming];
  
  int xid = [data readInt];
  long zxid = [data readLong];
  int error = [data readInt];
  
  NSLog(@"xid=%d, zxid=%ld, error=%d", xid, zxid, error);
}

@end
