//
//  NSDateTests.m
//  INLibExample
//
//  Created by Sven Korset on 10.07.15.
//  Copyright (c) 2015 indie-Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface NSDateTests : XCTestCase

@end

@implementation NSDateTests

- (void)setUp {
    [super setUp];
    
    // Set the time zone to GMT for all calendar calculations
    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    @synchronized(calendar) {
        calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        calendar.firstWeekday = 2;
        [calendar setMinimumDaysInFirstWeek:4];
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - INDateInformation

- (void)test_INDateInformation {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    NSUInteger components = NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond;
    INDateInformation dateInfo = [date dateInformationForComponents:components];
    XCTAssert(dateInfo.year == 1970, @"Result is not correct '%ld'", (long)dateInfo.year);
    XCTAssert(dateInfo.month == 1, @"Result is not correct '%ld'", (long)dateInfo.month);
    XCTAssert(dateInfo.day == 1, @"Result is not correct '%ld'", (long)dateInfo.day);
    XCTAssert(dateInfo.weekday == 5, @"Result is not correct '%ld'", (long)dateInfo.weekday); // Thursday
    XCTAssert(dateInfo.hour == 0, @"Result is not correct '%ld'", (long)dateInfo.hour);
    XCTAssert(dateInfo.minute == 0, @"Result is not correct '%ld'", (long)dateInfo.minute);
    XCTAssert(dateInfo.second == 0, @"Result is not correct '%ld'", (long)dateInfo.second);

    // The time zone next to GMT (+1h)
    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600];
    dateInfo = [date dateInformationForComponents:components];
    XCTAssert(dateInfo.year == 1970, @"Result is not correct '%ld'", (long)dateInfo.year);
    XCTAssert(dateInfo.month == 1, @"Result is not correct '%ld'", (long)dateInfo.month);
    XCTAssert(dateInfo.day == 1, @"Result is not correct '%ld'", (long)dateInfo.day);
    XCTAssert(dateInfo.weekday == 5, @"Result is not correct '%ld'", (long)dateInfo.weekday);
    XCTAssert(dateInfo.hour == 1, @"Result is not correct '%ld'", (long)dateInfo.hour);
    XCTAssert(dateInfo.minute == 0, @"Result is not correct '%ld'", (long)dateInfo.minute);
    XCTAssert(dateInfo.second == 0, @"Result is not correct '%ld'", (long)dateInfo.second);
    
    // Check only minutes with date with 4 hours, 2 minutes and 3 seconds after 1970
    date = [NSDate dateWithTimeIntervalSince1970:14523];
    components = NSCalendarUnitMinute;
    dateInfo = [date dateInformationForComponents:components];
    XCTAssert(dateInfo.minute == 2, @"Result is not correct '%ld'", (long)dateInfo.minute);
    // the other dateInfo properties are undefined
    
    // Reset time zone
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    // Get all components via direct method
    dateInfo = [date dateInformation];
    XCTAssert(dateInfo.year == 1970, @"Result is not correct '%ld'", (long)dateInfo.year);
    XCTAssert(dateInfo.month == 1, @"Result is not correct '%ld'", (long)dateInfo.month);
    XCTAssert(dateInfo.day == 1, @"Result is not correct '%ld'", (long)dateInfo.day);
    XCTAssert(dateInfo.weekday == 5, @"Result is not correct '%ld'", (long)dateInfo.weekday);
    XCTAssert(dateInfo.hour == 4, @"Result is not correct '%ld'", (long)dateInfo.hour);
    XCTAssert(dateInfo.minute == 2, @"Result is not correct '%ld'", (long)dateInfo.minute);
    XCTAssert(dateInfo.second == 3, @"Result is not correct '%ld'", (long)dateInfo.second);
    
    // Use the date info to get the same date
    NSDate *date2 = [NSDate dateWithDateInformation:dateInfo];
    XCTAssert([date isEqualToDate:date2], @"Result '%@' is not as expected '%@'", date, date2);
    
    // We put the dateInfo into the time zone (GMT +1h) so dateInfo2 with (GMT +0) is the same but -1h
    date2 = [NSDate dateWithDateInformation:dateInfo timeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600]];
    INDateInformation dateInfo2 = [date2 dateInformation];
    XCTAssert(dateInfo.year == dateInfo2.year, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.year, (long)dateInfo2.year);
    XCTAssert(dateInfo.month == dateInfo2.month, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.month, (long)dateInfo2.month);
    XCTAssert(dateInfo.day == dateInfo2.day, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.day, (long)dateInfo2.day);
    XCTAssert(dateInfo.weekday == dateInfo2.weekday, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.weekday, (long)dateInfo2.weekday);
    XCTAssert(dateInfo.hour - 1 == dateInfo2.hour, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.hour, (long)dateInfo2.hour);
    XCTAssert(dateInfo.minute == dateInfo2.minute, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.minute, (long)dateInfo2.minute);
    XCTAssert(dateInfo.second == dateInfo2.second, @"Result '%ld' is not as expected '%ld'", (long)dateInfo.second, (long)dateInfo2.second);
}


