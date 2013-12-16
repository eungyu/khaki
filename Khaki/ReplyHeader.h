//
//  ReplyHeader.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Deserializable.h"
#import <Foundation/Foundation.h>

@interface ReplyHeader : NSObject<Deserializable>

@property int  xid;
@property long zxid;
@property int  error;

- (void) deserialize:(StreamInBuffer *) buf;
+ (int) getHeaderLength;

@end
