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
#import "NSString+INExtensions.h"


@implementation NSArray (INExtensions)

- (BOOL)hasElements {
    return self.count > 0;
}

- (NSArray *)arrayCloned {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for (id obj in self) {
        id clonedObj = [obj copy];
        [array addObject:clonedObj];
    }
    NSArray *clonedArray = [[NSArray alloc] initWithArray:array];
    return clonedArray;
}

- (NSArray *)arraySortedWithKey:(NSString *)key ascending:(BOOL)ascending {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSArray *sortedArray = [self sortedArrayUsingDescriptors:descriptors];
	return sortedArray;
}

- (NSArray *)arraySectionizedByKey:(NSString *)key {
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    NSString *sectionChar = nil;
    NSMutableArray *section = nil;
    for (id object in self) {
        NSString *value = [object valueForKey:key];
        BOOL valueEmpty = ![value hasText];
        BOOL sectionCharEmpty = ![sectionChar hasText];
        if (valueEmpty) {
            if (sectionChar == nil || !sectionCharEmpty) {
                sectionChar = @"";
                section = [[NSMutableArray alloc] init];
                [sections addObject:section];
            }
        } else {
            if (sectionChar == nil || sectionCharEmpty) {
                sectionChar = [value firstCharacter];
                section = [[NSMutableArray alloc] init];
                [sections addObject:section];
            } else {
                NSComparisonResult result = [value compare:sectionChar options:NSCaseInsensitiveSearch range:NSMakeRange(0,1)];
                if (result != NSOrderedSame) {
                    sectionChar = [value firstCharacter];
                    section = [[NSMutableArray alloc] init];
                    [sections addObject:section];
                }
            }
        }
        [section addObject:object];
    }
    return sections;
}

- (NSArray *)arrayUnsectionized {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSArray *section in self) {
        [array addObjectsFromArray:section];
    }
    return array;
}

- (NSArray *)arrayWithSectionHeadersForKey:(NSString *)key {
    NSMutableArray *headers = [[NSMutableArray alloc] init];
    for (NSArray *section in self) {
        if (![section hasElements]) continue;
        id object = [section firstObject];
        NSString *value = [object valueForKey:key];
        NSString *string = nil;
        if ([value hasText]) {
            string = [[value firstCharacter] capitalizedString];
        }
        if (string == nil) {
            string = @"";
        }
        [headers addObject:string];
    }
    return headers;
}


+ (NSArray *)arrayWithIntArray:(int *)intArray ofSize:(int)size {
	return [[self alloc] initWithIntArray:intArray ofSize:size];
}

- (instancetype)initWithIntArray:(int *)intArray ofSize:(int)size {
	if (intArray == NULL) return nil;
	if (size <= 0) {
		self = [self init];
		return self;
	}
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:size];
	for (int i = 0; i < size; i++) {
		NSNumber *number = [[NSNumber alloc] initWithInt:intArray[i]];
		[array addObject:number];
	}
	self = [self initWithArray:array];
	return self;
}

- (void)fillIntArray:(int *)intArray ofSize:(int)size {
	if (intArray == NULL) return;
	if (size == 0) return;
	int i = 0;
	for (id obj in self) {
		if (i >= size) return;
		if (![obj isKindOfClass:[NSNumber class]]) continue;
		NSNumber *number = (NSNumber *)obj;
		intArray[i] = [number intValue];
		i++;
	}
}

+ (NSArray *)arrayWithBoolArray:(BOOL *)boolArray ofSize:(int)size {
	return [[self alloc] initWithBoolArray:boolArray ofSize:size];
}

- (instancetype)initWithBoolArray:(BOOL *)boolArray ofSize:(int)size {
	if (boolArray == NULL) return nil;
	if (size <= 0) {
		self = [self init];
		return self;
	}
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:size];
	for (int i = 0; i < size; i++) {
		NSNumber *number = [[NSNumber alloc] initWithBool:boolArray[i]];
		[array addObject:number];
	}
	self = [self initWithArray:array];
	return self;
}

- (void)fillBoolArray:(BOOL *)boolArray ofSize:(int)size {
	if (boolArray == NULL) return;
	if (size == 0) return;
	int i = 0;
	for (id obj in self) {
		if (i >= size) return;
		if (![obj isKindOfClass:[NSNumber class]]) continue;
		NSNumber *number = (NSNumber *)obj;
		boolArray[i] = [number boolValue];
		i++;
	}
}

+ (id)arrayWithSet:(NSSet *)set {
	return [[self alloc] initWithSet:set];
}

- (instancetype)initWithSet:(NSSet *)set {
    NSMutableArray *array = [[NSMutableArray alloc] initWithSet:set];
	self = [self initWithArray:array];
	if (self == nil) return self;
    
	return self;
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



@implementation NSMutableArray (IExtensions)

- (void)removeFirstObject {
    if (self.count == 0) [NSException raise:NSRangeException format:nil];
    [self removeObjectAtIndex:0];
}

- (NSMutableArray *)arrayCloned {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for (id obj in self) {
        id clonedObj = [obj copy];
        [array addObject:clonedObj];
    }
    return array;
}

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

@end
