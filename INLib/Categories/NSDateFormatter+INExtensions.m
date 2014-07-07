// NSDateFormatter+INExtensions.m
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


#import "NSDateFormatter+INExtensions.h"


// dict with cached NSDateFormatter objects, keys are the formatter strings
static NSMutableDictionary *__cachedDateFormatters;


@implementation NSDateFormatter (INExtensions)

+ (NSDateFormatter *)cachedDateFormatterForFormat:(NSString *)format {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __cachedDateFormatters = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        // add observer for clearing the cache
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:[UIApplication sharedApplication] queue:nil usingBlock:^(NSNotification *notification){
            @synchronized(__cachedDateFormatters) {
                [__cachedDateFormatters removeAllObjects];
            }
        }];
    });
    
    NSDateFormatter *dateFormatter = nil;
    @synchronized (__cachedDateFormatters) {
        dateFormatter = [__cachedDateFormatters objectForKey:format];
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:format];
            [__cachedDateFormatters setObject:dateFormatter forKey:format];
        }
    }
    return dateFormatter;
}


@end
