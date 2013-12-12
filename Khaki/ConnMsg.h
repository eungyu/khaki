//
//  ConnMsg.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnMsg : NSObject

@property uint32_t protocol;
@property uint64_t lastXid;
@property uint32_t timeout;
@property uint64_t sessionId;

@property NSString *passwd;
@property bool readonly;

- (NSData *) serialize;
- (void) deserialize:(NSData *) data;

@end
