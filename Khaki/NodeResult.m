//
//  ZkResult.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import "NodeResult.h"

@implementation NodeResult

- (id) init {
  self = [super init];
  if (self) {
    _data = nil;
    _stat = nil;
  }
  return self;
}

@end
