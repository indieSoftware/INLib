// INLocalizer.h
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


#import "INMacros.h"


/**
 Shortcut macro for localizing a string.
 @param _string_ The NSString to localize.
 @return A localized NSString.
 */
#define INLocalizeString(_string_) [[INLocalizer sharedInstance] localizeString:_string_]



/**
 The localizer uses the current bundle language for localizing strings, but may also be switched to a different language during runtime of the app.
 By default does the same as NSLocalizedString(string, string).
 Changing the language affects only the strings localized with localizeString:.
 UIImage objects or UINib files are not localized this way.
 
    NSString *localizedString = INLocalizeString(@"localizedStringKey");

 To change the language during runtime:
 
    [[INLocalizer sharedInstance] setLanguage:@"de"];
    NSString *localizedString = INLocalizeString(@"localizedStringKey");

 */
@interface INLocalizer : NSObject

INSingletonDeclaration


/**
 The bundle to use for localizing, defaults to the main bundle.
 
 Will be set automatically by changing the language with setLanguage:.
 */
@property (nonatomic, strong, readonly) NSBundle *bundle;


/**
 Sets a new language for localizing.
 
 The Localizable.strings file for the given language has to be in the language's bundle.
 After setting a new language each returned localization string is from the language's strings file.
 So after changing the language make sure to refresh the views.

 @param language The language to use. Has to be the name of the project's language, meaning the folder's name in which the Localizable.strings is without the lproj postfix. Normally this is a ISO language code, i.e. "de".
 */
- (void)setLanguage:(NSString *)language;


/**
 Localizes a string.
 
 The given string will be localized with the currently set language bundle file.
 Without manually setting a different language this method does the same as NSLocalizedString(string, string).

 @param string The string to localize.
 @return The localized string.
 */
- (NSString *)localizeString:(NSString *)string;


@end



@interface UIView (INLocalize)

/**
 Localizes all strings in this view (UILabel, UIButton, etc) and it's subviews.
 */
- (void)localizeStrings;

@end


@interface UIViewController (INLocalize)

/**
 Localizes all strings in the ViewController's view and navigation item.
 */
- (void)localizeStrings;

@end


@interface UINavigationItem (INLocalize)

/**
 Localizes all strings.
 */
- (void)localizeStrings;

@end


@interface UIBarItem (INLocalize)

/**
 Localizes all strings.
 */
- (void)localizeStrings;

@end

