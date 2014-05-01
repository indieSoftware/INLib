//
//  AlertViewController.m
//  INLibExample
//
//  Created by Sven Korset on 30.04.14.
//  Copyright (c) 2014 indie-Software. All rights reserved.
//

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
