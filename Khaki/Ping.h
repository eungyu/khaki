//
//  Ping.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "ZooMessage.h"
#import <Foundation/Foundation.h>

@interface Ping : NSObject<ZooMessage>

- (NSData *) serialize;
- (void) deserialize:(NSData *) incoming;

@end
