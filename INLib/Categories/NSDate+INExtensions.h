// NSDate+INExtensions.h
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
 Detail information about a date.
 
 This struct is for faster and easier access to a date's components.
 Uses the gregorian calendar for calculations.
 */
typedef struct INDateInformation {
    /// ..2014..
	NSInteger year;
    /// 1..12
	NSInteger month;
    /// 1..31
	NSInteger day;
    /// 1..7, 1 = Sunday, 2 = Monday, ...
	NSInteger weekday;
    /// 0..23
	NSInteger hour;
    /// 0..59
	NSInteger minute;
    /// 0..59
	NSInteger second;
} INDateInformation;


/**
 Creates a date information struct.
 
 @param year The year.
 @param month The month's number.
 @param day The month's day.
 @param hour The hour.
 @param minute The hour's minute.
 @param second The minute's second.
 */
INDateInformation INDateInformationMake(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second);



@interface NSDate (INExtensions)

#pragma mark - Cached Calendar
/// @name Cache Calendar

/**
 Returns a cached gregorian calendar which is used by many methods of this extension.

 The default calendar is set up with the current locale.
 When you want to change any calendar's properties like the locale or the minimum of days in the first week you should do this in a synchronized block guarding the cached calendar.

    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    @synchronized(calendar) {
        [calendar setMinimumDaysInFirstWeek:4];
    }

 @return The cached calendar.
 */
+ (NSCalendar *)cachedGregorianCalendar;

/**
 Sets the cached gregorian calendar which is used by many methods of this extension.
 
 When you want to change any calendar's properties like the locale or the minimum of days in the first week you should do this in a synchronized block guarding the cached calendar.
 
    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    @synchronized(calendar) {
        [calendar setMinimumDaysInFirstWeek:4];
    }
 
 In Swift you have to set it back with this method otherwise the changes won't be persisted.

    var cachedCalendar = NSDate.cachedGregorianCalendar()
    cachedCalendar?.firstWeekday = weekStartIndex
    cachedCalendar?.minimumDaysInFirstWeek = minimumDaysInFirstWeek
    NSDate.setCachedGregorianCalendar(cachedCalendar)

 */
+ (void)setCachedGregorianCalendar:(NSCalendar *)calendar;


#pragma mark - DateInformation
/// @name DateInformation

/**
 Creates a date information struct from this NSDate.
 
 This method initializes the struct fully with all components.
 Same as:
 
    NSUInteger components = NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond;
    [self dateInformationForComponents:components];
 
 Uses the cached Gregorian Calendar.
 
 @return The date information struct.
 */
- (INDateInformation)dateInformation;


/**
 Creates a date information struct from this NSDate only initialized with the given components.

 Uses the cached Gregorian Calendar.
 
 @return The date information struct.
 */
- (INDateInformation)dateInformationForComponents:(NSCalendarUnit)components;


/**
 Creates a new NSDate out of a date information struct.
 
 Uses the cached Gregorian Calendar.
 
 @param dateInfo The date information struct.
 @return The new NSDate object.
 */
+ (NSDate *)dateWithDateInformation:(INDateInformation)dateInfo;


/**
 Creates a new NSDate out of a date information struct in context of a time zone.
 
 For the different TimeZones see [this Stackoverflow posting](http://stackoverflow.com/questions/5985468/iphone-differences-among-time-zone-convenience-methods).

 Uses the cached Gregorian Calendar.
 
 @param dateInfo The date information struct.
 @param timeZone The time zone for the date info data.
 @return The new NSDate object.
 */
+ (NSDate *)dateWithDateInformation:(INDateInformation)dateInfo timeZone:(NSTimeZone *)timeZone;


#pragma mark - Date initializers
/// @name Date initializers

/**
 Creates a new date object with the given date.
 
 @param year The years as a number.
 @param month The months as a number.
 @param day The days as a number.
 @return A new NSDate object.
 */
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


/**
 Creates a new date object with the given date and time.
 
 @param year The years as a number.
 @param month The months as a number.
 @param day The days as a number.
 @param hour The hours as a number.
 @param minute The minutes as a number.
 @param second The seconds as a number.
 @return A new NSDate object.
 */
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;


