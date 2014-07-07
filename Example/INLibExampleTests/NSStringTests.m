//
//  NSStringTests.m
//  INLibExample
//
//  Created by Sven Korset on 07.07.14.
//  Copyright (c) 2014 indie-Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

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


#pragma mark - stringWithFirstCharacterCapitalized

- (void)test_stringWithFirstCharacterCapitalized_onLowerCaseString_capitalizesFirstCharacter {
    NSString *string = @"alowerstring";
    NSString *expect = @"Alowerstring";
    NSString *result = [string stringWithFirstCharacterCapitalized];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    string = @"anotherString";
    expect = @"AnotherString";
    result = [string stringWithFirstCharacterCapitalized];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    string = @"b";
    expect = @"B";
    result = [string stringWithFirstCharacterCapitalized];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    string = @"über";
    expect = @"Über";
    result = [string stringWithFirstCharacterCapitalized];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}

- (void)test_stringWithFirstCharacterCapitalized_onUpperCaseString_returnsSameString {
    NSString *string = @"UpperString";
    NSString *expect = string;
    NSString *result = [string stringWithFirstCharacterCapitalized];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    string = @"Z";
    expect = string;
    result = [string stringWithFirstCharacterCapitalized];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}

- (void)test_stringWithFirstCharacterCapitalized_onEmptyString_returnsEmptyString {
    NSString *string = @"";
    NSString *result = [string stringWithFirstCharacterCapitalized];
    XCTAssertEqual(result, string, @"Not the empty string");
}


#pragma mark - stringTrimmed

- (void)test_stringTrimmed_onTrimmableString_returnsTrimmedString {
    NSString *string = @" trimm me \n ";
    NSString *expect = @"trimm me";
    NSString *result = [string stringTrimmed];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
    
    string = @"trimm    me  ";
    expect = @"trimm    me";
    result = [string stringTrimmed];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    string = @"\ntrimm\nme\n";
    expect = @"trimm\nme";
    result = [string stringTrimmed];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    string = [NSString stringWithFormat:@"trimm:%C%C%C%C%C", 0x000a, 0x000b, 0x000c, 0x000d, 0x0085];
    expect = @"trimm:";
    result = [string stringTrimmed];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}

- (void)test_stringTrimmed_onNonTrimmableString_returnsSameString {
    NSString *string = @"don't trimm me";
    NSString *expect = string;
    NSString *result = [string stringTrimmed];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
    
    string = @"";
    expect = @"";
    result = [string stringTrimmed];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}


#pragma mark - firstCharacter

- (void)test_firstCharacter_onString_returnsFirstCharacter {
    NSString *string = @"a String";
    NSString *expect = @"a";
    NSString *result = [string firstCharacter];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
    
    string = @"Überstring";
    expect = @"Ü";
    result = [string firstCharacter];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}

- (void)test_firstCharacter_onEmptyString_returnsEmptyString {
    NSString *string = @"";
    NSString *expect = string;
    NSString *result = [string firstCharacter];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}


#pragma mark - hasText

- (void)test_hasText_onStringWithText_returnsTrue {
    NSString *string = @"a String";
    BOOL result = [string hasText];
    XCTAssert(result, @"True was expecting");

    string = @" a trimmable string \n ";
    result = [string hasText];
    XCTAssert(result, @"True was expecting");
}

- (void)test_hasText_onEmptyString_returnsFalse {
    NSString *string = @"";
    BOOL result = [string hasText];
    XCTAssert(!result, @"False was expecting");
    
    string = @"     \n ";
    result = [string hasText];
    XCTAssert(!result, @"False was expecting");
}


#pragma mark - isEqualToCaseInsensitiveString:

