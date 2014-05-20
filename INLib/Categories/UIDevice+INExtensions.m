// UIDevice+INExtensions.m
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


#import "UIDevice+INExtensions.h"


@implementation UIDevice (INExtensions)

- (BOOL)isIPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return UI_USER_INTERFACE_IDIOM();
#else
    return NO;
#endif
}

- (void)simulateMemoryWarning {
#ifdef DEBUG
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),    (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
}

- (BOOL)hasRetinaDisplay {
	if ([UIScreen mainScreen].scale == 2.0f) return YES;
	return NO;
}

- (BOOL)has3Dot5InchesDisplay {
    // iPhone 3GS, 4, 4S Display
    return [UIScreen mainScreen].bounds.size.height == 480.f && [UIScreen mainScreen].bounds.size.width == 320.f;
}

- (BOOL)has4InchesDisplay {
    // iPhone 5+ Display
    return [UIScreen mainScreen].bounds.size.height == 568.f && [UIScreen mainScreen].bounds.size.width == 320.f;
}

@end
