//
//  KhakiSocket.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KhakiSocket : NSObject<NSStreamDelegate>

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

@property (nonatomic, retain) dispatch_semaphore_t writability;
@property (nonatomic, retain) dispatch_semaphore_t readability;

@property bool connected;

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;

@end