- (void)test_isEqualToCaseInsensitiveString_withEqualStrings_returnsTrue {
    NSString *string = @"a String";
    NSString *other = @"A string";
    BOOL result = [string isEqualToCaseInsensitiveString:other];
    XCTAssert(result, @"'%@' was expected to be equal to '%@'", string, other);
    
    string = @"Übertrimm \n";
    other = @"überTrimm \n";
    result = [string isEqualToCaseInsensitiveString:other];
    XCTAssert(result, @"'%@' was expected to be equal to '%@'", string, other);

    string = @"Same String";
    other = @"Same String";
    result = [string isEqualToCaseInsensitiveString:other];
    XCTAssert(result, @"'%@' was expected to be equal to '%@'", string, other);

    string = @"";
    other = @"";
    result = [string isEqualToCaseInsensitiveString:other];
    XCTAssert(result, @"'%@' was expected to be equal to '%@'", string, other);
}

- (void)test_isEqualToCaseInsensitiveString_withDifferentStrings_returnsFalse {
    NSString *string = @"a String";
    NSString *other = @"Another string";
    BOOL result = [string isEqualToCaseInsensitiveString:other];
    XCTAssert(!result, @"'%@' was expected to be not equal to '%@'", string, other);
    
    string = @"Ü";
    other = @"Ä";
    result = [string isEqualToCaseInsensitiveString:other];
    XCTAssert(!result, @"'%@' was expected to be not equal to '%@'", string, other);
}


#pragma mark - firstCharacterEquals:

- (void)test_firstCharacterEquals_withSameFirstCharacter_returnsTrue {
    NSString *string = @"a String";
    NSString *firstChar = @"a";
    BOOL result = [string firstCharacterEquals:firstChar];
    XCTAssert(result, @"'%@' was expected to begin with '%@'", string, firstChar);

    string = @"Ü";
    firstChar = @"Ü";
    result = [string firstCharacterEquals:firstChar];
    XCTAssert(result, @"'%@' was expected to begin with '%@'", string, firstChar);

    string = @" ";
    firstChar = @" ";
    result = [string firstCharacterEquals:firstChar];
    XCTAssert(result, @"'%@' was expected to begin with '%@'", string, firstChar);

    string = @"";
    firstChar = @"";
    result = [string firstCharacterEquals:firstChar];
    XCTAssert(result, @"'%@' was expected to begin with '%@'", string, firstChar);
}

- (void)test_firstCharacterEquals_withDifferentCharacters_returnsFalse {
    NSString *string = @"String";
    NSString *firstChar = @"Z";
    BOOL result = [string firstCharacterEquals:firstChar];
    XCTAssert(!result, @"'%@' was expected not to begin with '%@'", string, firstChar);
    
    string = @"";
    firstChar = @"a";
    result = [string firstCharacterEquals:firstChar];
    XCTAssert(!result, @"'%@' was expected not to begin with '%@'", string, firstChar);
}


#pragma mark - version comparison

