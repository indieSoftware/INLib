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

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:self.class]) {
        return NO;
    }
    Helper *helper = object;
    return helper.value == self.value;
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


#pragma mark - descriptionWithStart:elementFormatter:lastElementFormatter:end:

- (void)test_descriptionWithStart_elementFormatter_lastElementFormatter_end {
    NSString *start = @"A";
    NSString *elementFormatter = @"B%@C";
    NSString *lastElementFormatter = @"D%@E";
    NSString *end = @"F";
    NSArray *array = @[@"1", @"2", @"3"];
    NSString *expected = @"AB1CB2CD3EF";
    NSString *result = [array descriptionWithStart:start elementFormatter:elementFormatter lastElementFormatter:lastElementFormatter end:end];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);

    array = @[];
    expected = @"AF";
    result = [array descriptionWithStart:start elementFormatter:elementFormatter lastElementFormatter:lastElementFormatter end:end];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);

    start = @"(\n";
    elementFormatter = @"    %@,\n";
    lastElementFormatter = @"    %@\n";
    end = @")";
    array = @[@"Foo", @"Bar"];
    expected = [array description];
    result = [array descriptionWithStart:start elementFormatter:elementFormatter lastElementFormatter:lastElementFormatter end:end];
    XCTAssert([result isEqualToString:expected], @"Result string '%@' is not as expected '%@'", result, expected);
}


#pragma mark - arrayReversed

- (void)test_arrayReversed_onArrayWithElements_returnsReversedArray {
    NSArray *array = @[[Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1], [Helper helperWithValue:0]];
    NSArray *reversedArray = [array arrayReversed];
    XCTAssert(reversedArray != nil, @"The returned array is nil, but should be not nil");
    XCTAssert(reversedArray.count == array.count, @"The returned and original array do not have the same amount of elements");
    for (NSUInteger i = 0; i < reversedArray.count; i++) {
        Helper *object = reversedArray[i];
        XCTAssert(object.value == i, @"The element on index %ld in the sorted array is %ld, but should be %ld", (long)i, (long)i, (long)object.value);
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

- (void)test_arraySortedByKey_ascending_onUnsortedArray_returnsSortedArray {
    NSArray *expectedArray = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSArray *originalArray = @[expectedArray[3], expectedArray[1], expectedArray[2], expectedArray[0]];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");

    expectedArray = @[[Helper helperWithValue:4], [Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1]];
    originalArray = @[expectedArray[2], expectedArray[1], expectedArray[3], expectedArray[0]];
    sortedArray = [originalArray arraySortedByKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithOneElement_returnsArrayWithTheElement {
    NSArray *expectedArray = @[[Helper helperWithValue:1]];
    NSArray *originalArray = @[expectedArray[0]];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
    
    sortedArray = [originalArray arraySortedByKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onEmptyArray_returnsEmptyArray {
    NSArray *expectedArray = @[];
    NSArray *originalArray = @[];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
    
    sortedArray = [originalArray arraySortedByKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithUnknownKey_throwsException {
    NSArray *array = @[[Helper helperWithValue:2], [Helper helperWithValue:3]];
    XCTAssertThrows([array arraySortedByKey:@"unknownProperty" ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedByKey:@"unknownProperty" ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithNilOrEmptyKey_throwsException {
    NSArray *array = @[[Helper helperWithValue:2], [Helper helperWithValue:3]];
    XCTAssertThrows([array arraySortedByKey:nil ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedByKey:nil ascending:NO], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedByKey:@"" ascending:YES], @"The method should throw an exception because the property is unknown for sorting");
    XCTAssertThrows([array arraySortedByKey:@"" ascending:NO], @"The method should throw an exception because the property is unknown for sorting");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithAscendingSortedElements_andAscendingSort_returnsArrayWithSameOrder {
    NSArray *expectedArray = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSArray *originalArray = [NSArray arrayWithArray:expectedArray];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:YES];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithDescendingSortedElements_andDescendingSort_returnsArrayWithSameOrder {
    NSArray *expectedArray = @[[Helper helperWithValue:4], [Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1]];
    NSArray *originalArray = [NSArray arrayWithArray:expectedArray];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithAscendingSortedElements_andDescendingSort_returnsInvertedArray {
    NSArray *originalArray = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSArray *expectedArray = [originalArray arrayReversed];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:NO];
    XCTAssert([expectedArray isEqualToArray:sortedArray], @"The array is not sorted as expected");
}

- (void)test_arraySortedWithKey_ascending_onArrayWithDescendingSortedElements_andAscendingSort_returnsInvertedArray {
    NSArray *originalArray = @[[Helper helperWithValue:4], [Helper helperWithValue:3], [Helper helperWithValue:2], [Helper helperWithValue:1]];
    NSArray *expectedArray = [originalArray arrayReversed];
    NSArray *sortedArray = [originalArray arraySortedByKey:@"value" ascending:YES];
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
    XCTAssert(result == expectedResult, @"The returned object with value %ld is not that one which was expected (value of %ld)", (long)result.value, (long)expectedResult.value);
}

- (void)test_firstObjectPassingTest_onFilledArrayWithTwoElements_returnsFirstElement {
    Helper *expectedResult = [Helper helperWithValue:2];
    NSArray *array = @[[Helper helperWithValue:1], expectedResult, [Helper helperWithValue:3], [Helper helperWithValue:2]];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 2) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %ld is not that one which was expected (value of %ld)", (long)result.value, (long)expectedResult.value);
}

- (void)test_firstObjectPassingTest_onFilledArrayWithoutElement_returnsNil {
    Helper *expectedResult = nil;
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3]];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 0) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %ld is not that one which was expected (nil)", (long)result.value);
}

- (void)test_firstObjectPassingTest_onEmptyArray_returnsNil {
    Helper *expectedResult = nil;
    NSArray *array = @[];
    Helper *result = [array firstObjectPassingTest:^BOOL(id obj) {
        if (((Helper *)obj).value == 0) return YES;
        return NO;
    }];
    XCTAssert(result == expectedResult, @"The returned object with value %ld is not that one which was expected (nil)", (long)result.value);
}


#pragma mark - random

- (void)test_arrayWithRandomizedOrder_onEmptyArray_returnsEmptyArray {
    NSArray *array = @[];
    NSArray *result = [array arrayWithRandomizedOrder];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, 0, @"The result array should have 0 elements");
}

- (void)test_arrayWithRandomizedOrder_withOneElement_returnsArrayWithSameElement {
    NSArray *array = @[[Helper helperWithValue:1]];
    NSArray *result = [array arrayWithRandomizedOrder];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, 1, @"The result array should have 1 element");
    XCTAssertEqual(result[0], array[0], @"The result array should have 1 element");
}

- (void)test_arrayWithRandomizedOrder_withSomeElements_returnsArrayWithSameNumberOfElement {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3]];
    NSArray *result = [array arrayWithRandomizedOrder];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, array.count, @"The result array should have the same number of elements");
}

- (void)test_arrayWithRandomElementsRemoved_withSomeElements_andANumberInBounds_returnsAnArrayWithCorrectNumberOfElements {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSUInteger amoundToRemove = 2;
    NSArray *result = [array arrayWithRandomElementsRemoved:amoundToRemove];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, array.count - amoundToRemove, @"The result array should have the correct number of elements");
    amoundToRemove = 3;
    result = [array arrayWithRandomElementsRemoved:amoundToRemove];
    XCTAssertEqual(result.count, array.count - amoundToRemove, @"The result array should have the correct number of elements");
}

- (void)test_arrayWithRandomElementsRemoved_withSomeElements_andZeroToRemove_returnsTheSameArray {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSUInteger amoundToRemove = 0;
    NSArray *result = [array arrayWithRandomElementsRemoved:amoundToRemove];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, array.count - amoundToRemove, @"The result array should have the correct number of elements");
    XCTAssert([array isEqualToArray:result], @"The order should be unchanged");
}

