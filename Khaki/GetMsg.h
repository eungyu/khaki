//
//  GetMsg.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMsg : NSObject

@property NSString *path;
@property NSString *content;

- (NSData *) serialize;
- (void) deserialize:(NSData *) incoming;

@end

