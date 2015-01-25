// NSDate+INExtensions.m
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


#import "NSDate+INExtensions.h"
#import "NSDateFormatter+INExtensions.h"


INDateInformation INDateInformationMake(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
    INDateInformation info;
    info.year = year;
    info.month = month;
    info.day = day;
    info.hour = hour;
    info.minute = minute;
    info.second = second;
    return info;
}


// private declarations
@interface NSDate (INExtension)

+ (NSCalendar *)cachedGregorianCalendar;

@end


// use a static gregorian calendar for performance purposes because creating it at runtime is time expensive
static NSCalendar *__defaultCachedGregorianCalendar = nil;
// the last used weekday number as the first weekday in a week for the weekday calculating method
static NSUInteger __lastUsedFirstWeekday = 1; // sunday is apple's default for the U.S.
// the static date formatter for the weekday calculating method
static NSDateFormatter *__dateFormatterForWeekday = nil;


@implementation NSDate (IExtensions)


#pragma mark - private methods

+ (NSCalendar *)cachedGregorianCalendar {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // create the calendar
        __defaultCachedGregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [__defaultCachedGregorianCalendar setMinimumDaysInFirstWeek:4]; // iOS 5 workaround
    });
    return __defaultCachedGregorianCalendar;
}


#pragma mark - public methods

+ (NSInteger)secondsForDays:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds {
	return (days * 86400 + hours * 3600 + minutes * 60 + seconds);
}

+ (NSInteger)secondsForHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds {
	return [self secondsForDays:0 hours:hours minutes:minutes seconds:seconds];
}

+ (NSString *)stringRepresentationForSeconds:(NSInteger)seconds printSign:(BOOL)printSign printSeconds:(BOOL)printSeconds {
	NSInteger hour = (seconds / 3600) % 24;
	NSInteger rest = seconds % 3600;
	NSInteger min = rest / 60;
	NSInteger secs = rest % 60;
	NSString *prefix = @"";
	if (printSign && seconds >= 0) prefix = @"+";
	else if (printSign && seconds < 0) prefix = @"-";
	NSString *time = nil;
	if (printSeconds) {
		time = [NSString stringWithFormat:@"%@%.2ld:%.2ld:%.2ld", prefix, (long)fabs(hour), (long)fabs(min), (long)fabs(secs)];
	} else {
		time = [NSString stringWithFormat:@"%@%.2ld:%.2ld", prefix, (long)fabs(hour), (long)fabs(min)];
	}
	return time;
}

- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setMinimumDaysInFirstWeek:4]; // iOS 5 workaround

    NSUInteger components = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:components fromDate:self];
    NSDateComponents *comp2 = [calendar components:components fromDate:[NSDate date]];

    // isToday if day, month and year of NSDate are equal
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
}

- (BOOL)isSameDay:(NSDate *)otherDate {
	NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setMinimumDaysInFirstWeek:4]; // iOS 5 workaround
    
    NSUInteger components = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
	NSDateComponents *comp1 = [calendar components:components fromDate:self];
	NSDateComponents *comp2 = [calendar components:components fromDate:otherDate];
    
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
} 


- (INDateInformation)dateInformation {
    NSUInteger components = NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond;
    return [self dateInformationForComponents:components];
}

- (INDateInformation)dateInformationForComponents:(NSCalendarUnit)components {
    INDateInformation info;
    
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        NSDateComponents *comp = [gregorian components:components fromDate:self];
        
        info.year = [comp year];
        info.month = [comp month];
        info.day = [comp day];
        info.weekday = [comp weekday];
        info.hour = [comp hour];
        info.minute = [comp minute];
        info.second = [comp second];
    }
    
    return info;
}

- (INDateInformation)dateInformationWithTimeZone:(NSTimeZone *)timeZone {
	INDateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setMinimumDaysInFirstWeek:4]; // iOS 5 workaround
	[gregorian setTimeZone:timeZone];
    NSUInteger components = NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond;
	NSDateComponents *comp = [gregorian components:components fromDate:self];
    
	info.year = [comp year];
	info.month = [comp month];
	info.day = [comp day];
	info.weekday = [comp weekday];
	info.hour = [comp hour];
	info.minute = [comp minute];
	info.second = [comp second];
	
	return info;
}

