//
//  GetMsg.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Stat.h"
#import "Serializable.h"
#import "Deserializable.h"
#import <Foundation/Foundation.h>

@interface GetMsg : NSObject<Serializable, Deserializable>

@property Stat *stat;
@property NSString *path;
@property NSString *content;
@property bool watch;

- (void) serialize:(StreamOutBuffer *) buf;
- (void) deserialize:(StreamInBuffer *) buf;

@end

