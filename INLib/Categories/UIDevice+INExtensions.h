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
 True if this device is an iPad.
 
 If returning false the device may be an iPhone or iPod touch or something unknown.
 Uses UI_USER_INTERFACE_IDIOM.
 
 @return True if the code runs on an iPad, otherwise false.
 */
- (BOOL)isIPad;


/**
 Posts a memory warning message on DEBUG mode.
 
 This can be used on devices to simulate memory warnings.
 The notification is only send in a DEBUG environment, does nothing on non-DEBUG (release) modes.
 */
- (void)simulateMemoryWarning;


@end
