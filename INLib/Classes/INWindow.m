// INWindow.m
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


#import "INWindow.h"


static __weak INWindow *__INWindowInstance = nil;


@implementation INWindow

+ (INWindow *)mainWindow {
    return __INWindowInstance;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        __INWindowInstance = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        __INWindowInstance = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        __INWindowInstance = self;
    }
    return self;
}

- (void)dealloc {
    if (__INWindowInstance == self) {
        __INWindowInstance = nil;
    }
}

- (void)sendEvent:(UIEvent *)event {
    BOOL ignoreEvent = NO;
    if ([self.windowDelegate respondsToSelector:@selector(window:shouldIgnoreEvent:)]) {
        ignoreEvent = [self.windowDelegate window:self shouldIgnoreEvent:event];

    }
    if (!ignoreEvent) {
        [super sendEvent:event];
    }
}

@end
