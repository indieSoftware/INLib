// NSBundle+INExtensions.h
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


@interface NSBundle (INExtensions)

/// Returns the main bundle version, i.e. "1.0". Uses the flag CFBundleVersion.
/// @return The bundle version number.
+ (NSString*)bundleVersion;

/// Returns the main bundle identifier, i.e. "de.indie-software.indielib".
/// @return The bundle identifier.
+ (NSString*)bundleIdentifier;

/// Returns a value from the main bundle for a given key. Calls objectForInfoDictionaryKey on the main bundle.
/// @param key A key in the bundle dictionary.
/// @return The Value for the given key.
+ (NSString*)bundleValueForKey:(NSString*)key;


@end
