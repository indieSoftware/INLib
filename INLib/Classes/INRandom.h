// INRandom.h
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


/**
 The maximum value of a returned random call. This is a 32 bit unsigned integer.
 */
#define INRANDOM_MAX_VALUE 0xFFFFFFFFu


/**
 A class which returns all kinds of randomness.
 
 The class uses arc4random() for creating random numbers so no seeding is needed.
 */
@interface INRandom : NSObject


/**
 Returns a random unsigned integer.
 
 @return A random unsigned integer.
 */
+ (NSUInteger)integer;


/**
 Returns a random unsigned integer within a given range, inclusive.
 
 (max - min + 1) has to be within 0 and INRANDOM_MAX_VALUE - 1, so the sum has to be a 32 bit unsigned integer.
 
 @param min The minimum value for the random value to generate.
 @param max The maximum value for the random value to generate, has to be greater than min.
 @return A random unsigned integer.
 */
+ (NSUInteger)integerWithin:(NSUInteger)min and:(NSUInteger)max;


/**
 Returns a random signed integer.
 
 @return A random signed integer.
 */
+ (NSInteger)signedInteger;


/**
 Returns a random signed integer within a given range, inclusive.
 
 (max - min + 1) has to be within 0 and INRANDOM_MAX_VALUE - 1, so the sum has to be a 32 bit unsigned integer.
 
 @param min The minimum value for the random value to generate, may also be negative.
 @param max The maximum value for the random value to generate, may also be negative but has to be greater than min.
 @return A random signed integer.
 */
+ (NSInteger)signedIntegerWithin:(NSInteger)min and:(NSInteger)max;


/**
 Returns a random floating point number between 0.0 and 1.0, inclusive.
 
 @return A random float.
 */
+ (CGFloat)float;


/**
 Returns a random floating point number in the range [min..max], inclusive.
 
 @param min The minimum value for the random value to generate.
 @param max The maximum value for the random value to generate.
 @return A random float.
 */
+ (CGFloat)floatWithin:(CGFloat)min and:(CGFloat)max;


/**
 Randomly returns either +1 or -1.
 
 @return Either 1 or -1.
 */
+ (NSInteger)sign;


@end
