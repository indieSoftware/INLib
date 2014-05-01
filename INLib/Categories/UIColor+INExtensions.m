// UIColor+INExtensions.m
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


#import "UIColor+INExtensions.h"


@implementation UIColor (INExtensions)

+ (UIColor *)randomColor {
	CGFloat red = (CGFloat)arc4random() / 0xFFFFFFFFu;
	CGFloat green = (CGFloat)arc4random() / 0xFFFFFFFFu;
	CGFloat blue = (CGFloat)arc4random() / 0xFFFFFFFFu;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
	return [[UIColor alloc] initWithIntRed:red green:green blue:blue alpha:alpha];
}

- (id)initWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
	self = [self initWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
	if (self == nil) return self;
	return self;
}

+ (UIColor *)colorWithHex:(NSUInteger)hex {
	return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((CGFloat)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}


- (CGFloat)redPart {
	const CGFloat *aColor = CGColorGetComponents(self.CGColor);
	return aColor[0];
}

- (CGFloat)greenPart {
	const CGFloat *aColor = CGColorGetComponents(self.CGColor);
	return aColor[1];
}

- (CGFloat)bluePart {
	const CGFloat *aColor = CGColorGetComponents(self.CGColor);
	return aColor[2];
}

- (CGFloat)alphaPart {
	return CGColorGetAlpha(self.CGColor);
}


@end
