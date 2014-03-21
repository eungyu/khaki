//
//  WatcherEvent.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Stat.h"
#import "Serializable.h"
#import "Deserializable.h"

@interface WatcherEvent : NSObject<Serializable, Deserializable>

@property int type;
@property int state;
@property NSString *path;

@property Stat *stat;

@end
