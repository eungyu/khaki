//
//  GetMsg.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "ZooMessage.h"
#import <Foundation/Foundation.h>

@interface GetMsg : NSObject<ZooMessage>

@property NSString *path;
@property NSString *content;

- (NSData *) serialize;
- (void) deserialize:(NSData *) incoming;

@end

