//
//  PendingMessage.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface PendingMessageQueue : NSObject

enum pending_status {
  PENDING_WAITING = 0,
  PENDING_ARRIVED = 1
};

- (Response *) waitForResponse:(int) xid;
- (void) submit:(int) xid with:(Response *)data;

@end
