//
//  StreamBufferIn.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Deserializable;

@interface StreamInBuffer : NSObject

- (id) initWithNSData:(NSData *) data;
- (int) readInt;
- (long) readLong;
- (bool) readBool;
- (NSString *) readBuffer;
- (void) readRecord:(id<Deserializable>)record;

@end
