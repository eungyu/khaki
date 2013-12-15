//
//  RequestHeader.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "ZooMessage.h"
#import <Foundation/Foundation.h>

@interface RequestHeader : NSObject

@property int xid;
@property int type;

- (NSData *) serialize;

@end
