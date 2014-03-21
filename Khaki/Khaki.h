//
//  Khaki.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeResult.h"
#import "ChildrenResult.h"

#import "WatcherEvent.h"

@interface Khaki : NSObject

@property (nonatomic, readonly, copy) NSString *host;
@property (nonatomic, readonly)       NSInteger port;

- (id) initWithZkConnectString:(NSString *) zkAddr;
- (void) connect;

- (NodeResult *) getData: (NSString *) path withWatcher:(void(^)(WatcherEvent *)) watcherFn;

- (ChildrenResult *) getChildren: (NSString *) path withWatcher:(void(^)(WatcherEvent *)) watcherFn;

@end
