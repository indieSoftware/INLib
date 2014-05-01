//
//  LocalizerViewController.m
//  INLibExample
//
//  Created by Sven Korset on 01.05.14.
//  Copyright (c) 2014 indie-Software. All rights reserved.
//

#import "LocalizerViewController.h"

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


@end
