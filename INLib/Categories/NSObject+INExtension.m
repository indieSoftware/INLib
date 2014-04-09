// NSObject+INExtension.m
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


#import "NSObject+INExtension.h"
#import <objc/runtime.h>


static const char *bagKey = "objectBag";


@implementation NSObject (INExtension)

- (id)bag {
    return objc_getAssociatedObject(self, bagKey);
}

- (void)setBag:(id)oBag {
    objc_setAssociatedObject(self, bagKey, oBag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isNull {
	return [self isKindOfClass:[NSNull class]];
}

- (void)performSelector:(SEL)selector withParameters:(NSArray *)parameters {
    NSMethodSignature *methodSig = [[self class] instanceMethodSignatureForSelector:selector];
    NSAssert(methodSig != nil, @"Method signature not found on object");
    if (methodSig != nil) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        invocation.target = self;
        invocation.selector = selector;
        NSUInteger argumentIndex = 2;
        for (__unsafe_unretained id object in parameters) {
            [invocation setArgument:&object atIndex:argumentIndex];
            argumentIndex++;
        }
        [invocation invoke];
    }
}


@end
