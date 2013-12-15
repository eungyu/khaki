//
//  RequestHeader.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "RequestHeader.h"
#import "StreamBufferOut.h"

@implementation RequestHeader

- (NSData *) serialize {
  StreamBufferOut *data = [[StreamBufferOut alloc] init];
  
  [data appendInt:self.xid];   // xid
  [data appendInt:self.type];  // type
  
  return [data buffer];
}

@end
