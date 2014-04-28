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


#import "NSArray+INExtensions.h"


@implementation NSArray (INExtensions)

+ (id)arrayWithSet:(NSSet *)set {
	return [[self alloc] initWithSet:set];
}

- (instancetype)initWithSet:(NSSet *)set {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:[set count]];
    for (id object in set) {
		[mutableArray addObject:object];
	}
	self = [self initWithArray:mutableArray];
	if (self == nil) return self;
	return self;
}

- (BOOL)hasElements {
    return self.count > 0;
}

- (NSArray *)arrayReversed {
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)arraySortedWithKey:(NSString *)key ascending:(BOOL)ascending {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSArray *sortedArray = [self sortedArrayUsingDescriptors:descriptors];
	return sortedArray;
}

- (id)firstObjectPassingTest:(BOOL (^)(id obj))predicate {
    id obj = nil;
    NSUInteger index = [self indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL ret = predicate(obj);
        *stop = ret;
        return ret;
    }];
    if (index != NSNotFound) {
        obj = [self objectAtIndex:index];
    }
    return obj;
}


@end
