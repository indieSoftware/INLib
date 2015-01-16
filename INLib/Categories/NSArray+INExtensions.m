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
#import "INRandom.h"


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

- (NSString *)descriptionWithStart:(NSString *)start elementFormatter:(NSString *)elementFormatter lastElementFormatter:(NSString *)lastElementFormatter end:(NSString *)end {
    NSMutableString *description = [NSMutableString stringWithString:start];
    for (NSUInteger index = 0; index < self.count; ++index) {
        if (index == self.count-1) {
            [description appendFormat:lastElementFormatter, self[index]];
        } else {
            [description appendFormat:elementFormatter, self[index]];
        }
    }
    [description appendString:end];
    return description.copy;
}

- (NSArray *)arrayReversed {
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)arraySortedByKey:(NSString *)key ascending:(BOOL)ascending {
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

- (NSArray *)arrayWithRandomElementsRemoved:(NSUInteger)numberOfElements {
    if (numberOfElements >= self.count) {
        return [NSArray array];
    }
    if (numberOfElements == 0) {
        return [NSArray arrayWithArray:self];
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:self];
    for (NSUInteger i = 0; i < numberOfElements; i++) {
        [mutableArray removeObjectAtIndex:[INRandom integerWithin:0 and:mutableArray.count - 1]];
    }
    return mutableArray;
}

- (NSArray *)arrayWithRandomElementsChosen:(NSUInteger)numberOfElements {
    if (numberOfElements >= self.count) {
        return [NSArray arrayWithArray:self];
    }
    if (numberOfElements == 0) {
        return [NSArray array];
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:self];
    for (NSUInteger i = 0; i < self.count - numberOfElements; i++) {
        [mutableArray removeObjectAtIndex:[INRandom integerWithin:0 and:mutableArray.count - 1]];
    }
    return mutableArray;
}

- (NSArray *)arrayWithRandomizedOrder {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:self];
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:self.count];
    for (NSUInteger i = 0; i < self.count; i++) {
        NSUInteger randomIndex = [INRandom integerWithin:0 and:mutableArray.count - 1];
        id element = [mutableArray objectAtIndex:randomIndex];
        [resultArray addObject:element];
        [mutableArray removeObjectAtIndex:randomIndex];
    }
    return resultArray;
}

- (id)randomObject {
    if (self.count == 0) {
        return nil;
    }
    
    NSUInteger index = [INRandom integerWithin:0 and:self.count-1];
    return self[index];
}


@end
