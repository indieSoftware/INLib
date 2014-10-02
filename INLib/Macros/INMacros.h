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
 Prints the given parameter onto the console in DEBUG mode, by calling NSLog().
 On non-DEBUG mode (release) this macro does nothing (will be replaced by a comment).
 */
#ifdef DEBUG
    #define DLog(...) NSLog(__VA_ARGS__)
#else
    #define DLog(...) { /* */ }
#endif


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

 This defines the methods

    + (id)sharedInstance; // to get the singleton instance
    + (void)destroySharedInstance; // to destroy the singleton instance if needed
 
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
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        __singletonInstance = [[self alloc] init]; \
    }); \
    return __singletonInstance; \
} \
\
+ (void)destroySharedInstance { \
    __singletonInstance = nil; \
}


