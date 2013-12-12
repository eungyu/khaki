//
//  OpCode.h
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpCode : NSObject

enum OpCode {
  OP_NOTIFICATION = 0,
  OP_CREATE = 1,
  OP_DELETE = 2,
  OP_EXISTS = 3,
  OP_GETDATA = 4,
  OP_SETDATA = 5,
  OP_GETACL = 6,
  OP_SETACL = 7,
  OP_GETCHILDREN = 8,
  OP_SYNC = 9,
  OP_PING = 11,
  OP_GETCHILDREN2 = 12,
  OP_CHECK = 13,
  OP_MULTI = 14,
  OP_CREATE2 = 15,
  OP_RECONFIG = 16,
  OP_AUTH = 100,
  OP_SETWATCHES = 101,
  OP_SASL = 102,
  OP_CREATESESSION = -10,
  OP_CLOSESESSION = -11,
  OP_ERROR = -1
};

@end