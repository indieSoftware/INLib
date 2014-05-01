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
 Returns the input float value rounded after a given number of digits after the decimal point.
 
    INRoundf(1.36, 0) = 1
    INRoundf(3.33, 1) = 3.3
    INRoundf(6.66, 1) = 6.7

 @param value The input float value which to round.
 @param digits The number of digits after the period from which to round.
 @return The rounded value.
 */
static inline float INRoundf(float value, NSUInteger digits) {
    float shift = powf(10, digits);
    return roundf(value * shift) / shift;
}


/**
 Returns the input double value rounded after a given number of digits after the decimal point.
 
    INRound(1.36, 0) = 1
    INRound(3.33, 1) = 3.3
    INRound(6.66, 1) = 6.7

 @param value The input double value which to round.
 @param digits The number of digits after the period from which to round.
 @return The rounded value.
 */
static inline double INRound(double value, NSUInteger digits) {
    double shift = pow(10, digits);
    return round(value * shift) / shift;
}


/**
 Returns the input value rounded after a given number of digits after the decimal point.

 Same as INRound and INRoundf, but depending on the CGFloat's type and architecture.
 
 @param value The input value which to round.
 @param digits The number of digits after the period from which to round.
 @return The rounded value.
 */
static inline CGFloat INRoundFloat(CGFloat value, NSUInteger digits) {
#if CGFLOAT_IS_DOUBLE
    return INRound(value, digits);
#else
    return INRoundf(value, digits);
#endif
}
    
    
/**
 Returns the input float value ceiled up after a given number of digits after the decimal point.
 
    INCeilf(1.36, 0) = 2
    INCeilf(3.33, 1) = 3.4
    INCeilf(6.66, 1) = 6.7

 @param value The input float value which to ceil.
 @param digits The number of digits after the period from which to ceil.
 @return The ceiled value.
 */
static inline float INCeilf(float value, NSUInteger digits) {
    float shift = powf(10, digits);
    return ceilf(value * shift) / shift;
}


/**
 Returns the input double value ceiled up after a given number of digits after the decimal point.

    INCeil(1.36, 0) = 2
    INCeil(3.33, 1) = 3.4
    INCeil(6.66, 1) = 6.7

 @param value The input double value which to ceil.
 @param digits The number of digits after the period from which to ceil.
 @return The ceiled value.
 */
static inline double INCeil(double value, NSUInteger digits) {
    double shift = pow(10, digits);
    return ceil(value * shift) / shift;
}


/**
 Returns the input value ceiled up after a given number of digits after the decimal point.

 Same as INCeil and INCeilf, but depending on the CGFloat's type and architecture.

 @param value The input value which to ceil.
 @param digits The number of digits after the period from which to ceil.
 @return The ceiled value.
 */
static inline CGFloat INCeilFloat(CGFloat value, NSUInteger digits) {
#if CGFLOAT_IS_DOUBLE
    return INCeil(value, digits);
#else
    return INCeilf(value, digits);
#endif
}


/**
 Returns the input float value floored down after a given number of digits after the decimal point.

    INFloorf(1.36, 0) = 1
    INFloorf(3.33, 1) = 3.3
    INFloorf(6.66, 1) = 6.6

 @param value The input value which to floor.
 @param digits The number of digits after the period from which to floor.
 @return The floored value.
 */
static inline float INFloorf(float value, NSUInteger digits) {
    float shift = powf(10, digits);
    return floorf(value * shift) / shift;
}


/**
 Returns the input double value floored down after a given number of digits after the decimal point.

    INFloor(1.36, 0) = 1
    INFloor(3.33, 1) = 3.3
    INFloor(6.66, 1) = 6.6

 @param value The input double value which to floor.
 @param digits The number of digits after the period from which to floor.
 @return The floored value.
 */
static inline double INFloor(double value, NSUInteger digits) {
    double shift = pow(10, digits);
    return floor(value * shift) / shift;
}


/**
 Returns the input value floored down after a given number of digits after the decimal point.

 Same as INCeil and INCeilf, but depending on the CGFloat's type and architecture.

 @param value The input value which to floor.
 @param digits The number of digits after the period from which to floor.
 @return The floored value.
 */
static inline CGFloat INFloorFloat(CGFloat value, NSUInteger digits) {
#if CGFLOAT_IS_DOUBLE
    return INFloor(value, digits);
#else
    return INFloorf(value, digits);
#endif
}


    
#ifdef __cplusplus
}
#endif