- (void)test_versionAtLeast {
    NSString *version = @"1.2.3";
    NSString *compare = @"1.2";
    BOOL result = [version versionAtLeast:compare];
    XCTAssert(result, @"was expected to be true");

    version = @"1.2";
    compare = @"1.2";
    result = [version versionAtLeast:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"3";
    compare = @"1.2";
    result = [version versionAtLeast:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"3";
    compare = @"3.2";
    result = [version versionAtLeast:compare];
    XCTAssert(!result, @"was expected to be false");

    version = @"";
    compare = @"3.2";
    result = [version versionAtLeast:compare];
    XCTAssert(!result, @"was expected to be false");

    version = @"1.2.0";
    compare = @"1.2";
    result = [version versionAtLeast:compare];
    XCTAssert(result, @"was expected to be true");

    version = @"1.2";
    compare = @"1.2.0";
    result = [version versionAtLeast:compare];
    XCTAssert(result, @"was expected to be true");
}

- (void)test_versionAtMost {
    NSString *version = @"1.2.3";
    NSString *compare = @"1.2";
    BOOL result = [version versionAtMost:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"1.2";
    compare = @"1.2";
    result = [version versionAtMost:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"3";
    compare = @"1.2";
    result = [version versionAtMost:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"3";
    compare = @"3.2";
    result = [version versionAtMost:compare];
    XCTAssert(result, @"was expected to be true");

    version = @"";
    compare = @"3.2";
    result = [version versionAtMost:compare];
    XCTAssert(result, @"was expected to be true");

    version = @"1.2.0";
    compare = @"1.2";
    result = [version versionAtMost:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"1.2";
    compare = @"1.2.0";
    result = [version versionAtMost:compare];
    XCTAssert(result, @"was expected to be true");
}

- (void)test_versionEqualTo {
    NSString *version = @"1.2";
    NSString *compare = @"1.2";
    BOOL result = [version versionEqualTo:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"1";
    compare = @"1.0";
    result = [version versionEqualTo:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"1.0";
    compare = @"1";
    result = [version versionEqualTo:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"3";
    compare = @"3.2";
    result = [version versionEqualTo:compare];
    XCTAssert(!result, @"was expected to be false");

    version = @"";
    compare = @"3.2";
    result = [version versionEqualTo:compare];
    XCTAssert(!result, @"was expected to be false");
}

- (void)test_versionLowerThan {
    NSString *version = @"1.2.3";
    NSString *compare = @"1.2";
    BOOL result = [version versionLowerThan:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"1.2";
    compare = @"1.2";
    result = [version versionLowerThan:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"3";
    compare = @"1.2";
    result = [version versionLowerThan:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"3";
    compare = @"3.2";
    result = [version versionLowerThan:compare];
    XCTAssert(result, @"was expected to be true");

    version = @"";
    compare = @"3.2";
    result = [version versionLowerThan:compare];
    XCTAssert(result, @"was expected to be true");

    version = @"2.0";
    compare = @"2";
    result = [version versionLowerThan:compare];
    XCTAssert(!result, @"was expected to be false");

    version = @"2";
    compare = @"2.0";
    result = [version versionLowerThan:compare];
    XCTAssert(!result, @"was expected to be false");
}

- (void)test_versionHigherThan {
    NSString *version = @"1.2.3";
    NSString *compare = @"1.2";
    BOOL result = [version versionHigherThan:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"1.2";
    compare = @"1.2";
    result = [version versionHigherThan:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"3";
    compare = @"1.2";
    result = [version versionHigherThan:compare];
    XCTAssert(result, @"was expected to be true");
    
    version = @"3";
    compare = @"3.2";
    result = [version versionHigherThan:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"";
    compare = @"3.2";
    result = [version versionHigherThan:compare];
    XCTAssert(!result, @"was expected to be false");

    version = @"2.0";
    compare = @"2";
    result = [version versionHigherThan:compare];
    XCTAssert(!result, @"was expected to be false");
    
    version = @"2";
    compare = @"2.0";
    result = [version versionHigherThan:compare];
    XCTAssert(!result, @"was expected to be false");
}


#pragma mark - versionStringIncreasedAtIndex:

- (void)test_versionStringIncreasedAtIndex {
    NSString *version = @"1.2.3";
    NSUInteger index = 2;
    NSString *expect = @"1.2.4";
    NSString *result = [version versionStringIncreasedAtIndex:index];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    version = @"1.2.3";
    index = 1;
    expect = @"1.3";
    result = [version versionStringIncreasedAtIndex:index];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
    
    version = @"1.2.3";
    index = 0;
    expect = @"2";
    result = [version versionStringIncreasedAtIndex:index];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    version = @"1";
    index = 2;
    expect = @"1.0.1";
    result = [version versionStringIncreasedAtIndex:index];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    version = @"";
    index = 1;
    expect = @"0.1";
    result = [version versionStringIncreasedAtIndex:index];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}


#pragma mark - versionStringWithLength:

- (void)test_versionStringWithLength {
    NSString *version = @"1.2";
    NSUInteger components = 2;
    NSString *expect = @"1.2";
    NSString *result = [version versionStringWithLength:components];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    version = @"1.2.3";
    components = 2;
    expect = @"1.2.3";
    result = [version versionStringWithLength:components];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    version = @"1";
    components = 2;
    expect = @"1.0";
    result = [version versionStringWithLength:components];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);

    version = @"";
    components = 2;
    expect = @"0.0";
    result = [version versionStringWithLength:components];
    XCTAssert([result isEqualToString:expect], @"'%@' was expected, but is '%@'", expect, result);
}


@end
