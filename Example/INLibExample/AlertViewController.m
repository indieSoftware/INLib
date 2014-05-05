// AlertViewController.m
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


#import "AlertViewController.h"

@interface AlertViewController ()

@end


@implementation AlertViewController

- (IBAction)btnShowUIAlertViewPressed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView" message:@"Press home and start the app again, the UIAlertView will pop up again" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)btnShowINAlertViewPressed {
    [INAlertView showAlertWithTitle:@"INAlertView" message:@"Press home and start the app again, the INAlertView will dismiss automatically with the single button pressed." buttonTitle:@"Dismiss" dismissHandler:^(NSInteger pressedButtonIndex) {
        DLog(@"INAlertView dismissed with button index %d pressed", pressedButtonIndex);
    }];
}

- (IBAction)btnShowINAlertView2ButtonPressed {
    [INAlertView showAlertWithTitle:@"INAlertView" message:@"Press home and start the app again, the INAlertView will dismiss automatically with the cancel button pressed." firstButtonTitle:@"First button" secondButtonTitle:@"Second button (Cancel)" firstButtonIsCancelButton:NO dismissHandler:^(NSInteger pressedButtonIndex) {
        DLog(@"INAlertView with 2 buttons dismissed with button index %d pressed", pressedButtonIndex);
    }];
}

- (IBAction)btnShowINAlertView3ButtonPressed {
    [INAlertView showAlertWithTitle:@"INAlertView" message:@"Press home and start the app again, the INAlertView will dismiss automatically with the cancel button pressed." firstButtonTitle:@"First button" secondButtonTitle:@"Second button" thirdButtonTitle:@"Third button (Cancel)" cancelButtonIndex:2 dismissHandler:^(NSInteger pressedButtonIndex) {
        DLog(@"INAlertView with 3 buttons dismissed with button index %d pressed", pressedButtonIndex);
    }];
}

@end
