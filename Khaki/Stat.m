//
//  Stat.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/14/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Stat.h"
#import "StreamInBuffer.h"

@implementation Stat

- (void) deserialize:(StreamInBuffer *) buf {
  self.czxid = [buf readLong];
  self.mzxid = [buf readLong];
  self.ctime = [buf readLong];
  self.mtime = [buf readLong];
  self.version = [buf readInt];
  self.cversion = [buf readInt];
  self.aversion = [buf readInt];
  self.ephemeralOwner = [buf readLong];
  self.dataLength = [buf readInt];
  self.numChildren = [buf readInt];
  self.pzxid = [buf readLong];
}

- (void) printDetail {
  NSLog(@"czxid=%ld,\n \
          mzxid=%ld,\n \
          ctime=%ld,\n \
          mtime=%ld,\n \
          version=%d,\n \
          cversion=%d,\n \
          aversion=%d,\n \
          ephemeralOwner=%ld,\n \
          dataLength=%d,\n \
          numChildren=%d,\n \
          pzxid=%ld",
          self.czxid,
          self.mzxid,
          self.ctime,
          self.mtime,
          self.version,
          self.cversion,
          self.aversion,
          self.ephemeralOwner,
          self.dataLength,
          self.numChildren,
          self.pzxid);
}

@end
