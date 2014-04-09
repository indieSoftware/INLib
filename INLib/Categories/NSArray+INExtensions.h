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

/// Returns true if there are elements in this array, otherwise false.
/// @return NO if the array is empty, otherwise YES.
- (BOOL)hasElements;


/// Creates a deep copy of the array by copying the elements.
/// Each element in the array has to implement the NSCopying protocol.
/// @return A new array with a copy of the elements.
- (NSArray *)arrayCloned;


/// Sorts an array by a given property name.
/// The Array has to contain objects which are Key-Value-Compliant for the given key.
/// The objects will be sorted by the given key either in ascending or in descending order.
/// The sort will be done by NSArray's sortedArrayUsingDescriptors with a NSSortDescriptor.
/// @param key The property's name of the object for which to sort the objects in the array.
/// @param ascending YES if the new array should be sorted ascending or NO if it should be sorted descending.
/// @return A new sorted array with the same objects sorted by the key.
- (NSArray *)arraySortedWithKey:(NSString *)key ascending:(BOOL)ascending;

/// Converts a flat array into one with sections.
/// Each section beginns with the same character of the property the key points to, so the new array will be sectionized by the given property key.
/// The objects in this array have to be Key-Value-Compliant for the given key and the property has to be of the type NSString.
/// @param key The property's name of the object for which the new array will be sectionized. The property has to be of the type NSString because only strings can be sectionized with this method.
/// @return A new sectionized array which can be used by table views.
- (NSArray *)arraySectionizedByKey:(NSString *)key;

/// Converts a sectionized array back into a flat array.
/// The sectionized array has to have exactly only one layer depth, meaning the array itself contains only arrays which on the other hand have the objects. After unsectionizing the main array, all objects will be directly in this array and not in the subarrays anymore.
/// @return The unsectionized array.
/// @see arraySectionizedByKey:
- (NSArray *)arrayUnsectionized;

/// Collects the section titles for a sectionized array.
/// This array has to be sectionized, meaning it contains arrays as sections with objects in it, which has a NSString property which will be named by key.
/// From each section the first element's key-property is taken and the first character is capitalized and put into a new array which will be returned.
/// This method is useful for table views with sections and index titles.
/// @param key The property's name for which to collect the sections indizes from. Normally this is also the key which is used to create the sectionized array.
/// @return An array with the capital letters of the sections.
/// @see arraySectionizedByKey:
- (NSArray *)arrayWithSectionHeadersForKey:(NSString *)key;


/// Converts an int[] array into an NSArray with NSNumber objects inside which holds the int values.
/// @param intArray The primitive int[] array.
/// @param size The size of the int array, meaning how many values the array contrains.
/// @return A new NSArray with the int values as NSNumber objects.
+ (NSArray *)arrayWithIntArray:(int *)intArray ofSize:(int)size;

/// Converts an int[] array into an NSArray with NSNumber objects inside which holds the int values.
/// @param intArray The primitive int[] array.
/// @param size The size of the int array, meaning how many values the array contrains.
/// @return A new NSArray with the int values as NSNumber objects.
- (instancetype)initWithIntArray:(int *)intArray ofSize:(int)size;

/// Converts a NSArray with int values in their NSNumber objects into a primitive int[] array.
/// @param intArray The primitive int[] array into which the int values from this NSArray has to be written. The int array is used as output and any values in it may be overwritten.
/// @param size The size of the int array, meaning how many values the array contrains. This should be the same as count from this NSArray.
- (void)fillIntArray:(int *)intArray ofSize:(int)size;


/// Converts a bool[] array into an NSArray with NSNumber objects inside which holds the bool values.
/// @param boolArray The primitive bool[] array.
/// @param size The size of the bool array, meaning how many values the array contrains.
/// @return A new NSArray with the bool values as NSNumber objects.
+ (NSArray *)arrayWithBoolArray:(BOOL *)boolArray ofSize:(int)size;

/// Converts a bool[] array into an NSArray with NSNumber objects inside which holds the bool values.
/// @param boolArray The primitive bool[] array.
/// @param size The size of the bool array, meaning how many values the array contrains.
/// @return A new NSArray with the bool values as NSNumber objects.
- (instancetype)initWithBoolArray:(BOOL *)boolArray ofSize:(int)size;

/// Converts a NSArray with bool values in their NSNumber objects into a primitive bool[] array.
/// @param boolArray The primitive bool[] array into which the bool values from this NSArray has to be written. The bool array is used as output and any values in it may be overwritten.
/// @param size The size of the bool array, meaning how many values the array contrains. This should be the same as count from this NSArray.
- (void)fillBoolArray:(BOOL *)boolArray ofSize:(int)size;


/// Creates an array initialized with all objects of the given set in undefined order.
/// @param set The NSSet with objects to put into this new array.
/// @return A new array with the set's objects.
+ (id)arrayWithSet:(NSSet *)set;

/// Creates an array initialized with all objects of the given set in undefined order.
/// @param set The NSSet with objects to put into this new array.
/// @return A new array with the set's objects.
- (instancetype)initWithSet:(NSSet *)set;

/// Returns the first object which passes the given predicate test.
/// Use with [array firstObjectPassingTest:^BOOL(id obj) {...}].
/// @param predicate The test which has to return YES for the element to find.
/// @return The first object which passes the test or nil if none does.
/// @see indexOfObjectPassingTest:
- (id)firstObjectPassingTest:(BOOL (^)(id obj))predicate;


@end


#pragma mark -


@interface NSMutableArray (IExtensions)


/// Removes the first object in this array. Raises an NSRangeException if there are no objects in the array.
- (void)removeFirstObject;


/// Creates a deep copy of the array by copying the elements.
/// Each element in the array has to implement the NSCopying protocol.
/// @return A new array with a copy of the elements.
- (NSMutableArray *)arrayCloned;


/// Creates a mutable array initialized with all objects of the given set in undefined order.
/// @param set The NSSet with objects to put into this new array.
/// @return A new array with the set's objects.
+ (id)arrayWithSet:(NSSet *)set;

/// Creates a mutable array initialized with all objects of the given set in undefined order.
/// @param set The NSSet with objects to put into this new array.
/// @return A new array with the set's objects.
- (id)initWithSet:(NSSet *)set;

@end

