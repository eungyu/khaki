//
//  Khaki.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Khaki : NSObject<NSStreamDelegate>

@property NSString *host;
@property NSInteger port;

- (id) initWithZkConnectString:(NSString *) zkAddr;

@end
