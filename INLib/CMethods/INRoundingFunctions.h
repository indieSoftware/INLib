// INRoundingFunctions.h
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



#ifdef __cplusplus
extern "C" {
#endif


/**
 Returns the input value rounded after a given number of digits after the decimal point.

    INRound(1.36, 0) = 1
    INRound(3.33, 1) = 3.3
    INRound(6.66, 1) = 6.7
 
 @param value The input value which to round.
 @param digits The number of digits after the period from which to round.
 @return The rounded value.
 */
static inline CGFloat INRoundFloat(CGFloat value, NSUInteger digits) {
#if CGFLOAT_IS_DOUBLE
    double shift = pow(10, digits);
    return round(value * shift) / shift;
#else
    float shift = powf(10, digits);
    return roundf(value * shift) / shift;
#endif
}


/**
 Returns the input value ceiled up after a given number of digits after the decimal point.

    INCeil(1.36, 0) = 2
    INCeil(3.33, 1) = 3.4
    INCeil(6.66, 1) = 6.7

 @param value The input value which to ceil.
 @param digits The number of digits after the period from which to ceil.
 @return The ceiled value.
 */
static inline CGFloat INCeilFloat(CGFloat value, NSUInteger digits) {
#if CGFLOAT_IS_DOUBLE
    double shift = pow(10, digits);
    return ceil(value * shift) / shift;
#else
    float shift = powf(10, digits);
    return ceilf(value * shift) / shift;
#endif
}


/**
 Returns the input value floored down after a given number of digits after the decimal point.

    INFloorf(1.36, 0) = 1
    INFloorf(3.33, 1) = 3.3
    INFloorf(6.66, 1) = 6.6

 @param value The input value which to floor.
 @param digits The number of digits after the period from which to floor.
 @return The floored value.
 */
static inline CGFloat INFloorFloat(CGFloat value, NSUInteger digits) {
#if CGFLOAT_IS_DOUBLE
    double shift = pow(10, digits);
    return floor(value * shift) / shift;
#else
    float shift = powf(10, digits);
    return floorf(value * shift) / shift;
#endif
}



#ifdef __cplusplus
}
#endif
