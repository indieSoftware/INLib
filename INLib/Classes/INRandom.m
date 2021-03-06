// INRandom.m
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


#import "INRandom.h"

@implementation INRandom

+ (NSUInteger)integer {
    return arc4random();
}

+ (NSUInteger)integerWithin:(NSUInteger)min and:(NSUInteger)max {
    return arc4random_uniform((u_int32_t)(max - min + 1)) + min;
}

+ (NSInteger)signedInteger {
    return (NSInteger)arc4random();
}

+ (NSInteger)signedIntegerWithin:(NSInteger)min and:(NSInteger)max {
    return ((NSInteger)arc4random_uniform((u_int32_t)(max - min + 1))) + min;
}

+ (CGFloat)float {
    return (CGFloat)arc4random() / INRandomMaxValue;
}

+ (CGFloat)floatWithin:(CGFloat)min and:(CGFloat)max {
    return ((CGFloat)arc4random() / INRandomMaxValue) * (max - min) + min;
}

+ (NSInteger)sign {
    return ((arc4random_uniform(2) == 0) ? 1 : -1);
}


@end
