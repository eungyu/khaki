//
//  KhakiTests.m
//  KhakiTests
//
//  Created by Eun-Gyu Kim on 12/11/13.
//  Copyright (c) 2013 Eun-Gyu Kim. All rights reserved.
//

#import "Khaki.h"
#import <XCTest/XCTest.h>

@interface KhakiTests : XCTestCase

@end

@implementation KhakiTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
  Khaki *khaki = [[Khaki alloc] initWithZkConnectString:@"eungyu.me"];

  NSInteger defaultPort = 2181;
  NSInteger customPort = 12345;
  XCTAssertEqualObjects([khaki host], @"eungyu.me");
  XCTAssertEqual([khaki port], defaultPort);
  
  Khaki *khakiCustomPort = [[Khaki alloc] initWithZkConnectString:@"eungyu.me:12345"];
  XCTAssertEqualObjects([khakiCustomPort host], @"eungyu.me");
  XCTAssertEqual([khakiCustomPort port], customPort);
}

@end
