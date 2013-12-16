//
//  ConnMsg.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Serializable.h"
#import "Deserializable.h"
#import <Foundation/Foundation.h>

@interface ConnMsg : NSObject<Serializable, Deserializable>

@property uint32_t protocol;
@property uint64_t lastXid;
@property uint32_t timeout;
@property uint64_t sessionId;

@property NSString *passwd;
@property bool readonly;

- (void) serialize:(StreamOutBuffer *) buf;
- (void) deserialize:(StreamInBuffer *) buf;

@end
