// NSDictionary+INExtensions.m
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


#import "NSDictionary+INExtensions.h"


@implementation NSDictionary (INExtensions)

- (BOOL)boolForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSNumber class]], @"NSNumber expected");
	NSNumber *number = (NSNumber *)object;
	return [number boolValue];
}

- (int)intForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSNumber class]], @"NSNumber expected");
	NSNumber *number = (NSNumber *)object;
	return [number intValue];
}

- (float)floatForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSNumber class]], @"NSNumber expected");
	NSNumber *number = (NSNumber *)object;
	return [number floatValue];
}

- (double)doubleForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSNumber class]], @"NSNumber expected");
	NSNumber *number = (NSNumber *)object;
	return [number doubleValue];
}

- (long)longForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSNumber class]], @"NSNumber expected");
	NSNumber *number = (NSNumber *)object;
	return [number longValue];
}

- (NSString *)stringForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSString class]], @"NSString expected");
	return (NSString *)object;
}

- (NSArray *)arrayForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSArray class]], @"NSArray expected");
	return (NSArray *)object;
}

- (NSDictionary *)dictForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSDictionary class]], @"NSDictionary expected");
	return (NSDictionary *)object;
}

- (NSNumber *)numberForKey:(id)key {
	id object = [self objectForKey:key];
    NSAssert(object == nil || [object isKindOfClass:[NSNumber class]], @"NSNumber expected");
	return (NSNumber *)object;
}


@end
