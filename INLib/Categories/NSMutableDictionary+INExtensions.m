// NSMutableDictionary+INExtensions.m
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


#import "NSMutableDictionary+INExtensions.h"


@implementation NSMutableDictionary (INExtensions)

- (void)setBool:(BOOL)value forKey:(id)key {
	NSNumber *number = [[NSNumber alloc] initWithBool:value];
	[self setObject:number forKey:key];
}

- (void)setInt:(int)value forKey:(id)key {
	NSNumber *number = [[NSNumber alloc] initWithInt:value];
	[self setObject:number forKey:key];
}

- (void)setFloat:(float)value forKey:(id)key {
	NSNumber *number = [[NSNumber alloc] initWithFloat:value];
	[self setObject:number forKey:key];
}

- (void)setDouble:(double)value forKey:(id)key {
	NSNumber *number = [[NSNumber alloc] initWithDouble:value];
	[self setObject:number forKey:key];
}

- (void)setLong:(long)value forKey:(id)key {
	NSNumber *number = [[NSNumber alloc] initWithLong:value];
	[self setObject:number forKey:key];
}

- (void)setString:(NSString *)value forKey:(id)key {
	if (value == nil) {
		[self removeObjectForKey:key];
	} else {
		[self setObject:value forKey:key];
	}
}

- (void)setArray:(NSArray *)value forKey:(id)key {
	if (value == nil) {
		[self removeObjectForKey:key];
	} else {
		[self setObject:value forKey:key];
	}
}

- (void)setDict:(NSDictionary *)value forKey:(id)key {
	if (value == nil) {
		[self removeObjectForKey:key];
	} else {
		[self setObject:value forKey:key];
	}
}

- (void)setNumber:(NSNumber *)value forKey:(id)key {
    if (value == nil) {
        [self removeObjectForKey:key];
    } else {
        [self setObject:value forKey:key];
    }
}


@end