+ (NSDate *)dateWithDateInformation:(INDateInformation)dateInfo timeZone:(NSTimeZone*)timeZone {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:dateInfo.year];
    [comps setMonth:dateInfo.month];
    [comps setDay:dateInfo.day];
    [comps setHour:dateInfo.hour];
    [comps setMinute:dateInfo.minute];
    [comps setSecond:dateInfo.second];
    [comps setTimeZone:timeZone];

    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    NSDate *date;
    @synchronized(gregorian) {
        date = [gregorian dateFromComponents:comps];
    }
    
    return date;
}

+ (NSDate *)dateWithDateInformation:(INDateInformation)dateInfo {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:dateInfo.year];
    [comps setMonth:dateInfo.month];
    [comps setDay:dateInfo.day];
    [comps setHour:dateInfo.hour];
    [comps setMinute:dateInfo.minute];
    [comps setSecond:dateInfo.second];
	
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    NSDate *date;
    @synchronized(gregorian) {
        date = [gregorian dateFromComponents:comps];
    }
    
    return date;
}

- (NSDate *)dateWithFirstOfMonth {
	INDateInformation info = [self dateInformation];
	info.day = 1;
	info.minute = 0;
	info.second = 0;
	info.hour = 0;
	return [NSDate dateWithDateInformation:info];
}

- (NSDate *)dateWithLastOfMonth {
	INDateInformation info = [self dateInformation];
    NSDate *temp;
    for (NSInteger i = 0; i < 4; i++) {
        info.day = 31 - i;
        info.minute = 0;
        info.second = 0;
        info.hour = 0;
        temp = [NSDate dateWithDateInformation:info];
        if ([temp dayNumberOfMonth] == 31 - i) {
            break;
        }
    }
    return temp;
}

- (NSDate *)dateWithNextMonth {
	INDateInformation info = [self dateInformation];
	info.month++;
	if (info.month > 12) {
		info.month = 1;
		info.year++;
	}
    NSInteger month = info.month;
    NSDate *date = [NSDate dateWithDateInformation:info];
    if (date.monthNumber != month) {
        return [[[date dateWithFirstOfMonth] dateWithPrevMonth] dateWithLastOfMonth];
    }
    return date;
}

- (NSDate *)dateWithPrevMonth {
	INDateInformation info = [self dateInformation];
	info.month--;
	if (info.month < 1) {
		info.month = 12;
		info.year--;
	}
    NSInteger month = info.month;
    NSDate *date = [NSDate dateWithDateInformation:info];
    if (date.monthNumber != month) {
        return [[[date dateWithFirstOfMonth] dateWithPrevMonth] dateWithLastOfMonth];
    }
    return date;
}

- (NSDate *)dateWithWeekstart:(NSInteger)daynumber {
    INDateInformation dateInfo = [self dateInformation];
    NSInteger daysToSub = (dateInfo.weekday - daynumber + 7) % 7;
    NSDate *date = [self dateWithDaysAdded:-daysToSub];
    return date;
}


// see http://unicode.org/reports/tr35/tr35-10.html#Date_Format_Patterns

- (NSInteger)yearNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"yyyy"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)monthNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"MM"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)quarterNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"q"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

+ (void)createDateFormatterForWeekdateIfNeeded {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // create the date formatter
        __dateFormatterForWeekday = [[NSDateFormatter alloc] init];
        [__dateFormatterForWeekday setDateFormat:@"ww"];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [gregorian setMinimumDaysInFirstWeek:4]; // iOS 5 workaround
        [gregorian setLocale:[NSLocale currentLocale]]; // use to determine first weekday
        __lastUsedFirstWeekday = gregorian.firstWeekday;
        __dateFormatterForWeekday.calendar = gregorian;
    });
}

