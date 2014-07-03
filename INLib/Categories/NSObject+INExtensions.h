// NSObject+INExtensions.h
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


@interface NSObject (INExtensions)

/**
 Stores a NSObject at runtime to a bag.
 
 Uses objc_setAssociatedObject.
 
 @param bag A NSObject to hold.
 */
- (void)setBag:(id)bag;


/**
 Retrieves the stored NSObject bag.
 
 Uses objc_getAssociatedObject.
 
 @return The stored NSObject or nil.
 */
- (id)bag;


/**
 Checks whether this object is the null object or not.
 
 @return True if this object is NSNull, otherwise false.
 */
- (BOOL)isNull;


/**
 Invokes a selector on this object with the given parameters.
 
 This is a replacement for NSObject's performSelector:withObject: which brings up compiler warnings when using.
 The compiler warning can be silenced with
 
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:@selector(aSelector:) withObject:anObject];
    #pragma clang diagnostic pop
 
 but it is better to use NSInvocation what this method does.
 At plus it is possible to pass any number of parameters to the invoked method.
 
 @param selector The selector to call.
 @param parameters The parameters to pass. The number of parameters has to match the selector's signature.
 */
- (void)performSelector:(SEL)selector withParameters:(NSArray *)parameters;

@end
