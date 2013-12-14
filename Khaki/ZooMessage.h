//
//  KhakiMessage.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZooMessage

@required

- (NSData *) serialize;
- (void) deserialize:(NSData *) incoming;

@end
