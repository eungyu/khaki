//
//  StreamBufferOut.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StreamBufferOut : NSObject

- (void) appendInt:(uint32_t) val;
- (void) appendLong:(uint64_t) val;
- (void) appendBool:(bool) val;
- (void) appendBuffer:(NSString *)string;
- (NSData *) getDataBuffer;

@end