#pragma mark - Seconds calculations
/// @name Manipulating seconds

/**
 Converts days, hours, minutes and seconds into seconds.
 
 @param days Number of days.
 @param hours Number of hours.
 @param minutes Number of minutes.
 @param seconds Number of seconds.
 @return The calculated total seconds.
 */
+ (NSInteger)secondsForDays:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;


/**
 Converts hours, minutes and seconds into seconds.

 Calls secondsForDaysAndTime(int, int, int, int) with 0 days.

 @param hours Number of hours.
 @param minutes Number of minutes.
 @param seconds Number of seconds.
 @return The calculated total seconds.
 @see secondsForDaysAndTime(int, int, int, int)
 */
+ (NSInteger)secondsForHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;


/**
 Converts a time in seconds into a printable string.
 
 @param seconds The number of seconds which represents the new time.
 @param printSign If true the string will have a sign + or - as prefix, depending if the seconds are positive or negative.
 @param printSeconds The output string will be in the form of HH:MM:SS if printSeconds is true, otherwise it will be of the form HH:MM.
 @return The string representation for the given time, either HH:MM:SS or HH:MM.
 */
+ (NSString *)stringRepresentationForSeconds:(NSInteger)seconds printSign:(BOOL)printSign printSeconds:(BOOL)printSeconds;


#pragma mark - Comparing methods
/// @name Comparing methods

/**
 Returns true if this date represents the today's one.
 
 @return True if the date contains a date of today, otherwise false.
 */
- (BOOL)isToday;


/**
 Checks if this day is the same day as the other.
 
 @param otherDate The other date to compare with.
 @return True if this date has the same year, month and day as the given date.
 */
- (BOOL)isSameDay:(NSDate *)otherDate;


/**
 Returns true if this date is before the other date.
 
 @param otherDate The date to compare with.
 @return True if the other date is after this date or equal to, otherwise false.
 */
- (BOOL)isBeforeDate:(NSDate *)otherDate;


/**
 Returns true if this date is after the other date.
 
 @param otherDate The date to compare with.
 @return True if the other date is before this date or equal to, otherwise false.
 */
- (BOOL)isAfterDate:(NSDate *)otherDate;


#pragma mark - Date manipulation methods
/// @name Date manipulation methods

/**
 Returns a new date object the same date, but the time replaced by 0.
 
 @return A new NSDate object with the time set to midnight.
 */
- (NSDate *)dateWithTimeZeroed;


/**
 Adds an amound of days to this date.

 @param days The days as a number to add.
 @return A new NSDate object with the new date.
 */
- (NSDate *)dateWithDaysAdded:(NSInteger)days;


/**
 Adds an amount of months to this date.
 
 @param months The months as a number to add.
 @return A new NSDate object with the new date.
 */
- (NSDate *)dateWithMonthsAdded:(NSInteger)months;


/**
 Adds an amount of years to this date.
 
 @param years The years as a number to add.
 @return A new NSDate object with the new date.
 */
- (NSDate *)dateWithYearsAdded:(NSInteger)years;


/**
 Creates a date with the time zeroed and the day set to the first of the month.

 @return A date object with the day set to 1 and the month and year unchanged.
 */
- (NSDate *)dateWithFirstOfMonth;


/**
 Creates a date with the time zeroed and the day set to the last day of the month.
 
 @return A date object with the day set to the last day of the month.
 */
- (NSDate *)dateWithLastOfMonth;


/**
 Creates a date with the month incremented by one.
 
 @return A new date object.
 */
- (NSDate *)dateWithNextMonth;


/**
 Creates a date with the month decremented by one.
 
 @return A new date object.
 */
- (NSDate *)dateWithPrevMonth;


/**
 Creates a date with the time zeroed and the day and month set to the first of the year.
 
 @return A date object which represents the first of the year.
 */
- (NSDate *)dateWithFirstOfYear;


/**
 Creates a date with the day set to the first day of the week.

 @param daynumber The first day in the week as a number (1=Sun, 2=Mon, ...)
 @return A new date object.
 */
- (NSDate *)dateWithWeekstart:(NSInteger)daynumber;


