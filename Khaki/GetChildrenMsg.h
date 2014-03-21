//
//  GetChildrenMsg.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Serializable.h"
#import "Deserializable.h"

#import "Stat.h"

@interface GetChildrenMsg : NSObject<Serializable, Deserializable>

@property bool watch;
@property Stat *stat;
@property NSArray *children;
@property NSString *path;

- (void) serialize:(StreamOutBuffer *) buf;
- (void) deserialize:(StreamInBuffer *) buf;

@end
