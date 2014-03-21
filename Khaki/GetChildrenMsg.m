//
//  GetChildrenMsg.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import "GetChildrenMsg.h"

@implementation GetChildrenMsg {
  
}


- (id) init {
  self = [super init];
  if (self) {
    _children = nil;
    _path = nil;
    _watch = false;
  }
  return self;
}

- (void) serialize:(StreamOutBuffer *) buf {
  [buf appendBuffer:self.path];
  [buf appendBool:self.watch];
}

- (void) deserialize:(StreamInBuffer *) buf {
  
  int numChildren = [buf readInt];
  if (numChildren < 0)
  {
    return;
  }
    
  NSMutableArray *children = [NSMutableArray arrayWithCapacity:numChildren];
  for (int i=0;i<numChildren;i++) {
    NSString *znode = [buf readBuffer];
    [children addObject:znode];
  }
  
  self.children = [NSArray arrayWithArray:children];
  
  Stat *stat = [[Stat alloc] init];
  [buf readRecord:stat];
  self.stat = stat;
  
  [stat printDetail];

}

@end
