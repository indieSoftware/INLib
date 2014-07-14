//
//  NSDictionaryTests.m
//  INLibExample
//
//  Created by Sven Korset on 14.07.14.
//  Copyright (c) 2014 indie-Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSDictionaryTests : XCTestCase

@end

@implementation NSDictionaryTests

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


#pragma mark - Getter methods

- (void)test_boolForKey {
    BOOL value = true;
    NSDictionary *dict = @{@"Key": @(value)};
    BOOL result = [dict boolForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_intForKey {
    NSInteger value = 2;
    NSDictionary *dict = @{@"Key": @(value)};
    NSInteger result = [dict intForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_floatForKey {
    float value = 4.4f;
    NSDictionary *dict = @{@"Key": @(value)};
    float result = [dict floatForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_doubleForKey {
    double value = 2.2;
    NSDictionary *dict = @{@"Key": @(value)};
    double result = [dict doubleForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_longForKey {
    long value = 43;
    NSDictionary *dict = @{@"Key": @(value)};
    long result = [dict intForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_stringForKey {
    NSString *value = @"Value";
    NSDictionary *dict = @{@"Key": value};
    NSString *result = [dict stringForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_arrayForKey {
    NSArray *value = @[@"Foo"];
    NSDictionary *dict = @{@"Key": value};
    NSArray *result = [dict arrayForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_dictForKey {
    NSDictionary *value = @{@"Foo": @"Bar"};
    NSDictionary *dict = @{@"Key": value};
    NSDictionary *result = [dict dictForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}

- (void)test_numberForKey {
    NSNumber *value = @(34);
    NSDictionary *dict = @{@"Key": value};
    NSNumber *result = [dict numberForKey:@"Key"];
    XCTAssertEqual(result, value, @"result not as expected");
}


#pragma mark - descriptionWithStart:pairFormatter:lastPairFormatter:end:keys:printKeysAfterValues:

- (void)test_descriptionWithStart_pairFormatter_lastPairFormatter_end_keys_printKeysAfterValues {
    NSString *start = @"A";
    NSString *pairFormatter = @"B%@C%@D";
    NSString *lastPairFormatter = @"E%@F%@G";
    NSString *end = @"H";
    NSDictionary *dict = @{@"1": @"One", @"2": @"Two"};
    NSArray *keys = @[@"1", @"2"];
    NSString *expected = @"AB1COneDE2FTwoGH";
    NSString *result = [dict descriptionWithStart:start pairFormatter:pairFormatter lastPairFormatter:lastPairFormatter end:end keys:keys printKeysAfterValues:NO];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);

    keys = @[@"2", @"1"];
    expected = @"AB2CTwoDE1FOneGH";
    result = [dict descriptionWithStart:start pairFormatter:pairFormatter lastPairFormatter:lastPairFormatter end:end keys:keys printKeysAfterValues:NO];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);

    keys = @[];
    expected = @"AH";
    result = [dict descriptionWithStart:start pairFormatter:pairFormatter lastPairFormatter:lastPairFormatter end:end keys:keys printKeysAfterValues:NO];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);

    start = @"{\n";
    pairFormatter = @"    %@ = %@;\n";
    lastPairFormatter = @"    %@ = %@;\n";
    end = @"}";
    dict = @{@"1": @"One"};
    keys = @[@"1"];
    expected = [dict description];
    result = [dict descriptionWithStart:start pairFormatter:pairFormatter lastPairFormatter:lastPairFormatter end:end keys:keys printKeysAfterValues:NO];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);
    
}


@end
