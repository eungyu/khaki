//
//  ZkResult.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 3/21/14.
//  Copyright (c) 2014 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stat.h"

@interface ZkResult : NSObject

@property int error;
@property NSString *data;
@property Stat *stat;

@end
