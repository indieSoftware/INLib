// NSLocale+INExtensions.h
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


@interface NSLocale (INExtensions)


/**
 Returns the language currently used by the system, i.e. "de".

 The first entry from preferredLanguages will be returned.
 
 @return The system language.
 */
+ (NSString *)systemLanguage;


/**
 Returns the country code currently set in the system user settings, i.e. "DE".

 Shortcut for calling `[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]`.

 @return The system country code.
 */
+ (NSString *)systemCountryCode;


/**
 Returns the preferred language, which is also supported.
 
 The return value is cached for later calls of this method or to `preferredSupportedLanguage`.
 Returns always the previously determined language so calling it multiple times with different paramaters makes no sense.
 Normally this method is called once at app start for set up and afterwards all views and view controllers only call preferredSupportedLanguage to get the cached value.
 
 @param supportedLanguages An array of language identifier which are supported by the app, i.e. @["en", "de"].
 @param defaultLanguage If not nil, it will be returned if the current selected language is not in the supportedLanguages array, otherwise the current selected language will be returned. If defaultLanguage is nil the first match in preferredLanguages and supportedLanguages will be returned otherwise the empty string.
 @return The preferred language.
 */
+ (NSString *)preferredSupportedLanguage:(NSArray *)supportedLanguages defaultLanguage:(NSString *)defaultLanguage;


/**
 Returns the cached return value from preferredSupportedLanguage: or nil if preferredSupportedLanguage: has not yet been called.

 @return The preferred supported language.
 @see preferredSupportedLanguage:defaultLanguage:
 */
+ (NSString *)preferredSupportedLanguage;


@end