#pragma mark - Date initializers

- (void)test_dateWithYear_month_day_hour_minute_second {
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:10 hour:11 minute:48 second:50];
    INDateInformation dateInfo = [date dateInformation];
    XCTAssert(dateInfo.year == 2015, @"Result is not correct '%ld'", (long)dateInfo.year);
    XCTAssert(dateInfo.month == 7, @"Result is not correct '%ld'", (long)dateInfo.month);
    XCTAssert(dateInfo.day == 10, @"Result is not correct '%ld'", (long)dateInfo.day);
    XCTAssert(dateInfo.weekday == 6, @"Result is not correct '%ld'", (long)dateInfo.weekday);
    XCTAssert(dateInfo.hour == 11, @"Result is not correct '%ld'", (long)dateInfo.hour);
    XCTAssert(dateInfo.minute == 48, @"Result is not correct '%ld'", (long)dateInfo.minute);
    XCTAssert(dateInfo.second == 50, @"Result is not correct '%ld'", (long)dateInfo.second);
}

- (void)test_dateWithYear_month_day {
    NSDate *date = [NSDate dateWithYear:2014 month:5 day:1];
    INDateInformation dateInfo = [date dateInformation];
    XCTAssert(dateInfo.year == 2014, @"Result is not correct '%ld'", (long)dateInfo.year);
    XCTAssert(dateInfo.month == 5, @"Result is not correct '%ld'", (long)dateInfo.month);
    XCTAssert(dateInfo.day == 1, @"Result is not correct '%ld'", (long)dateInfo.day);
    XCTAssert(dateInfo.weekday == 5, @"Result is not correct '%ld'", (long)dateInfo.weekday);
    XCTAssert(dateInfo.hour == 0, @"Result is not correct '%ld'", (long)dateInfo.hour);
    XCTAssert(dateInfo.minute == 0, @"Result is not correct '%ld'", (long)dateInfo.minute);
    XCTAssert(dateInfo.second == 0, @"Result is not correct '%ld'", (long)dateInfo.second);
}


#pragma mark - Seconds calculations

- (void)test_secondsForDays_hours_minutes_seconds {
    NSInteger result = [NSDate secondsForDays:4 hours:3 minutes:2 seconds:1];
    XCTAssert(result == 356521, @"Result is not correct '%ld'", result);
}

- (void)test_secondsForHours_minutes_seconds {
    NSInteger result = [NSDate secondsForHours:4 minutes:24 seconds:42];
    XCTAssert(result == 15882, @"Result is not correct '%ld'", result);
}

