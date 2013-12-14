//
//  KhakiWindowController.m
//  Khaki
//
//  Created by Eun-Gyu Kim on 12/13/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Khaki.h"
#import "KhakiWindowController.h"

@interface KhakiWindowController ()

@end

@implementation KhakiWindowController {
  Khaki *_khaki;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
      _khaki = nil;
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)start:(id)sender {
  if (_khaki != nil) {
    return;
  }
  _khaki = [[Khaki alloc] initWithZkConnectString:@"localhost:2181"];
  [_khaki connect];
  
}




@end
