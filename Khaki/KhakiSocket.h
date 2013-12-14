//
//  KhakiSocket.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KhakiSocket : NSObject<NSStreamDelegate>

@property (readwrite) bool connected;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

@property (nonatomic, readonly) dispatch_semaphore_t writability;
@property (nonatomic, readonly) dispatch_semaphore_t readability;

- (void)connectToHost:(NSString *) host onPort:(NSInteger) port;
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;

- (NSInteger) writeBytes:(const void *) bytes withMaxLen:(NSInteger) maxlen;
- (NSInteger) readBytesToBuffer:(uint8_t *) buf withMaxLen:(NSInteger) maxlen;

@end
