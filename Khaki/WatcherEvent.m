//
//  WatcherEvent.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import "WatcherEvent.h"

@implementation WatcherEvent

- (id) init {
  self = [super init];
  if (self) {
    _type = -1;
    _state = -1;
    _path = nil;
    _stat = nil;
  }
  return self;
}

- (void) serialize:(StreamOutBuffer *) buf {
  [buf appendInt:self.type];
  [buf appendInt:self.state];
  [buf appendBuffer:self.path];
}

- (void) deserialize:(StreamInBuffer *) buf {
  self.type = [buf readInt];
  self.state = [buf readInt];
  self.path = [buf readBuffer];

  Stat *stat = [[Stat alloc] init];

  [buf readRecord:stat];
  self.stat = stat;
}

@end
