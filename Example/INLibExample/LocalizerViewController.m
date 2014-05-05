// LocalizerViewController.m
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


#import "LocalizerViewController.h"
#import "Localizer2ViewController.h"

@interface LocalizerViewController ()

@property (nonatomic, weak) IBOutlet UILabel *lblHelloWorld;

@end


@implementation LocalizerViewController

- (IBAction)btnEnglishPressed {
    [self updateLanguage:@"en"];
}

- (IBAction)btnFrenchPressed {
    [self updateLanguage:@"fr"];
}

- (IBAction)btnGermanPressed {
    [self updateLanguage:@"de"];
}

- (void)updateLanguage:(NSString *)language {
    [[INLocalizer sharedInstance] setLanguage:language];
    [self updateView];
}

- (void)updateView {
    [super updateView];
    self.lblHelloWorld.text = INLocalizeString(@"HelloWorld");
}

- (IBAction)btn2ViewPressed {
    Localizer2ViewController *controller = [Localizer2ViewController controller];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
