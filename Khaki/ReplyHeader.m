//
//  ReplyHeader.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamBufferIn.h"
#import "ReplyHeader.h"

@implementation ReplyHeader

- (void) deserialize:(NSData *) incoming {
  StreamBufferIn *data = [[StreamBufferIn alloc] initWithNSData:incoming];
  
  self.xid = [data readInt];
  self.zxid = [data readLong];
  self.error = [data readInt];
  
  // NSLog(@"REPLY for xid=%d (zxid=%ld, error=%d)", self.xid, self.zxid, self.error);
}

+ (int) getHeaderLength {
  return sizeof(int) + sizeof(long) + sizeof(int);
}

@end
