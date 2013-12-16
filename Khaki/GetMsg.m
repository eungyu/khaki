//
//  GetMsg.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Stat.h"
#import "GetMsg.h"
#import "StreamOutBuffer.h"
#import "StreamInBuffer.h"

@implementation GetMsg {

}

- (id) init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (void) serialize:(StreamOutBuffer *) buf {
  [buf appendBuffer:self.path];
  [buf appendBool:false];
}

- (void) deserialize:(StreamInBuffer *) buf {
  Stat *stat = [[Stat alloc] init];

  self.content = [buf readBuffer];
  [buf readRecord:stat];
  
  NSLog(@"Content = %@", self.content);
  [self.stat print];
}

@end