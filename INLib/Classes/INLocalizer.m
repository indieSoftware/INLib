// INLocalizer.m
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


#import "INLocalizer.h"


@implementation UIView (INLocalize)

- (void)localizeStrings {
    for (UIView *subview in self.subviews) {
        [subview localizeStrings];
    }
}

@end


@implementation UIButton (ILocalize)

- (void)localizeStrings {
    [super localizeStrings];
    [self setTitle:INLocalizeString([self titleForState:UIControlStateNormal]) forState:UIControlStateNormal];
    [self setTitle:INLocalizeString([self titleForState:UIControlStateHighlighted]) forState:UIControlStateHighlighted];
    [self setTitle:INLocalizeString([self titleForState:UIControlStateDisabled]) forState:UIControlStateDisabled];
    [self setTitle:INLocalizeString([self titleForState:UIControlStateSelected]) forState:UIControlStateSelected];
}

@end


@implementation UILabel (INLocalize)

- (void)localizeStrings {
    [super localizeStrings];
    self.text = INLocalizeString(self.text);
}

@end


@implementation UITextView (INLocalize)

- (void)localizeStrings {
    [super localizeStrings];
    self.text = INLocalizeString(self.text);
}

@end


@implementation UITextField (INLocalize)

- (void)localizeStrings {
    [super localizeStrings];
    self.text = INLocalizeString(self.text);
    self.placeholder = INLocalizeString(self.placeholder);
}

@end


@implementation UISegmentedControl (INLocalize)

- (void)localizeStrings {
    [super localizeStrings];
    
    for (NSUInteger index = 0; index < self.numberOfSegments; index++) {
        NSString *newTitle = INLocalizeString([self titleForSegmentAtIndex:index]);
        [self setTitle:newTitle forSegmentAtIndex:index];
    }
}

@end


@implementation UISearchBar (INLocalize)

- (void)localizeStrings {
    [super localizeStrings];
    self.text = INLocalizeString(self.text);
    self.placeholder = INLocalizeString(self.placeholder);
    self.prompt = INLocalizeString(self.prompt);
}

@end


@implementation UIViewController (INLocalize)

- (void)localizeStrings {
    [self.view localizeStrings];
    [self.navigationItem localizeStrings];
}

@end


@implementation UINavigationItem (INLocalize)

- (void)localizeStrings {
    self.title = INLocalizeString(self.title);
    self.prompt = INLocalizeString(self.prompt);
    [self.leftBarButtonItem localizeStrings];
    [self.rightBarButtonItem localizeStrings];
}

@end


@implementation UIBarItem (INLocalize)

- (void)localizeStrings {
    self.title = INLocalizeString(self.title);
}

@end



@interface INLocalizer ()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end


@implementation INLocalizer

INSingletonDefinition

- (id)init {
    self = [super init];
    if (self == nil) return self;
    
    self.bundle = [NSBundle mainBundle];
    
    return self;
}

- (void)setLanguage:(NSString *)language {
	NSString *path = nil;
    if (language != nil) {
        path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    }
	if (path == nil) {
		// the desired language does not exist, reset localizer
        self.bundle = [NSBundle mainBundle];
	} else {
        // load new bundle with the desired language
		self.bundle = [NSBundle bundleWithPath:path];
    }
}

- (NSString *)localizeString:(NSString *)string {
    if (string == nil) {
        return nil;
    }
	return [self.bundle localizedStringForKey:string value:string table:nil];
}


@end
