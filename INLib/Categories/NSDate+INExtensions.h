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


/// Detail information about a date. This struct is for faster and easier access to a date's components.
/// Uses the gregorian calendar for calculations.
typedef struct IDateInformation {
	NSInteger year;
	NSInteger month; // 1..12
	NSInteger day; // 1..
	NSInteger weekday; ///< 1 to 7 and 1 = Sunday.
	NSInteger hour; // 0..23
	NSInteger minute; // 0..59
	NSInteger second; // 0..59
} IDateInformation;

/// Fills a date information struct.
IDateInformation IDateInformationMake(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second);


@interface NSDate (INExtensions)

/// Converts days, hours, minutes and seconds into seconds.
/// @param days Number of days.
/// @param hour Number of hours.
/// @param min Number of minutes.
/// @param sec Number of seconds.
/// @return The calculated total seconds.
+ (NSInteger)secondsForDays:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

/// Converts hours, minutes and seconds into seconds.
/// Calls secondsForDaysAndTime(int, int, int, int) with 0 days.
/// @param hour Number of hours.
/// @param min Number of minutes.
/// @param sec Number of seconds.
/// @return The calculated total seconds.
/// @see secondsForDaysAndTime(int, int, int, int)
+ (NSInteger)secondsForHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

/// Converts a time in seconds into a printable string.
/// @param sec The number of seconds which represents the new time.
/// @param withSign If true the string will have a sign + or - as prefix, depending if the seconds are positive or negative.
/// @param printSeconds The output string will be in the form of HH:MM:SS if printSeconds is true, otherwise it will be of the form HH:MM.
/// @return The string representation for the given time, either HH:MM:SS or HH:MM.
+ (NSString *)stringRepresentationForSeconds:(NSInteger)seconds printSign:(BOOL)printSign printSeconds:(BOOL)printSeconds;



/// Returns a cached date formatter object for the given format string.
/// If there is no date formatter for the given format a new format will be created.
/// Creating a new NSDateFormatter is time expensive so use this method for reusing old formatter.
/// @return A cached date formatter for the given format.
+ (NSDateFormatter *)cachedDateFormatterForFormat:(NSString *)format;


/// Flag indicating whether this date represents today.
/// @return True if the date contains a date of today, otherwise false.
- (BOOL)isToday;

/// Checks if this day is the same day as the other.
/// @param otherDate The other date to compare with.
/// @return True if this date has the same year, month and day as the given date.
- (BOOL)isSameDay:(NSDate *)otherDate;


/// Creates a date information struct from this date.
/// @return The date information.
- (IDateInformation)dateInformation;

/// Creates a date information struct from this date.
/// see for TimeZones http://stackoverflow.com/questions/5985468/iphone-differences-among-time-zone-convenience-methods
/// @param timeZone The time zone for this date.
/// @return The date information.
- (IDateInformation)dateInformationWithTimeZone:(NSTimeZone *)timeZone;

/// Creates a new date object out of a date information struct.
/// @param dateInfo The date information struct.
/// @return The new date object.
+ (NSDate *)dateWithDateInformation:(IDateInformation)dateInfo;

/// Creates a new date object out of a date information struct.
/// see for TimeZones http://stackoverflow.com/questions/5985468/iphone-differences-among-time-zone-convenience-methods
/// @param dateInfo The date information struct.
/// @param timeZone The time zone for this date.
/// @return The new date object.
+ (NSDate *)dateWithDateInformation:(IDateInformation)dateInfo timeZone:(NSTimeZone *)timeZone;

/// Creates a date with the time zeroed and the day set to the first.
/// @return A date object with the day set to 1 and the same month and year unchanged.
- (NSDate *)dateWithFirstOfMonth;

/// Creates a date with the time zeroed and the day set to the last day of the month.
/// @return A date object with the day set to the last day of the month.
- (NSDate *)dateWithLastOfMonth;

/// Creates a date with the month incremented by one.
/// @return A new date object.
- (NSDate *)dateWithNextMonth;

/// Creates a date with the month decremented by one.
/// @return A new date object.
- (NSDate *)dateWithPrevMonth;

/// Creates a date with the day set to the first day of the week.
/// @param daynumber The first day in the week as a number (1=Sun, 2=Mon, ...)
/// @return A new date object.
- (NSDate *)dateWithWeekstart:(NSInteger)daynumber;


/// Returns the year number of this date time object, i.e. 2014.
/// @return The year as a number.
- (NSInteger)yearNumber;

/// Returns the month number of this date time object, i.e. 12.
/// @return The month as a number. Ranged from 1 to 12.
- (NSInteger)monthNumber;

/// Returns the quarter number of this date time object, i.e. 4.
/// @return The quarter as a number. Ranged from 1 to 4.
- (NSInteger)quarterNumber;

