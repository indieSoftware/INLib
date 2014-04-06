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

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (INExtensions)

- (NSString *)capitalizedFirstCharacterString {
	if ([self length] == 0) return @"";
	
	NSString *uppercaseCharacter = [[self firstCharacter] capitalizedString];
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:uppercaseCharacter];
}

- (NSString *)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmpty {
	return [[self trim] length] == 0;
}

- (BOOL)hasText {
    return [[self trim] length] != 0;
}

- (BOOL)isEqualToCaseInsesitiveString:(NSString *)string {
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

- (NSString *)md5 {
	const char * cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
    
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];	
}

- (BOOL)versionAtLeast:(NSString *)versionNumber {
	if ([self compare:versionNumber options:NSNumericSearch] == NSOrderedAscending) {
		return NO;
	}
	return YES;
}

- (BOOL)versionAtMost:(NSString *)versionNumber {
	if ([self compare:versionNumber options:NSNumericSearch] == NSOrderedDescending) {
		return NO;
	}
	return YES;
}

- (BOOL)versionEqualTo:(NSString *)versionNumber {
	if ([self compare:versionNumber options:NSNumericSearch] == NSOrderedSame) {
		return YES;
	}
	return NO;
}

- (BOOL)versionLowerThan:(NSString *)versionNumber {
	if ([self compare:versionNumber options:NSNumericSearch] == NSOrderedAscending) {
		return YES;
	}
	return NO;
}

- (BOOL)versionHigherThan:(NSString *)versionNumber {
	if ([self compare:versionNumber options:NSNumericSearch] == NSOrderedDescending) {
		return YES;
	}
	return NO;
}


@end
