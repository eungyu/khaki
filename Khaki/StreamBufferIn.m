//
//  StreamBufferIn.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "StreamBufferIn.h"

@implementation StreamBufferIn {
  NSData *_data;
  int _pos;
}

- (id) initWithNSData:(NSData *) data {
  self = [super init];
  if (self)
  {
    _pos = 0;
    _data = data;
  }
  return self;
}

- (int) readInt {
  const void * bytes = [_data bytes];
  int val = OSReadBigInt32(bytes, _pos);
  _pos += sizeof(int);
  
  return val;
}

- (long) readLong {
  const void *bytes = [_data bytes];
  long val = OSReadBigInt64(bytes, _pos);
  _pos += sizeof(long);
  
  return val;
}

- (bool) readBool {
  bool val;
  NSRange range = {_pos, 1};
  [_data getBytes:&val range:range];
  _pos += sizeof(bool);
  
  return val;
}

- (NSString *) readBuffer {
  uint32_t len = [self readInt];
  
  char buf[len];
  NSRange range = {_pos, len};
  
  [_data getBytes:&buf range:range];
  return [NSString stringWithCString:buf encoding:NSASCIIStringEncoding];
}

@end