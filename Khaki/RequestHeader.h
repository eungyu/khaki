//
//  RequestHeader.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Serializable.h"
#import <Foundation/Foundation.h>

@interface RequestHeader : NSObject<Serializable>

@property int xid;
@property int type;

- (void) serialize:(StreamOutBuffer *) buf;

@end
