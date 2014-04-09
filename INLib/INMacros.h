// INMacros.h
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
 Fails and terminates the app in DEBUG mode only, by calling NSAssert(false). On non-DEBUG mode (release) this macro does nothing (will be replaced by a comment).
 */
#ifdef DEBUG
    #define DFail(_message_) NSAssert(false, _message_)
#else
    #define DFail(_message_) { /* */ }
#endif

/**
 Asserts a condition in DEBUG mode, by calling NSAssert(). On non-DEBUG mode (release) this macro does nothing (will be replaced by a comment).
 */
#ifdef DEBUG
    #define DAssert(_condition_) NSAssert((_condition_), @"Assert failed")
#else
    #define DAssert(_condition_) { /* */ }
#endif

/**
 Prints the given parameter onto the console in DEBUG mode, by calling NSLog(). On non-DEBUG mode (release) this macro does nothing (will be replaced by a comment).
 */
#ifdef DEBUG
    #define DLog(...) NSLog(__VA_ARGS__)
#else
    #define DLog(...) { /* */ }
#endif


/**
 Prints the given NSRect struct onto the console via DLog().
 */
#define DLogRect(_rect_) DLog(@"X:%.0f Y:%.0f W:%.0f H:%.0f", _rect_.origin.x, _rect_.origin.y, _rect_.size.width, _rect_.size.height)

/**
 Prints the given NSSize struct onto the console via DLog().
 */
#define DLogSize(_size_) DLog(@"W:%.0f H:%.0f", _size_.width, _size_.height)

/**
 Prints the given NSPoint struct onto the console via DLog().
 */
#define DLogPoint(_point_) DLog(@"X:%.0f Y:%.0f", _point_.x, _point_.y)


/**
 Prints the parameter into a string, so calling STRINGIFY_MACRO(MY_MACRO) will return @"MY_MACRO".
 */
#define STRINGIFY_MACRO(f) #f

/**
 Prints the macro's value into a string so it can be accessed in code.
 
    #define MY_MACRO Foo
    NSString *string = [NSString stringWithFormat:@"%s", STRINGIFY_MACROVALUE(MY_MACRO)];
    // string == @"Foo"
 
 */
#define STRINGIFY_MACROVALUE(f) STRINGIFY_MACRO(f)


// ------------------------------------------------------------
#pragma mark - singleton
// ------------------------------------------------------------
/// @name singleton macros

/**
 Declaration part for a singleton.
 
 This macro goes to the class interface declaration in the h file.
 Creates the methods shareInstance and destroySharedInstance.
 
    @interface MyClass
 
    INSingletonDeclaration
 
    ...
 
    @end
 
 To get the instance call
 
    instance = [MyClass sharedInstance];
 
 */
#define INSingletonDeclaration \
+ (id)sharedInstance; \
\
+ (void)destroySharedInstance;


/**
 Definition part for a singleton.
 
 This macro goes to the class implementation in the m/mm file.

    @implementation MyClass
 
    INSingletonDefinition
 
    ...
 
    @end
 
 */
#define INSingletonDefinition \
static id __singletonInstance = nil; \
+ (id)sharedInstance { \
if (__singletonInstance == nil) { \
__singletonInstance = [[self alloc] init]; \
} \
return __singletonInstance; \
} \
\
+ (void)destroySharedInstance { \
__singletonInstance = nil; \
}