- (void)test_arrayWithRandomElementsRemoved_withSomeElements_andTheSameAmountToRemove_returnsAnEmptyArray {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSUInteger amoundToRemove = array.count;
    NSArray *result = [array arrayWithRandomElementsRemoved:amoundToRemove];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, 0, @"The result array should be empty");
}

- (void)test_arrayWithRandomElementsChosen_withSomeElements_andANumberInBounds_returnsAnArrayWithCorrectNumberOfElements {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSUInteger amoundToKeep = 2;
    NSArray *result = [array arrayWithRandomElementsChosen:amoundToKeep];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, amoundToKeep, @"The result array should have the correct number of elements");
    amoundToKeep = 3;
    result = [array arrayWithRandomElementsChosen:amoundToKeep];
    XCTAssertEqual(result.count, amoundToKeep, @"The result array should have the correct number of elements");
}

- (void)test_arrayWithRandomElementsChosen_withSomeElements_andAllToKeep_returnsTheSameArray {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSUInteger amoundToKeep = array.count;
    NSArray *result = [array arrayWithRandomElementsChosen:amoundToKeep];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, amoundToKeep, @"The result array should have the correct number of elements");
    XCTAssert([array isEqualToArray:result], @"The order should be unchanged");
}

- (void)test_arrayWithRandomElementsChosen_withSomeElements_andZeroToKeep_returnsAnEmptyArray {
    NSArray *array = @[[Helper helperWithValue:1], [Helper helperWithValue:2], [Helper helperWithValue:3], [Helper helperWithValue:4]];
    NSUInteger amoundToKeep = 0;
    NSArray *result = [array arrayWithRandomElementsChosen:amoundToKeep];
    XCTAssert(result != nil, @"The result should not be nil");
    XCTAssertEqual(result.count, 0, @"The result array should be empty");
}


@end
