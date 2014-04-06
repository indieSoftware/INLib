// NSDictionary+INExtensions.h
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


@interface NSDictionary (INExtensions)

/// Returns primitive values from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The bool value for the key.
- (BOOL)boolForKey:(id)key;

/// Returns primitive values from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The int value for the key.
- (int)intForKey:(id)key;

/// Returns primitive values from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The float value for the key.
- (float)floatForKey:(id)key;

/// Returns primitive values from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The double value for the key.
- (double)doubleForKey:(id)key;

/// Returns primitive values from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The long value for the key.
- (long)longForKey:(id)key;

/// Returns a string values from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The string value for the key.
- (NSString *)stringForKey:(id)key;

/// Returns an array from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The array value for the key.
- (NSArray *)arrayForKey:(id)key;

/// Returns a dictionary from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The dictionary value for the key.
- (NSDictionary *)dictForKey:(id)key;

/// Returns a NSNumber from the dictionary.
/// @param key The dictionary's key to retrieve.
/// @return The number value for the key.
- (NSNumber *)numberForKey:(id)key;


@end


#pragma mark -


@interface NSMutableDictionary (INExtensions)

/// Sets a primitive values to the dictionary wrapping it in a NSNumber.
/// @param value The bool value to add.
/// @param key The key under which the value will be added.
- (void)setBool:(BOOL)value forKey:(id)key;

/// Sets a primitive values to the dictionary wrapping it in a NSNumber.
/// @param value The int value to add.
/// @param key The key under which the value will be added.
- (void)setInt:(int)value forKey:(id)key;

/// Sets a primitive values to the dictionary wrapping it in a NSNumber.
/// @param value The float value to add.
/// @param key The key under which the value will be added.
- (void)setFloat:(float)value forKey:(id)key;

/// Sets a primitive values to the dictionary wrapping it in a NSNumber.
/// @param value The double value to add.
/// @param key The key under which the value will be added.
- (void)setDouble:(double)value forKey:(id)key;

/// Sets a primitive values to the dictionary wrapping it in a NSNumber.
/// @param value The long value to add.
/// @param key The key under which the value will be added.
- (void)setLong:(long)value forKey:(id)key;

/// Puts a string to the dictionary.
/// @param value The string to add. nil will remove an old value from the dictionary.
/// @param key The key under which the value will be added.
- (void)setString:(NSString *)value forKey:(id)key;

/// Puts an array to the dictionary.
/// @param value The array to add. nil will remove an old value from the dictionary.
/// @param key The key under which the value will be added.
- (void)setArray:(NSArray *)value forKey:(id)key;

/// Puts a dictionary to the dictionary.
/// @param value The dictionary to add. nil will remove an old value from the dictionary.
/// @param key The key under which the value will be added.
- (void)setDict:(NSDictionary *)value forKey:(id)key;

/// Puts a NSNumber to the dictionary.
/// @param value The NSNumber to add. nil will remove an old value from the dictionary.
/// @param key The key under which the value will be added.
- (void)setNumber:(NSNumber *)value forKey:(id)key;


@end
