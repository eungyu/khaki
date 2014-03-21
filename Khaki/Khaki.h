//
//  Khaki.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZkResult.h"

@interface Khaki : NSObject

@property (nonatomic, readonly, copy) NSString *host;
@property (nonatomic, readonly)       NSInteger port;

- (id) initWithZkConnectString:(NSString *) zkAddr;
- (void) connect;
- (void) exec;

- (ZkResult *) getData: (NSString *) path;


@end