- (NSInteger)weekNumberOfYearBeginningWithFirstWeekday:(NSUInteger)firstWeekday {
    // use static date formatter for performance purposes
    [NSDate createDateFormatterForWeekdateIfNeeded];
    
    // change weekday only if necessary
    if (__lastUsedFirstWeekday != firstWeekday) {
        @synchronized(__dateFormatterForWeekday) {
            NSCalendar *gregorian = __dateFormatterForWeekday.calendar;
            [gregorian setFirstWeekday:firstWeekday];
            __dateFormatterForWeekday.calendar = gregorian; // needs to be assigned back
            __lastUsedFirstWeekday = firstWeekday;
        }
    }
    
    // get the value
	NSString *string = [__dateFormatterForWeekday stringFromDate:self];
	return [string intValue];
}

- (NSInteger)weekNumberOfYear {
    // use static date formatter for performance purposes
    [NSDate createDateFormatterForWeekdateIfNeeded];
    
    // get the value
	NSString *string = [__dateFormatterForWeekday stringFromDate:self];
	return [string intValue];
}

+ (NSUInteger)firstWeekdayUsedForWeekNumberDateFormatter {
    // use static date formatter for performance purposes
    [NSDate createDateFormatterForWeekdateIfNeeded];
    
    return __dateFormatterForWeekday.calendar.firstWeekday;
}

- (NSInteger)weekNumberOfMonth {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"W"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)dayNumberOfMonth {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"dd"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)dayNumberOfYear {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"DDD"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)dayNumberOfWeekInMonth {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"F"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)weekdayNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"e"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)hourNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"HH"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)minuteNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"mm"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSInteger)secondNumber {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"ss"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
	return [string intValue];
}

- (NSString *)stringWithMonthName {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"MMMM"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
    return string;
}

- (NSString *)stringWithWeekdayName {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"eeee"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
    return string;
}

- (NSString *)stringWithWeekdayNameShort {
	NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"eee"];
    NSString *string = nil;
    @synchronized(dateFormatter) {
        string = [dateFormatter stringFromDate:self];
    }
    return string;
}

- (NSInteger)monthsBetweenDate:(NSDate *)otherDate {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitMonth fromDate:self toDate:otherDate options:0];
    }
    
    return [comps month];
}

- (NSInteger)daysBetweenDate:(NSDate *)otherDate {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitDay fromDate:self toDate:otherDate options:0];
    }
    
    return [comps day];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"yyyy-MM-dd"];
    NSDate *date = nil;
    @synchronized(dateFormatter) {
        NSString *string = [[NSString alloc] initWithFormat:@"%ld-%02ld-%02ld", (long)year, (long)month, (long)day];
        date = [dateFormatter dateFromString:string];
    }
	return date;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = nil;
    @synchronized(dateFormatter) {
        NSString *string = [[NSString alloc] initWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
        date = [dateFormatter dateFromString:string];
    }
	return date;
}

- (NSDate *)dateWithTimeZeroed {
    NSDateFormatter *dateFormatter = [NSDateFormatter cachedDateFormatterForFormat:@"yyyy-MM-dd"];
    NSDate *date = nil;
    @synchronized(dateFormatter) {
        NSString *string = [dateFormatter stringFromDate:self];
        date = [dateFormatter dateFromString:string];
    }
    return date;
}

- (NSDate *)dateWithDaysAdded:(NSInteger)days {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setDay:days];
	NSDate *newDate;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        newDate = [gregorian dateByAddingComponents:components toDate:self options:0];
    }
	return newDate;
}

- (NSDate *)dateWithMonthsAdded:(NSInteger)months {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMonth:months];
	NSDate *newDate;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        newDate = [gregorian dateByAddingComponents:components toDate:self options:0];
    }
	return newDate;
}

- (NSDate *)dateWithYearsAdded:(NSInteger)years {
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear:years];
	NSDate *newDate;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        newDate = [gregorian dateByAddingComponents:components toDate:self options:0];
    }
	return newDate;
}


- (BOOL)isBeforeDate:(NSDate *)otherDate {
    return [self compare:otherDate] == NSOrderedAscending;
}

- (BOOL)isAfterDate:(NSDate *)otherDate {
    return [self compare:otherDate] == NSOrderedDescending;
}


@end
