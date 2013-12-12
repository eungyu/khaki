//
//  StreamBufferOut.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamBufferOut.h"

@implementation StreamBufferOut {
  NSMutableData *_data;
}

- (id) init {
  self = [super init];
  if (self)
  {
    uint32_t len = 0x0;
    _data = [NSMutableData dataWithBytes:&len length:sizeof(uint32_t)];
  }
  return self;
}

- (void) appendInt:(uint32_t) val {
  uint32_t networkOrderVal = CFSwapInt32HostToBig(val);
  [_data appendBytes:&networkOrderVal length:sizeof(uint32_t)];
}

- (void) appendLong:(uint64_t) val {
  uint64_t networkOrderVal = CFSwapInt64HostToBig(val);
  [_data appendBytes:&networkOrderVal length:sizeof(uint64_t)];
}

- (void) appendBool:(bool) val {
  [_data appendBytes:&val length:sizeof(bool)];
}

- (void) appendBuffer:(NSString *) buffer {
  uint32_t len = CFSwapInt32HostToBig((uint32_t) buffer.length);
  const char *buf = [buffer UTF8String];
  
  [_data appendBytes:&len length:sizeof(uint32_t)];
  [_data appendBytes:buf length:buffer.length];
}

- (NSData *) getDataBuffer {
  uint32_t len = CFSwapInt32HostToBig(((uint32_t) _data.length) - sizeof(uint32_t));
  NSRange range = {0, sizeof(uint32_t)};
  
  [_data replaceBytesInRange:range withBytes:&len];
  return _data;
}

@end