- (void)test_stringRepresentationForSeconds_printSign_printSeconds {
    NSString *result = [NSDate stringRepresentationForSeconds:3723 printSign:NO printSeconds:NO];
    XCTAssert([result isEqualToString:@"01:02"], @"Result is not correct '%@'", result);

    result = [NSDate stringRepresentationForSeconds:3723 printSign:NO printSeconds:YES];
    XCTAssert([result isEqualToString:@"01:02:03"], @"Result is not correct '%@'", result);
    
    result = [NSDate stringRepresentationForSeconds:3723 printSign:YES printSeconds:NO];
    XCTAssert([result isEqualToString:@"+01:02"], @"Result is not correct '%@'", result);
    
    result = [NSDate stringRepresentationForSeconds:3723 printSign:YES printSeconds:YES];
    XCTAssert([result isEqualToString:@"+01:02:03"], @"Result is not correct '%@'", result);
    

    result = [NSDate stringRepresentationForSeconds:-59 printSign:NO printSeconds:NO];
    XCTAssert([result isEqualToString:@"00:00"], @"Result is not correct '%@'", result);
    
    result = [NSDate stringRepresentationForSeconds:-59 printSign:NO printSeconds:YES];
    XCTAssert([result isEqualToString:@"00:00:59"], @"Result is not correct '%@'", result);
    
    result = [NSDate stringRepresentationForSeconds:-59 printSign:YES printSeconds:NO];
    XCTAssert([result isEqualToString:@"-00:00"], @"Result is not correct '%@'", result);
    
    result = [NSDate stringRepresentationForSeconds:-59 printSign:YES printSeconds:YES];
    XCTAssert([result isEqualToString:@"-00:00:59"], @"Result is not correct '%@'", result);
}


#pragma mark - Comparing methods

- (void)test_isToday {
    NSDate *date = [NSDate date];
    BOOL result = [date isToday];
    XCTAssert(result == YES, @"Result is not correct");

    date = [NSDate dateWithTimeIntervalSince1970:0];
    result = [date isToday];
    XCTAssert(result == NO, @"Result is not correct");
}

- (void)test_isSameDay {
    NSDate *date1 = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSDate *date2 = [NSDate dateWithYear:2011 month:4 day:4 hour:22 minute:12 second:33];
    BOOL result = [date1 isSameDay:date2];
    XCTAssert(result == YES, @"Result is not correct");
    
    date2 = [NSDate dateWithYear:2011 month:4 day:3 hour:22 minute:12 second:33];
    result = [date1 isSameDay:date2];
    XCTAssert(result == NO, @"Result is not correct");

    date1 = [NSDate dateWithYear:2011 month:4 day:2 hour:22 minute:12 second:33];
    result = [date1 isSameDay:date2];
    XCTAssert(result == NO, @"Result is not correct");
    
    date1 = date2;
    result = [date1 isSameDay:date2];
    XCTAssert(result == YES, @"Result is not correct");
}

- (void)test_isBeforeDate {
    NSDate *date1 = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSDate *date2 = [NSDate dateWithYear:2011 month:4 day:4 hour:22 minute:12 second:33];
    BOOL result = [date1 isBeforeDate:date2];
    XCTAssert(result == YES, @"Result is not correct");
    
    date1 = [NSDate dateWithYear:2012 month:8 day:14 hour:12 minute:0 second:0];
    date2 = [NSDate dateWithYear:2012 month:1 day:29 hour:12 minute:0 second:0];
    result = [date1 isBeforeDate:date2];
    XCTAssert(result == NO, @"Result is not correct");
    
    date1 = date2;
    result = [date1 isBeforeDate:date2];
    XCTAssert(result == NO, @"Result is not correct");
}

- (void)test_isAfterDate {
    NSDate *date1 = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSDate *date2 = [NSDate dateWithYear:2011 month:4 day:4 hour:22 minute:12 second:33];
    BOOL result = [date1 isAfterDate:date2];
    XCTAssert(result == NO, @"Result is not correct");
    
    date1 = [NSDate dateWithYear:2012 month:8 day:14 hour:12 minute:0 second:0];
    date2 = [NSDate dateWithYear:2012 month:1 day:29 hour:12 minute:0 second:0];
    result = [date1 isAfterDate:date2];
    XCTAssert(result == YES, @"Result is not correct");
    
    date1 = date2;
    result = [date1 isAfterDate:date2];
    XCTAssert(result == NO, @"Result is not correct");
}


