// UIColor+INExtensions.h
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


@interface UIColor (INExtensions)

#pragma mark - Color creation
/// @name Color creation

/**
 Creates a new random color object with the alpha set to 1.
 
 The RGB values will be set randomly by using INRandom.
 
 @return A new random color.
 */
+ (UIColor *)randomColor;


/**
 Creates a new color object with short int values rather than floats.

 @param red The red value in the range from 0 to 255.
 @param green The green value in the range from 0 to 255.
 @param blue The blue value in the range from 0 to 255.
 @param alpha The alpha value in the range from 0 to 255.
 @return A new color object.
 */
+ (UIColor *)colorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;


/**
 Initializes the color with RGB intager values in the range of 0 to 255 instead of 0 to 1 floats.

 @param red The red value in the range from 0 to 255.
 @param green The green value in the range from 0 to 255.
 @param blue The blue value in the range from 0 to 255.
 @param alpha The alpha value in the range from 0 to 255.
 @return The color object.
 */
- (id)initWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;


/**
 Creates a color with a hex value.

 @param hex The rgb value as a hex value, i.e. 0x56EF12.
 @param alpha The alpha value ranging from 0 to 1.
 @return A new color object.
 */
+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;


#pragma mark - RGB determination
/// @name RGB determination

/**
 Determines the red color part in the range of 0 to 1.

 @return The red value.
 */
- (CGFloat)redPart;


/**
 Determines the green color part in the range of 0 to 1.
 
 @return The green value.
 */
- (CGFloat)greenPart;


/**
 Determines the blue color part in the range of 0 to 1.
 
 @return The blue value.
 */
- (CGFloat)bluePart;


/**
 Determines the alpha part in the range of 0 to 1.
 
 @return The alpha value.
 */
- (CGFloat)alphaPart;


@end
