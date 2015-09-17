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
    info.weekday = 0;
    return info;
}


// private declarations
@interface NSDate (INExtension)

+ (NSCalendar *)cachedGregorianCalendar;

@end


// use a static gregorian calendar for performance purposes because creating it at runtime is time expensive
static NSCalendar *__defaultCachedGregorianCalendar = nil;


@implementation NSDate (IExtensions)

#pragma mark - public methods

+ (NSCalendar *)cachedGregorianCalendar {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // create the calendar
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        [calendar setMinimumDaysInFirstWeek:4]; // US starts with 1, ISO 8601 starts with 4
        calendar.locale = [NSLocale currentLocale];
        __defaultCachedGregorianCalendar = calendar;
    });
    return __defaultCachedGregorianCalendar;
}

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
    if (printSign && seconds >= 0) {
        prefix = @"+";
    } else if (printSign && seconds < 0) {
        prefix = @"-";
    }
	NSString *time = nil;
	if (printSeconds) {
		time = [NSString stringWithFormat:@"%@%.2ld:%.2ld:%.2ld", prefix, labs(hour), labs(min), labs(secs)];
	} else {
		time = [NSString stringWithFormat:@"%@%.2ld:%.2ld", prefix, labs(hour), labs(min)];
	}
	return time;
}

- (BOOL)isToday {
    return [self isSameDay:[NSDate date]];
}

- (BOOL)isSameDay:(NSDate *)otherDate {
    NSDateComponents *comp1;
    NSDateComponents *comp2;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        NSUInteger components = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
        comp1 = [gregorian components:components fromDate:self];
        comp2 = [gregorian components:components fromDate:otherDate];
    }
    // isToday if day, month and year are equal
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

- (NSDate *)dateWithFirstOfYear {
    INDateInformation info = [self dateInformation];
    info.month = 1;
    info.day = 1;
    info.minute = 0;
    info.second = 0;
    info.hour = 0;
    return [NSDate dateWithDateInformation:info];
}

- (NSDate *)dateWithWeekstart:(NSInteger)daynumber {
    INDateInformation dateInfo = [self dateInformation];
    NSInteger daysToSub = (dateInfo.weekday - daynumber + 7) % 7;
    NSDate *date = [self dateWithDaysAdded:-daysToSub];
    return date;
}


- (NSInteger)yearNumber {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitYear fromDate:self];
    }
    return comps.year;
}

- (NSInteger)monthNumber {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitMonth fromDate:self];
    }
    return comps.month;
}

- (NSInteger)quarterNumber {
    return ([self monthNumber] - 1) / 3 + 1;
/*  // *Workaround* The code should be the following, but it seems there is a bug in iOS, so we calculate the quarter from the month instead.
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitQuarter fromDate:self];
    }
    return comps.quarter;
*/
}

- (NSInteger)weekNumberOfYear {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitWeekOfYear fromDate:self];
    }
    return comps.weekOfYear;
}

- (NSInteger)weekNumberOfMonth {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitWeekOfMonth fromDate:self];
    }
    return comps.weekOfMonth;
}

- (NSInteger)dayNumberOfMonth {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitDay fromDate:self];
    }
    return comps.day;
}

- (NSInteger)dayNumberOfYear {
    NSInteger dayOfYear;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        dayOfYear = [gregorian ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    }
    return dayOfYear;
}

- (NSInteger)dayNumberOfWeekInMonth {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitWeekdayOrdinal fromDate:self];
    }
    return comps.weekdayOrdinal;
}

- (NSInteger)weekdayNumber {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    }
    return comps.weekday;
}

- (NSInteger)hourNumber {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitHour fromDate:self];
    }
    return comps.hour;
}

- (NSInteger)minuteNumber {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitMinute fromDate:self];
    }
    return comps.minute;
}

- (NSInteger)secondNumber {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitSecond fromDate:self];
    }
    return comps.second;
}


- (NSInteger)yearsBetweenDate:(NSDate *)otherDate {
    NSDateComponents *comps;
    NSCalendar *gregorian = [NSDate cachedGregorianCalendar];
    @synchronized(gregorian) {
        comps = [gregorian components:NSCalendarUnitYear fromDate:self toDate:otherDate options:0];
    }
    
    return [comps year];
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
    INDateInformation dateInfo = INDateInformationMake(year, month, day, 0, 0, 0);
    NSDate *date = [NSDate dateWithDateInformation:dateInfo];
    return date;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    INDateInformation dateInfo = INDateInformationMake(year, month, day, hour, minute, second);
    NSDate *date = [NSDate dateWithDateInformation:dateInfo];
    return date;
}

- (NSDate *)dateWithTimeZeroed {
    NSUInteger components = NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay;
    INDateInformation dateInfo = [self dateInformationForComponents:components];
    NSDate *date = [NSDate dateWithDateInformation:dateInfo];
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
