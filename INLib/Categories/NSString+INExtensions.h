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
 Trims a string. Any spaces and new lines from the start and the ending of the receiver will be removed.

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
- (BOOL)isEqualToCaseInsesitiveString:(NSString *)string;


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


@end
