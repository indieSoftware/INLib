// NSArray+INExtensions.h
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


@interface NSArray (INExtensions)

// ------------------------------------------------------------
/// @name Initializing with Sets

/**
 Creates an array initialized with all objects of the given set in undefined order.
 
 @param set The NSSet with objects to put into this new array.
 @return A new array with the set's objects.
 @see initWithSet:
 */
+ (id)arrayWithSet:(NSSet *)set;


/**
 Initializes an array with all objects of the given set in undefined order.
 
 @param set The NSSet with objects to put into this new array.
 @return A new array with the set's objects.
 */
- (instancetype)initWithSet:(NSSet *)set;


// ------------------------------------------------------------
/// @name Useful additions

/**
 Returns YES if there are any elements in this array, otherwise NO.
 
 This method can even be used when the array itself may be nil,
 because calling a method on nil will return NO and then the array has definetly no elements.
 
 @return YES if the array is not nil and contains any elements.
 */
- (BOOL)hasElements;


/**
 Returns this array in reverse order with the same elements.
 
 @return A new reversed array.
 */
- (NSArray *)arrayReversed;


/**
 Sorts an array by a given property name.
 
 The Array has to contain objects which are Key-Value-Compliant for the given key.
 The objects will be sorted by the given key either in ascending or in descending order.
 The sort will be done by NSArray's sortedArrayUsingDescriptors with a NSSortDescriptor.
 
 @param key The property's name of the objects in the array for which to sort the array.
 @param ascending YES if the new array should be sorted ascending or NO if it should be sorted descending.
 @return A new sorted array with the same objects sorted by the key.
 */
- (NSArray *)arraySortedWithKey:(NSString *)key ascending:(BOOL)ascending;


/**
 Returns the first object which passes the given predicate test.
 
 Internally it uses [NSArray indexOfObjectPassingTest:] method.
 Use with something like
 
    id object = [array firstObjectPassingTest:^BOOL(id obj) { if (...) return YES; else return NO; }];
 
 @param predicate The test which has to return YES for the element to find.
 @return The first object which passes the test or nil if none does.
 @see indexOfObjectPassingTest:
 */
- (id)firstObjectPassingTest:(BOOL (^)(id obj))predicate;



@end
