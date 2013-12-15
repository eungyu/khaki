//
//  PendingMessage.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "PendingMessageQueue.h"

@implementation PendingMessageQueue {
  NSMutableDictionary *_lockbox;
  NSMutableDictionary *_databox;
}

- (id) init {
  self = [super init];
  if (self) {
    _lockbox = [[NSMutableDictionary alloc] init];
    _databox = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

- (NSData *) waitForResponse:(int) xid {
  NSString *key = [NSString stringWithFormat:@"%d", xid];
  NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:PENDING_WAITING];
  @synchronized(_lockbox) {
    [_lockbox setObject:lock forKey:key];
  }

  [lock lockWhenCondition:PENDING_ARRIVED];
  
  NSData *data = nil;
  @synchronized(_databox) {
    data = [_databox objectForKey:key];
  }
  
  [lock unlockWithCondition:PENDING_WAITING];
  
  @synchronized(_lockbox) {
    [_lockbox removeObjectForKey:key];
  }

  return data;
}

- (void) submit:(int) xid with:(NSData *)data {
  NSString *key = [NSString stringWithFormat:@"%d", xid];
  
  NSConditionLock *lock = nil;
  @synchronized(_lockbox) {
    lock = [_lockbox objectForKey:key];
  }

  if (lock == nil) {
    NSLog(@"submit lock is null");
  }
  
  [lock lockWhenCondition:PENDING_WAITING];
  
  @synchronized(_databox) {
    [_databox setObject:data forKey:key];
  }
  
  [lock unlockWithCondition:PENDING_ARRIVED];
  return;
}


@end
