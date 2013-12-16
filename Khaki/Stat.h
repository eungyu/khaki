//
//  Stat.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Deserializable.h"
#import <Foundation/Foundation.h>

@interface Stat : NSObject<Deserializable>

@property long czxid;
@property long mzxid;
@property long ctime;
@property long mtime;
@property int version;
@property int cversion;
@property int aversion;
@property long ephemeralOwner;
@property int dataLength;
@property int numChildren;
@property long pzxid;

- (void) deserialize:(StreamInBuffer *) buf;
- (void) printDetail;

@end
