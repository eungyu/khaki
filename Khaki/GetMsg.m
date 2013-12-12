//
//  GetMsg.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "GetMsg.h"
#import "StreamBufferOut.h"
#import "StreamBufferIn.h"

@implementation GetMsg {
  
}

- (id) init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (NSData *) serialize {
  StreamBufferOut *data = [[StreamBufferOut alloc] init];
  
  [data appendInt:2];  // xid,  hacking for now
  [data appendInt:4];  // type, hacking for now
  
  [data appendBuffer:self.path];
  [data appendBool:false];
  return [data getDataBuffer];
}

- (void) deserialize:(NSData *)incoming {
  StreamBufferIn *data = [[StreamBufferIn alloc] initWithNSData:incoming];
  
  self.content = [data readBuffer];
  
  NSLog(@"Content = %@", self.content);
}

@end