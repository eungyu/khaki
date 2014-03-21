//
//  Response.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplyHeader.h"

@interface Response : NSObject

@property ReplyHeader *header;
@property NSData *data;

@end