#pragma mark - Date details accessing
/// @name Date details accessing

/**
 Returns the year number of this date time object, i.e. 2014.
 
 @return The year as a number.
 */
- (NSInteger)yearNumber;


/**
 Returns the month number of this date time object, i.e. 12.
 
 @return The month as a number. Ranged from 1 to 12.
 */
- (NSInteger)monthNumber;


/**
 Returns the quarter number of this date time object, i.e. 4.
 
 @return The quarter as a number. Ranged from 1 to 4.
 */
- (NSInteger)quarterNumber;


/**
 Returns the weeknumber of the year, i.e. 20 for the 20th week.
 
 The weeknumber is depending on the first weekday and on the start of the first week in the year.
 In ISO 8601 the week starts with monday and the first week is the one with the 4th January, but in US it is Sunday and the first week starts with the 1st January, so the same day may be in different weeks for US and Europe.
 
 The first weekday will be determined from the current locale, and can be changed with the calendar's `firstWeekday` property.
 Change the first weekday by assigning `firstWeekday` from the `cachedGregorianCalendar` within a synchronized block, but beware that the cached calender will be used also by all other methods of this extension.
 When changing the first weekday you maybe may also want to change the minimum of days in the first week, because in ISO 8601 it's 4, but in US it's 1.
 
    NSCalendar *calendar = [NSDate cachedGregorianCalendar];
    @synchronized(calendar) {
        calendar.firstWeekday = 2; // Monday
        [calendar setMinimumDaysInFirstWeek:4]; // 4 days in the year's first week
    }

 @return The week as a number.
 */
- (NSInteger)weekNumberOfYear;


/**
 Returns the week number of the month, i.e. 4.
 
 This value is depending on the calendar's first weekday and the start of the first week in the year.
 
 @return The week as a number. Ranged from 1 to 5.
 @see weekNumberOfYear
 */
- (NSInteger)weekNumberOfMonth;


/**
 Returns the day number of the month, i.e. 31 for January the 31st.
 
 @return The day as a number. Ranged from 1 to 31.
 */
- (NSInteger)dayNumberOfMonth;


/**
 Returns the day number of the year, i.e. 365 for the 365th day of this year.
 
 @return The day as a number. Ranged from 1 to 366.
 */
- (NSInteger)dayNumberOfYear;


/**
 Returns the day number of the week, i.e. 2 for the 2nd Wed in July.
 
 @return The ordinal day of week in month as a number. Ranged from 1 to 6.
 */
- (NSInteger)dayNumberOfWeekInMonth;


/**
 Returns the week day number, i.e. 2 for Monday.
 
 @return The week day as a number: Sunday = 1, Monday = 2, ..., Saturday = 7
 */
- (NSInteger)weekdayNumber;


/**
 Returns the hours, i.e. 23.
 
 @return The hour as a number. Ranged from 0 to 23.
 */
- (NSInteger)hourNumber;


/**
 Returns the minutes, i.e. 13.
 
 @return The minute as a number. Ranged from 0 to 59.
 */
- (NSInteger)minuteNumber;


/**
 Returns the seconds, i.e. 31.
 
 @return The second as a number. Ranged from 0 to 59.
 */
- (NSInteger)secondNumber;


#pragma mark - Date difference calculations
/// @name Date difference calculations

/**
 Returns the number of years between this and the other date.
 
 Counts only full years.
 Returns a negative number if the other date is before this one.
 
 @param otherDate The other date to compare with.
 @return Number of years between the two dates.
 */
- (NSInteger)yearsBetweenDate:(NSDate *)otherDate;


/**
 Returns the number of months between this and the other date.
 
 Counts only full months.
 Returns a negative number if the other date is before this one.
 
 @param otherDate The other date to compare with.
 @return Number of months between the two dates.
 */
- (NSInteger)monthsBetweenDate:(NSDate *)otherDate;


/**
 Returns the number of days between this and the other date.
 
 Counts only full days.
 Returns a negative numbers if the other date is before this one.
 
 @param otherDate The other date to compare with.
 @return Number of days between the two dates.
 */
- (NSInteger)daysBetweenDate:(NSDate *)otherDate;


@end
