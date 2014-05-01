// INAlertView.m
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


#import "INAlertView.h"


@interface INAlertView () <UIAlertViewDelegate>

@property (nonatomic, copy) void (^dismissHandler)(NSInteger);

@end


@implementation INAlertView

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle dismissHandler:(void (^)(NSInteger pressedButtonIndex))dismissHandler {
    [self showAlertWithTitle:title message:message firstButtonTitle:buttonTitle secondButtonTitle:nil firstButtonIsCancelButton:YES dismissHandler:dismissHandler];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message firstButtonTitle:(NSString *)firstButtonTitle secondButtonTitle:(NSString *)secondButtonTitle firstButtonIsCancelButton:(BOOL)firstButtonIsCancelButton dismissHandler:(void (^)(NSInteger pressedButtonIndex))dismissHandler {
    
    INAlertView *alert = [[INAlertView alloc] init];
    alert.title = title;
    alert.message = message;
    alert.delegate = alert;
    alert.dismissHandler = dismissHandler;
    [alert addButtonWithTitle:firstButtonTitle];
    if (secondButtonTitle != nil) {
        [alert addButtonWithTitle:secondButtonTitle];
    }
    if (firstButtonIsCancelButton || secondButtonTitle == nil) {
        alert.cancelButtonIndex = 0;
    } else {
        alert.cancelButtonIndex = 1;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:alert selector:@selector(applicationDidEnterBackgroundNotificationReceived:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [alert show];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message firstButtonTitle:(NSString *)firstButtonTitle secondButtonTitle:(NSString *)secondButtonTitle thirdButtonTitle:(NSString *)thirdButtonTitle cancelButtonIndex:(NSInteger)cancelButtonIndex dismissHandler:(void (^)(NSInteger pressedButtonIndex))dismissHandler {
    
    INAlertView *alert = [[INAlertView alloc] init];
    alert.title = title;
    alert.message = message;
    alert.delegate = alert;
    alert.dismissHandler = dismissHandler;
    [alert addButtonWithTitle:firstButtonTitle];
    if (secondButtonTitle != nil) {
        [alert addButtonWithTitle:secondButtonTitle];
    }
    if (thirdButtonTitle != nil) {
        [alert addButtonWithTitle:thirdButtonTitle];
    }
    alert.cancelButtonIndex = cancelButtonIndex;
    
    [[NSNotificationCenter defaultCenter] addObserver:alert selector:@selector(applicationDidEnterBackgroundNotificationReceived:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [alert show];
}

- (void)applicationDidEnterBackgroundNotificationReceived:(NSNotification *)notification {
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:NO];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.dismissHandler != nil) {
        self.dismissHandler(buttonIndex);
    }
}

@end
