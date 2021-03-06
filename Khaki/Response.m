//
//  Response.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import "Response.h"

@implementation Response

- (id) init {
  self = [super init];
  if (self) {
    _data = nil;
    _header = nil;
  }
  return self;
}

- (bool) hasValidResult {
  return (self.header) && (self.header.error == 0);
}

@end