/// Returns the weeknumber of the year, i.e. 20.
/// The weeknumber is depending from the first weekday which is in ISO 8601 monday, but in US it is sunday, so the same day may be in different weeks for US and Europe.
/// @param firstWeekday The first weekday, sunday = 1, monday = 2, etc.
/// @return The week as a number.
- (NSInteger)weekNumberOfYearBeginningWithFirstWeekday:(NSUInteger)firstWeekday;

/// Returns the weeknumber of the year, i.e. 20.
/// The weeknumber is depending from the first weekday which is in ISO 8601 monday, but in US it is sunday, so the same day may be in different weeks for US and europe.
/// The first weekday will be determined from the current locale.
/// Changing the first weekday by calling weekNumberOfYearBeginningWithFirstWeekday: will change the currently used first day.
/// @see weekNumberOfYearBeginningWithFirstWeekday:
/// @return The week as a number.
- (NSInteger)weekNumberOfYear;

/// Returns the first weekday used by the week number of year date formatter.
/// The Dateformatter of the methods weekNumberOfYear and weekNumberOfYearBeginningWithFirstWeekday: will be used for determining the currently set first weekday number.
/// @return The first week day number. 1 = Sunday, 2 = Monday, ..., 7 = Saturday.
+ (NSUInteger)firstWeekdayUsedForWeekNumberDateFormatter;

/// Returns the week number of the month, i.e. 4.
/// @return The week as a number. Ranged from 1 to 5.
- (NSInteger)weekNumberOfMonth;

/// Returns the day number of the month, i.e. 31.
/// @return The day as a number. Ranged from 1 to 31.
- (NSInteger)dayNumberOfMonth;

/// Returns the day number of the year, i.e. 365.
/// @return The day as a number. Ranged from 1 to 366.
- (NSInteger)dayNumberOfYear;

/// Returns the day number of the week, i.e. 7.
/// @return The day as a number. Ranged from 1 to 7.
- (NSInteger)dayNumberOfWeekInMonth;

/// Returns the week day number, i.e. 2 for Monday.
/// @return The week day as a number: Sunday = 1, Monday = 2, ..., Saturday = 7
- (NSInteger)weekdayNumber;

/// Returns the hours, i.e. 23.
/// @return The hour as a number. Ranged from 0 to 23.
- (NSInteger)hourNumber;

/// Returns the minutes, i.e. 13.
/// @return The minute as a number. Ranged from 0 to 59.
- (NSInteger)minuteNumber;

/// Returns the seconds, i.e. 31.
/// @return The second as a number. Ranged from 0 to 59.
- (NSInteger)secondNumber;

/// Returns the localized month's name as a string, i.e. "Dezember".
/// @return The month's name.
- (NSString *)stringWithMonthName;

/// Returns the localized weekday's name as a string, i.e. "Tuesday".
/// @return The day's name.
- (NSString *)stringWithWeekdayName;

/// Returns the localized weekday's name as a string, i.e. "Tues".
/// @return The day's shortened name.
- (NSString *)stringWithWeekdayNameShort;


/// Returns the number of months between this and the otherDate.
/// Between 31.3.2014 and 1.5.2014 is one month, same between 1.3.2014 and 31.5.2014, but
/// no months between 1.3.2014 and 30.4.2014.
/// @param otherDate The other date to compare with.
/// @return Number of months between the two dates.
- (NSInteger)monthsBetweenDate:(NSDate *)otherDate;

/// Returns the number of days between this and the otherDate.
/// @param otherDate The other date to compare with.
/// @return Number of days between the two dates.
- (NSInteger)daysBetweenDate:(NSDate *)otherDate;


/// Creates a new date object with the given date.
/// @param year The years as a number.
/// @param month The months as a number.
/// @param day The days as a number.
/// @return A new date object.
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/// Creates a new date object with the given date and time.
/// @param year The years as a number.
/// @param month The months as a number.
/// @param day The days as a number.
/// @param hour The hours as a number.
/// @param minute The minutes as a number.
/// @param second The seconds as a number.
/// @return A new date object.
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/// Creates a new date object from the receiver with the time replaced by 0.
/// @return A new date object with the time set to midnight.
- (instancetype)dateWithTimeZeroed;

/// Creates a new date object from the receiver with days added.
/// @param days The days as a number to add.
/// @return A new date object.
- (instancetype)dateWithDaysAdded:(NSInteger)days;

/// Creates a new date object from the receiver with months added.
/// @param months The months as a number to add.
/// @return A new date object.
- (instancetype)dateWithMonthsAdded:(NSInteger)months;

/// Creates a new date object from the receiver with years added.
/// @param years The years as a number to add.
/// @return A new date object.
- (instancetype)dateWithYearsAdded:(NSInteger)years;


/// Returns true if this date is before the other date.
/// @param otherDate The date to compare with.
/// @return YES if the other date is after this date or equal to, otherwise NO.
- (BOOL)isBeforeDate:(NSDate *)otherDate;

/// Returns true if this date is after the other date.
/// @param otherDate The date to compare with.
/// @return YES if the other date is before this date or equal to, otherwise NO.
- (BOOL)isAfterDate:(NSDate *)otherDate;


@end
