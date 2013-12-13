//
//  Khaki.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Khaki.h"

@implementation Khaki {
  bool _connected;
}

- (id) initWithZkConnectString:(NSString *) zkAddr {
  self = [super init];
  if (self) {
    NSArray *parts = [zkAddr componentsSeparatedByString:@":"];

    _port = 2181;
    _host = [parts objectAtIndex:0];

    if ([parts count] > 1) {
      _port = [[parts objectAtIndex:1] intValue];
    }
  }
  return self;
}


- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {

}

@end
