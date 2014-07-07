// NSString+INExtensions.h
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


@interface NSString (INExtensions)

#pragma mark - String manipulation
/// @name String manipulation

/**
 Capitalizes the first character of this string.

 @return A new string with the first character capitalized.
 */
- (NSString *)stringWithFirstCharacterCapitalized;


/**
 Trims a string.
 
 Any spaces and new lines from the start and the ending of the string will be removed.
 Whitspace characters are U000A - U000D and U0085.

 @return A new trimmed string.
 */
- (NSString *)stringTrimmed;


/**
 Returns the first character of this string.
 
 @return The string's first character as a new string. If the string is empty an empty string will be returned.
 */
- (NSString *)firstCharacter;


#pragma mark - String comparison
/// @name String comparison

/**
 True if the string has any characters.

 A string only with whitespaces, tabs and new lines is treated as empty.
 See `[NSCharacterSet whitespaceAndNewlineCharacterSet]` for an exact definition of whitespaces.

 With this method it is not necessary to check for nil, because calling the method on nil returns false,
 the same when there is no text in this string.
 
 @return True if the string has any characters in it, otherwise false.
 */
- (BOOL)hasText;


/**
 Compares the receiver string with another string case insensitive.
 
 @param string The other string to compare with.
 @return True if the two strings are case insensitive equal, otherwise false.
 */
- (BOOL)isEqualToCaseInsensitiveString:(NSString *)string;


/**
 Checks if this string starts with a given character.
 
 @param otherString The string to compare the first character with.
 @return True if the first character of this string equals the first character of the given string.
 */
- (BOOL)firstCharacterEquals:(NSString *)otherString;


#pragma mark - Version comparison
/// @name Version comparison

/**
 True if this version number is equal or higher than an onther.
 
 Compares version number strings with each other.
    
    [@"2.3.1" versionAtLeast:@"2.0"]; // = YES

 @param versionNumber A string with a version number to compare with.
 @return True if this version number is equal to or higher than the given version, otherwise false.
 */
- (BOOL)versionAtLeast:(NSString *)versionNumber;


/**
 True if this version number is equal or lower than an other.
 
 Compares version number strings with each other.
 
    [@"2.3.1" versionAtMost:@"3.0"]; // = YES

 @param versionNumber A string with a version number to compare with.
 @return True if this version number is equal to or lower than the given version, otherwise false.
 */
- (BOOL)versionAtMost:(NSString *)versionNumber;


/**
 True if this version number is equal to an other.
 
 Compares version number strings with each other.

    [@"2.3.0" versionEqualTo:@"2.3"]; // = YES

 @param versionNumber A string with a version number to compare with.
 @return True if this version number is equal to the given version, otherwise false.
 */
- (BOOL)versionEqualTo:(NSString *)versionNumber;


/**
 True if this version number is lower than an other.
 
 Compares version number strings with each other.
 
    [@"2.3" versionLowerThan:@"2.3.1"]; // = YES
 
 @param versionNumber A string with a version number to compare with.
 @return True if this version number is lower than the given version, otherwise false.
 */
- (BOOL)versionLowerThan:(NSString *)versionNumber;


/**
 True if this version number is higher than an other.
 
 Compares version number strings with each other.
 
    [@"2.3.1" versionHigherThan:@"2.3"]; // = YES
 
 @param versionNumber A string with a version number to compare with.
 @return True if this version number is higher than the given version, otherwise false.
 */
- (BOOL)versionHigherThan:(NSString *)versionNumber;


#pragma mark - Version manipulation
/// @name Version manipulation

/**
 Increases the version number at a specific index.
 
 The version hast to be separated by periods, i.e. "1.2.3".
 The index points to the number which will be increased by one beginning with index of 0 for the first number.
 Each number after the index will be truncated and each place without a number before the index will be filled with a 0.
 
    [@"1.2.3" versionStringIncreasedAtIndex:2]; // returns @"1.2.4"
    [@"1.2.3" versionStringIncreasedAtIndex:1]; // returns @"1.3"
    [@"1.2.3" versionStringIncreasedAtIndex:0]; // returns @"2"
    [@"1" versionStringIncreasedAtIndex:2]; // returns @"1.0.1"
 
 @param index The index of the number in the version to increase, beginning at 0.
 @return A new string with the version increased.
 */
- (NSString *)versionStringIncreasedAtIndex:(NSUInteger)index;


/**
 Adds missing components of a version string with zero values.
 
 If a version string has less components than needed the missing will be added with 0 values.
 
    [@"1.2" versionStringWithLength:3]; // returns @"1.2.0"
    [@"1.2" versionStringWithLength:2]; // returns @"1.2"
    [@"1" versionStringWithLength:2]; // returns @"1.0"
 
 @param numberOfComponents The number of components the version string should have at least.
 @return A new version string.
 */
- (NSString *)versionStringWithLength:(NSUInteger)numberOfComponents;


@end
