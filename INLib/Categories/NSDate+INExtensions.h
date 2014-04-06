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


/// Returns the year number of this date time object, i.e. 2012.
/// @return The year as a number.
- (NSInteger)yearNumber;

/// Returns the month number of this date time object, i.e. 4.
/// @return The month as a number.
- (NSInteger)monthNumber;

/// Returns the quarter number of this date time object, i.e. 1.
/// @return The quarter as a number.
- (NSInteger)quarterNumber;

/// Returns the weeknumber of the year, i.e. 20.
/// The weeknumber is depending from the first weekday which is in ISO 8601 monday, but in US it is sunday, so the same day may be in different weeks for US and europe.
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

/// Returns the week number of the month, i.e. 2.
/// @return The week as a number.
- (NSInteger)weekNumberOfMonth;

/// Returns the day number of the month, i.e. 23.
/// @return The day as a number.
- (NSInteger)dayNumberOfMonth;

/// Returns the day number of the year, i.e. 53.
/// @return The day as a number.
- (NSInteger)dayNumberOfYear;

/// Returns the day number of the week, i.e. 5.
/// @return The day as a number.
- (NSInteger)dayNumberOfWeekInMonth;

/// Returns the week day number, i.e. 2.
/// @return The week day as a number, sunday = 1, monday = 2, etc.
- (NSInteger)weekdayNumber;

/// Returns the hours, i.e. 23.
/// @return The hour as a number.
- (NSInteger)hourNumber;

/// Returns the minutes, i.e. 23.
/// @return The minute as a number.
- (NSInteger)minuteNumber;

/// Returns the seconds, i.e. 23.
/// @return The second as a number.
- (NSInteger)secondNumber;

/// Returns the localized month's name as a string, i.e. Dezember.
/// @return The month's name.
- (NSString *)stringWithMonthName;

/// Returns the localized weekday's name as a string, i.e. Tuesday.
/// @return The day's name.
- (NSString *)stringWithWeekdayName;

/// Returns the localized weekday's name as a string, i.e. Tues
/// @return The day's name.
- (NSString *)stringWithWeekdayNameShort;


/// Returns the number of months between this and the otherDate including.
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

/// Creates a new date object from the receiver with the year replaced.
/// @param year The years as a number to replace.
/// @return A new date object.
- (instancetype)dateWithYearReplaced:(NSInteger)year;

/// Creates a new date object from the receiver with the seconds replaced.
/// @param seconds The seconds as a number to replace.
/// @return A new date object.
- (instancetype)dateWithSecondsReplaced:(NSInteger)seconds;

/// Creates a new date object from the receiver with the time replaced by 0.
/// @return A new date object with the time set to midnight.
- (instancetype)dateWithTimeZeroed;

/// Creates a new date object from the receiver with the time replaced.
/// @param time The time to replace with.
/// @return A new date object with the old date but time replaced.
- (instancetype)dateWithTimeReplaced:(NSDate *)time;

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
