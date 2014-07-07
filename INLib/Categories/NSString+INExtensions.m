// NSString+INExtensions.m
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


#import "NSString+INExtensions.h"


@implementation NSString (INExtensions)

- (NSString *)stringWithFirstCharacterCapitalized {
	if ([self length] == 0) return @"";
	
	NSString *uppercaseCharacter = [[self firstCharacter] capitalizedString];
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:uppercaseCharacter];
}

- (NSString *)stringTrimmed {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)hasText {
    return [[self stringTrimmed] length] > 0;
}

- (BOOL)isEqualToCaseInsensitiveString:(NSString *)string {
    if (string == nil) return NO;
    NSComparisonResult result = [self compare:string options:NSCaseInsensitiveSearch];
    return result == NSOrderedSame;
}

- (NSString *)firstCharacter {
	if ([self length] == 0) return @"";
	return [self substringToIndex:1];
}

- (BOOL)firstCharacterEquals:(NSString *)otherString {
	NSString *char1 = [self firstCharacter];
	NSString *char2 = [otherString firstCharacter];
	return [char1 isEqualToString:char2];
}

- (BOOL)versionAtLeast:(NSString *)versionNumber {
    NSInteger numberOfComponentsString1 = [self componentsSeparatedByString:@"."].count;
    NSInteger numberOfComponentsString2 = [versionNumber componentsSeparatedByString:@"."].count;
    NSString *string1 = [self versionStringWithLength:numberOfComponentsString2];
    NSString *string2 = [versionNumber versionStringWithLength:numberOfComponentsString1];
	if ([string1 compare:string2 options:NSNumericSearch] == NSOrderedAscending) {
		return NO;
	}
	return YES;
}

- (BOOL)versionAtMost:(NSString *)versionNumber {
    NSInteger numberOfComponentsString1 = [self componentsSeparatedByString:@"."].count;
    NSInteger numberOfComponentsString2 = [versionNumber componentsSeparatedByString:@"."].count;
    NSString *string1 = [self versionStringWithLength:numberOfComponentsString2];
    NSString *string2 = [versionNumber versionStringWithLength:numberOfComponentsString1];
	if ([string1 compare:string2 options:NSNumericSearch] == NSOrderedDescending) {
		return NO;
	}
	return YES;
}

- (BOOL)versionEqualTo:(NSString *)versionNumber {
    NSInteger numberOfComponentsString1 = [self componentsSeparatedByString:@"."].count;
    NSInteger numberOfComponentsString2 = [versionNumber componentsSeparatedByString:@"."].count;
    NSString *string1 = [self versionStringWithLength:numberOfComponentsString2];
    NSString *string2 = [versionNumber versionStringWithLength:numberOfComponentsString1];
	if ([string1 compare:string2 options:NSNumericSearch] == NSOrderedSame) {
		return YES;
	}
	return NO;
}

- (BOOL)versionLowerThan:(NSString *)versionNumber {
    NSInteger numberOfComponentsString1 = [self componentsSeparatedByString:@"."].count;
    NSInteger numberOfComponentsString2 = [versionNumber componentsSeparatedByString:@"."].count;
    NSString *string1 = [self versionStringWithLength:numberOfComponentsString2];
    NSString *string2 = [versionNumber versionStringWithLength:numberOfComponentsString1];
	if ([string1 compare:string2 options:NSNumericSearch] == NSOrderedAscending) {
		return YES;
	}
	return NO;
}

- (BOOL)versionHigherThan:(NSString *)versionNumber {
    NSInteger numberOfComponentsString1 = [self componentsSeparatedByString:@"."].count;
    NSInteger numberOfComponentsString2 = [versionNumber componentsSeparatedByString:@"."].count;
    NSString *string1 = [self versionStringWithLength:numberOfComponentsString2];
    NSString *string2 = [versionNumber versionStringWithLength:numberOfComponentsString1];
	if ([string1 compare:string2 options:NSNumericSearch] == NSOrderedDescending) {
		return YES;
	}
	return NO;
}

- (NSString *)versionStringIncreasedAtIndex:(NSUInteger)index {
    // separate version components
    NSMutableArray *components = [self componentsSeparatedByString:@"."].mutableCopy;
    // fill up 0 components up to the index
    for (NSUInteger endIndex = components.count; endIndex <= index; ++endIndex) {
        [components addObject:@"0"];
    }
    // increase component's value
    NSUInteger value = [components[index] integerValue] + 1;
    components[index] = [NSString stringWithFormat:@"%lu", (unsigned long)value];
    // make sure the first number is at least 0
    components[0] = [NSString stringWithFormat:@"%ld", (long)[components[0] integerValue]];
    // concat new version string
    NSMutableString *newVersion = [[NSMutableString alloc] initWithString:components[0]];
    for (NSUInteger componentIndex = 1; componentIndex < components.count; ++componentIndex) {
        if (componentIndex > index) {
            break;
        }
        [newVersion appendString:@"."];
        [newVersion appendString:components[componentIndex]];
    }
    return newVersion.copy;
}

- (NSString *)versionStringWithLength:(NSUInteger)numberOfComponents {
    // separate version components
    NSMutableArray *components = [self componentsSeparatedByString:@"."].mutableCopy;
    // fill up 0 components
    for (NSUInteger endIndex = components.count; endIndex < numberOfComponents; ++endIndex) {
        [components addObject:@"0"];
    }
    // make sure the first number is at least 0
    components[0] = [NSString stringWithFormat:@"%ld", (long)[components[0] integerValue]];
    // concat new version string
    NSMutableString *newVersion = [[NSMutableString alloc] initWithString:components[0]];
    for (NSUInteger componentIndex = 1; componentIndex < components.count; ++componentIndex) {
        [newVersion appendString:@"."];
        [newVersion appendString:components[componentIndex]];
    }
    return newVersion.copy;
}


@end
