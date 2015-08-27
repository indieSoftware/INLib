//
//  NSBundleTests.m
//  INLibExample
//
//  Created by Sven Korset on 10.07.15.
//  Copyright (c) 2015 indie-Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface NSBundleTests : XCTestCase

@end

@implementation NSBundleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - NSBundle+INExtensions methods

- (void)test_bundleVersion {
    NSString *expect = @"31";
    NSString *result = [NSBundle bundleVersion];
    XCTAssert([expect isEqualToString:result], @"'%@' was expected, but is '%@'", expect, result);
}

- (void)test_bundleShortVersion {
    NSString *expect = @"1.0";
    NSString *result = [NSBundle bundleShortVersion];
    XCTAssert([expect isEqualToString:result], @"'%@' was expected, but is '%@'", expect, result);
}

- (void)test_bundleIdentifier {
    NSString *expect = @"de.indie-software.INLib";
    NSString *result = [NSBundle bundleIdentifier];
    XCTAssert([expect isEqualToString:result], @"'%@' was expected, but is '%@'", expect, result);
}


@end
