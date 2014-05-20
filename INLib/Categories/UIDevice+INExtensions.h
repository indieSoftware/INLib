// UIDevice+INExtensions.h
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



@interface UIDevice (INExtensions)


/**
 Flag indicating whether this device is an iPad or not.
 
 @return True if the code runs on an iPad, otherwise false and it may be an iPhone or iPod touch or something unknown.
 */
- (BOOL)isIPad;


/**
 Posts a memory warning message.
 
 This can be used on devices to simulate memory warnings.
 The notification only works on a DEBUG environment, does nothing on RELEASE.
 */
- (void)simulateMemoryWarning;


/**
 Returns true if this device has a retina diplay.
 
 @return YES when the UIScreen's scale property is 2, otherwise NO.
 */
- (BOOL)hasRetinaDisplay;


/**
 Returns true if this device has a 3.5" display.
 
 @return YES if the UIScreen's bounds are 320x480, otherwise NO.
 */
- (BOOL)has3Dot5InchesDisplay;


/**
 Returns true if this device has a 4" display.
 
 @return YES if the UIScreen's bounds are 320x568, otherwise NO.
 */
- (BOOL)has4InchesDisplay;


@end
