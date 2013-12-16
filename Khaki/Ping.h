//
//  Ping.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Serializable.h"
#import "Deserializable.h"
#import <Foundation/Foundation.h>

@interface Ping : NSObject<Serializable, Deserializable>

- (void) serialize:(StreamOutBuffer *) buf;
- (void) deserialize:(StreamInBuffer *) buf;

@end
