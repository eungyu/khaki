//
//  Deserializable.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamInBuffer.h"
#import <Foundation/Foundation.h>

@protocol Deserializable <NSObject>

- (void) deserialize:(StreamInBuffer *) buf;

@end
