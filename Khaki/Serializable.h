//
//  Serializable.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamOutBuffer.h"
#import <Foundation/Foundation.h>

@protocol Serializable <NSObject>

- (void) serialize:(StreamOutBuffer *) buf;

@end
