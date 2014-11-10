// NSDateFormatter+INExtensions.h
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


@interface NSDateFormatter (INExtensions)

#pragma mark - Caching formatters
/// @name Caching formatters

/**
 Returns a cached date formatter object for the given format string.
 
 If there is no date formatter for the given format a new formatter will be created.
 Creating a new NSDateFormatter is time expensive so use this method for reusing old formatters.
 When using background threads the date formatter should be locked with a synchronized command.
 
    NSString *string;
    NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"yyyy"];
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }

 For information about the date format pattern see:
 http://unicode.org/reports/tr35/tr35-10.html#Date_Format_Patterns
 
 @return A cached date formatter for the given format.
 */
+ (NSDateFormatter *)cachedDateFormatterForFormat:(NSString *)format;


@end
