// NSArrayTests.m
//
// Copyright (c) 2014 Sven Korset
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <XCTest/XCTest.h>

@interface Helper : NSObject

@property (nonatomic, assign) NSInteger value;

+ (instancetype)helperWithValue:(NSInteger)value;

@end

@implementation Helper

+ (instancetype)helperWithValue:(NSInteger)value {
    Helper *helper = [[self alloc] init];
    helper.value = value;
    return helper;
}

@end


@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - hasElements

- (void)test_hasElements_onArrayWithElements_isYes {
    NSArray *array = [NSArray arrayWithObject:@"First"];
    XCTAssert([array hasElements] == YES, @"A array with one element should return YES when asked wheter it hasElements");
    
    array = [NSArray arrayWithObjects:@"First", @"Second", nil];
    XCTAssert([array hasElements] == YES, @"A array with two elements should return YES when asked wheter it hasElements");
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i++) {
        [mutableArray addObject:@(i)];
    }
    XCTAssert([mutableArray hasElements] == YES, @"A mutable array with 10 elements should return YES when asked wheter it hasElements");
}

- (void)test_hasElements_onEmptyArray_isNo {
    NSArray *array = [NSArray array];
    XCTAssert([array hasElements] == NO, @"An empty array should return NO when asked wheter it hasElements");
}

- (void)test_hasElements_onNil_isNo {
    NSArray *nilArray = nil;
    XCTAssert([nilArray hasElements] == NO, @"hasElements on nil should return NO");
}


#pragma mark - arrayReversed

- (void)test_arrayReversed_onArrayWithElements_returnsReversedArray {
    NSArray *array = @[[Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1], [Helper helperWithValue:0]];
    NSArray *reversedArray = [array arrayReversed];
    XCTAssert(reversedArray != nil, @"The returned array is nil, but should be not nil");
    XCTAssert(reversedArray.count == array.count, @"The returned and original array do not have the same amount of elements");
    for (NSUInteger i = 0; i < reversedArray.count; i++) {
        Helper *object = reversedArray[i];
        XCTAssert(object.value == i, @"The element on index %d in the sorted array is %d, but should be %d", i, i, object.value);
    }
}

- (void)test_arrayReversed_onArrayWithOneElement_returnsArrayWithTheElement {
    NSArray *array = @[[Helper helperWithValue:1]];
    NSArray *reversedArray = [array arrayReversed];
    XCTAssert(reversedArray != nil, @"The returned array is nil, but should be not nil");
    XCTAssert(reversedArray.count == 1, @"The returned array should have one element");
    XCTAssert(((Helper *)reversedArray[0]).value == 1, @"The returned array's element is not corrrect");
}

- (void)test_arrayReversed_onEmptyArray_returnsEmptyArray {
    NSArray *array = @[];
    NSArray *reversedArray = [array arrayReversed];
    XCTAssert(reversedArray != nil, @"The returned array is nil, but should be not nil");
    XCTAssert(reversedArray.count == 0, @"The returned array should have no elements");
}


#pragma mark - arraySortedWithKey:ascending:

- (void)test_arraySortedWithKey_ascending_onUnsortedArray_returnsSortedArray {
    NSArray *expectedArray = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSArray *originalArray = @[expectedArray[3], expectedArray[1], expectedArray[2], expectedArray[0]];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");

    expectedArray = @[[Helper helperWithValue:4], [Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1]];
    originalArray = @[expectedArray[2], expectedArray[1], expectedArray[3], expectedArray[0]];
    sortedArray = [originalArray arraySortedWithKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithOneElement_returnsArrayWithTheElement {
    NSArray *expectedArray = @[[Helper helperWithValue:1]];
    NSArray *originalArray = @[expectedArray[0]];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
    
    sortedArray = [originalArray arraySortedWithKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onEmptyArray_returnsEmptyArray {
    NSArray *expectedArray = @[];
    NSArray *originalArray = @[];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
    
    sortedArray = [originalArray arraySortedWithKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithUnknownKey_throwsException {
    NSArray *array = @[[Helper helperWithValue:2], [Helper helperWithValue:3]];
    XCTAssertThrows([array arraySortedWithKey:@"unknownProperty" ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedWithKey:@"unknownProperty" ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithNilOrEmptyKey_throwsException {
    NSArray *array = @[[Helper helperWithValue:2], [Helper helperWithValue:3]];
    XCTAssertThrows([array arraySortedWithKey:nil ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedWithKey:nil ascending:NO], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedWithKey:@"" ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedWithKey:@"" ascending:NO], @"The method should throw an exception because the property is unknown for sorting");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithAscendingSortedElements_andAscendingSort_returnsArrayWithSameOrder {
    NSArray *expectedArray = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSArray *originalArray = [NSArray arrayWithArray:expectedArray];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithDescendingSortedElements_andDescendingSort_returnsArrayWithSameOrder {
    NSArray *expectedArray = @[[Helper helperWithValue:4], [Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1]];
    NSArray *originalArray = [NSArray arrayWithArray:expectedArray];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithAscendingSortedElements_andDescendingSort_returnsInvertedArray {
    NSArray *originalArray = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSArray *expectedArray = [originalArray arrayReversed];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithDescendingSortedElements_andAscendingSort_returnsInvertedArray {
    NSArray *originalArray = @[[Helper helperWithValue:4], [Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1]];
    NSArray *expectedArray = [originalArray arrayReversed];
    NSArray *sortedArray = [originalArray arraySortedWithKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}


#pragma mark - firstObjectPassingTest:

- (void)test_firstObjectPassingTest_onFilledArrayWithElement_returnsElement {
    Helper *expectedResult = [Helper helperWithValue:2];
    NSArray *array = @[[Helper helperWithValue:1], expectedResult, [Helper helperWithValue:3]];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 2) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %d is not that one which was expected (value of %d)", result.value, expectedResult.value);
}

- (void)test_firstObjectPassingTest_onFilledArrayWithTwoElements_returnsFirstElement {
    Helper *expectedResult = [Helper helperWithValue:2];
    NSArray *array = @[[Helper helperWithValue:1], expectedResult, [Helper helperWithValue:3], [Helper helperWithValue:2]];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 2) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %d is not that one which was expected (value of %d)", result.value, expectedResult.value);
}

- (void)test_firstObjectPassingTest_onFilledArrayWithoutElement_returnsNil {
    Helper *expectedResult = nil;
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3]];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 0) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %d is not that one which was expected (nil)", result.value);
}

- (void)test_firstObjectPassingTest_onEmptyArray_returnsNil {
    Helper *expectedResult = nil;
    NSArray *array = @[];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 0) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %d is not that one which was expected (nil)", result.value);
}


#pragma mark - random

// TODO add tests


@end
