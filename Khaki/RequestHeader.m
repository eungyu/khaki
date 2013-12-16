//
//  RequestHeader.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "RequestHeader.h"
#import "StreamOutBuffer.h"

@implementation RequestHeader

- (void) serialize:(StreamOutBuffer *) buf {
  [buf appendInt:self.xid];   // xid
  [buf appendInt:self.type];  // type
}

@end
