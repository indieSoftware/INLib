// NSLocale+INExtensions.m
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


#import "NSLocale+INExtensions.h"


static NSString *__cachedSupportedLanguage = nil;

@implementation NSLocale (INExtensions)


+ (NSString *)systemLanguage {
	NSArray *languages = [self preferredLanguages];
	if ([languages count] == 0) return nil;
	return [languages objectAtIndex:0];
}

+ (NSString *)systemCountryCode {
    NSLocale *locale = [NSLocale currentLocale];
    return [locale objectForKey:NSLocaleCountryCode];
}

+ (NSString *)preferredSupportedLanguage:(NSArray *)supportedLanguages defaultLanguage:(NSString *)defaultLanguage {
	if (__cachedSupportedLanguage != nil) return __cachedSupportedLanguage;
	NSArray *languages = [self preferredLanguages];
	if (languages == nil || [languages count] == 0) return nil;
    if (defaultLanguage == nil) {
        NSString *firstMatch = [languages firstObjectCommonWithArray:supportedLanguages];
        if (firstMatch == nil) {
            NSString *emptyString = @"";
            __cachedSupportedLanguage = [[NSString alloc] initWithString:emptyString];
        } else {
            __cachedSupportedLanguage = [[NSString alloc] initWithString:firstMatch];
        }
    } else {
        NSString *activeLanguage = [languages firstObject];
        NSUInteger index = [supportedLanguages indexOfObject:activeLanguage];
        if (index == NSNotFound) {
            __cachedSupportedLanguage = [[NSString alloc] initWithString:defaultLanguage];
        } else {
            __cachedSupportedLanguage = [[NSString alloc] initWithString:activeLanguage];
        }
    }
	return __cachedSupportedLanguage;
}

+ (NSString *)preferredSupportedLanguage {
	return __cachedSupportedLanguage;
}

@end