#pragma mark - Date manipulation methods

- (void)test_dateWithTimeZeroed {
    NSDate *date = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSDate *result = [date dateWithTimeZeroed];
    NSDate *expected = [NSDate dateWithYear:2011 month:4 day:4];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    result = [result dateWithTimeZeroed];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithDaysAdded {
    NSDate *date = [NSDate dateWithYear:2011 month:5 day:2];
    NSDate *result = [date dateWithDaysAdded:2];
    NSDate *expected = [NSDate dateWithYear:2011 month:5 day:4];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    result = [date dateWithDaysAdded:405];
    expected = [NSDate dateWithYear:2012 month:6 day:10];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    result = [date dateWithDaysAdded:-5];
    expected = [NSDate dateWithYear:2011 month:4 day:27];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithMonthsAdded {
    NSDate *date = [NSDate dateWithYear:2011 month:5 day:2];
    NSDate *result = [date dateWithMonthsAdded:2];
    NSDate *expected = [NSDate dateWithYear:2011 month:7 day:2];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    result = [date dateWithMonthsAdded:12];
    expected = [NSDate dateWithYear:2012 month:5 day:2];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    date = [NSDate dateWithYear:2011 month:1 day:31];
    result = [date dateWithMonthsAdded:1];
    expected = [NSDate dateWithYear:2011 month:2 day:28];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    result = [date dateWithMonthsAdded:-1];
    expected = [NSDate dateWithYear:2010 month:12 day:31];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    result = [date dateWithMonthsAdded:-2];
    expected = [NSDate dateWithYear:2010 month:11 day:30];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithYearsAdded {
    NSDate *date = [NSDate dateWithYear:2011 month:5 day:2];
    NSDate *result = [date dateWithYearsAdded:5];
    NSDate *expected = [NSDate dateWithYear:2016 month:5 day:2];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    result = [date dateWithYearsAdded:-12];
    expected = [NSDate dateWithYear:1999 month:5 day:2];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithFirstOfMonth {
    NSDate *date = [NSDate dateWithYear:2011 month:5 day:20];
    NSDate *result = [date dateWithFirstOfMonth];
    NSDate *expected = [NSDate dateWithYear:2011 month:5 day:1];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    date = [NSDate dateWithYear:2011 month:1 day:1];
    result = [date dateWithFirstOfMonth];
    XCTAssertEqual(result, date, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithLastOfMonth {
    NSDate *date = [NSDate dateWithYear:2011 month:5 day:20];
    NSDate *result = [date dateWithLastOfMonth];
    NSDate *expected = [NSDate dateWithYear:2011 month:5 day:31];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    date = [NSDate dateWithYear:2011 month:1 day:31];
    result = [date dateWithLastOfMonth];
    XCTAssertEqual(result, date, @"Result is not correct %@ - %@", result, expected);

    date = [NSDate dateWithYear:2011 month:2 day:1];
    result = [date dateWithLastOfMonth];
    expected = [NSDate dateWithYear:2011 month:2 day:28];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithNextMonth {
    NSDate *date = [NSDate dateWithYear:2011 month:10 day:31];
    NSDate *result = [date dateWithNextMonth];
    NSDate *expected = [NSDate dateWithYear:2011 month:11 day:30];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    result = [result dateWithNextMonth];
    expected = [NSDate dateWithYear:2011 month:12 day:30];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    result = [result dateWithNextMonth];
    expected = [NSDate dateWithYear:2012 month:1 day:30];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithPrevMonth {
    NSDate *date = [NSDate dateWithYear:2011 month:3 day:31];
    NSDate *result = [date dateWithPrevMonth];
    NSDate *expected = [NSDate dateWithYear:2011 month:2 day:28];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    result = [result dateWithPrevMonth];
    expected = [NSDate dateWithYear:2011 month:1 day:28];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    result = [result dateWithPrevMonth];
    expected = [NSDate dateWithYear:2010 month:12 day:28];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithFirstOfYear {
    NSDate *date = [NSDate dateWithYear:2011 month:5 day:20];
    NSDate *result = [date dateWithFirstOfYear];
    NSDate *expected = [NSDate dateWithYear:2011 month:1 day:1];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    date = [NSDate dateWithYear:2011 month:1 day:1];
    result = [date dateWithFirstOfYear];
    XCTAssertEqual(result, date, @"Result is not correct %@ - %@", result, expected);
}

- (void)test_dateWithWeekstart {
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:24];
    NSDate *result = [date dateWithWeekstart:2];
    NSDate *expected = [NSDate dateWithYear:2015 month:7 day:20];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    result = [date dateWithWeekstart:1];
    expected = [NSDate dateWithYear:2015 month:7 day:19];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    date = [NSDate dateWithYear:2015 month:7 day:20];
    result = [date dateWithWeekstart:2];
    expected = [NSDate dateWithYear:2015 month:7 day:20];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);

    date = [NSDate dateWithYear:2015 month:7 day:19];
    result = [date dateWithWeekstart:1];
    expected = [NSDate dateWithYear:2015 month:7 day:19];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    date = [NSDate dateWithYear:2015 month:7 day:19];
    result = [date dateWithWeekstart:2];
    expected = [NSDate dateWithYear:2015 month:7 day:13];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
    
    date = [NSDate dateWithYear:2015 month:7 day:18];
    result = [date dateWithWeekstart:1];
    expected = [NSDate dateWithYear:2015 month:7 day:12];
    XCTAssertEqual(result, expected, @"Result is not correct %@ - %@", result, expected);
}


#pragma mark - Date details accessing

- (void)test_yearNumber {
    NSInteger expected = 2015;
    NSDate *date = [NSDate dateWithYear:expected month:7 day:24];
    NSInteger result = [date yearNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1024;
    date = [NSDate dateWithYear:expected month:1 day:1];
    result = [date yearNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_monthNumber {
    NSInteger expected = 7;
    NSDate *date = [NSDate dateWithYear:2015 month:expected day:24];
    NSInteger result = [date monthNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2015 month:expected day:1];
    result = [date monthNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_quarterNumber {
    NSInteger expected = 3;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:24];
    NSInteger result = [date quarterNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2015 month:1 day:1];
    result = [date quarterNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_weekNumberOfYear {
    // ISO 8601
    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    @synchronized(calendar) {
        calendar.firstWeekday = 2;
        [calendar setMinimumDaysInFirstWeek:4];
    }

    NSInteger expected = 29;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:19];
    NSInteger result = [date weekNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 52;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date weekNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 52;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date weekNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    
    // US
    @synchronized(calendar) {
        calendar.firstWeekday = 1;
        [calendar setMinimumDaysInFirstWeek:1];
    }
    
    expected = 30;
    date = [NSDate dateWithYear:2015 month:7 day:19];
    result = [date weekNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date weekNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 53;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date weekNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_weekNumberOfMonth {
    // ISO 8601
    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    @synchronized(calendar) {
        calendar.firstWeekday = 2;
        [calendar setMinimumDaysInFirstWeek:4];
    }
    
    NSInteger expected = 3;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:19];
    NSInteger result = [date weekNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 0;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date weekNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 5;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date weekNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    
    // US
    @synchronized(calendar) {
        calendar.firstWeekday = 1;
        [calendar setMinimumDaysInFirstWeek:1];
    }
    
    expected = 4;
    date = [NSDate dateWithYear:2015 month:7 day:19];
    result = [date weekNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date weekNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 5;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date weekNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_dayNumberOfMonth {
    NSInteger expected = 19;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:19];
    NSInteger result = [date dayNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date dayNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 31;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date dayNumberOfMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_dayNumberOfYear {
    NSInteger expected = 200;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:19];
    NSInteger result = [date dayNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date dayNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 365;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date dayNumberOfYear];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_dayNumberOfWeekInMonth {
    NSInteger expected = 3;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:19];
    NSInteger result = [date dayNumberOfWeekInMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date dayNumberOfWeekInMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 5;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date dayNumberOfWeekInMonth];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_weekdayNumber {
    NSInteger expected = 1;
    NSDate *date = [NSDate dateWithYear:2015 month:7 day:19];
    NSInteger result = [date weekdayNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date = [NSDate dateWithYear:2017 month:1 day:1];
    result = [date weekdayNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 7;
    date = [NSDate dateWithYear:2011 month:12 day:31];
    result = [date weekdayNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_hourNumber {
    NSInteger expected = 2;
    NSDate *date = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSInteger result = [date hourNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 0;
    date = [NSDate dateWithYear:2011 month:4 day:4 hour:0 minute:0 second:59];
    result = [date hourNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 23;
    date = [NSDate dateWithYear:2011 month:4 day:4 hour:23 minute:59 second:0];
    result = [date hourNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_minuteNumber {
    NSInteger expected = 40;
    NSDate *date = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSInteger result = [date minuteNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 0;
    date = [NSDate dateWithYear:2011 month:4 day:4 hour:0 minute:0 second:59];
    result = [date minuteNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 59;
    date = [NSDate dateWithYear:2011 month:4 day:4 hour:23 minute:59 second:0];
    result = [date minuteNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_secondNumber {
    NSInteger expected = 12;
    NSDate *date = [NSDate dateWithYear:2011 month:4 day:4 hour:2 minute:40 second:12];
    NSInteger result = [date secondNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 59;
    date = [NSDate dateWithYear:2011 month:4 day:4 hour:0 minute:0 second:59];
    result = [date secondNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 0;
    date = [NSDate dateWithYear:2011 month:4 day:4 hour:23 minute:59 second:0];
    result = [date secondNumber];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}


#pragma mark - Date difference calculations

- (void)test_yearsBetweenDate {
    NSInteger expected = 0;
    NSDate *date1 = [NSDate dateWithYear:2011 month:4 day:30];
    NSDate *date2 = [NSDate dateWithYear:2011 month:5 day:1];
    NSInteger result = [date1 yearsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 0;
    date2 = [NSDate dateWithYear:2012 month:4 day:29];
    result = [date1 yearsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 1;
    date2 = [NSDate dateWithYear:2012 month:4 day:30];
    result = [date1 yearsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_monthsBetweenDate {
    NSInteger expected = 0;
    NSDate *date1 = [NSDate dateWithYear:2011 month:4 day:30];
    NSDate *date2 = [NSDate dateWithYear:2011 month:5 day:1];
    NSInteger result = [date1 monthsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 0;
    date2 = [NSDate dateWithYear:2011 month:5 day:29];
    result = [date1 monthsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date2 = [NSDate dateWithYear:2011 month:5 day:30];
    result = [date1 monthsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 1;
    date2 = [NSDate dateWithYear:2011 month:5 day:31];
    result = [date1 monthsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = 1;
    date2 = [NSDate dateWithYear:2011 month:6 day:1];
    result = [date1 monthsBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}

- (void)test_daysBetweenDate {
    NSInteger expected = 0;
    NSDate *date1 = [NSDate dateWithYear:2011 month:4 day:30];
    NSDate *date2 = [NSDate dateWithYear:2011 month:4 day:30];
    NSInteger result = [date1 daysBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 1;
    date2 = [NSDate dateWithYear:2011 month:5 day:1];
    result = [date1 daysBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
    
    expected = 32;
    date2 = [NSDate dateWithYear:2011 month:6 day:1];
    result = [date1 daysBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);

    expected = -10;
    date2 = [NSDate dateWithYear:2011 month:4 day:20];
    result = [date1 daysBetweenDate:date2];
    XCTAssertEqual(result, expected, @"Result is not correct %ld - %ld", (long)result, (long)expected);
}


@end
