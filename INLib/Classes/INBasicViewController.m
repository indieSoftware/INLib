// INBasicViewController.m
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


#import "INBasicViewController.h"
#import "INLocalizer.h"



NSString * const INBasicViewControllerShouldUpdateNotification = @"INBasicViewControllerShouldUpdateNotification";



@interface INBasicViewController ()

@property (nonatomic, readwrite, getter=isActiveController) BOOL activeController;

@end



@implementation INBasicViewController


#pragma mark - private methods

- (void)basicViewControllerShouldUpdate:(NSNotification *)notification {
    if (self.isActiveController) {
        [self updateView];
        self.updateViewOnAppear = NO;
    } else {
        self.updateViewOnAppear = YES;
    }
}


#pragma mark - controller methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil) {
        [self setupINBasicViewController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self setupINBasicViewController];
    }
    return self;
}

- (void)setupINBasicViewController {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(basicViewControllerShouldUpdate:) name:INBasicViewControllerShouldUpdateNotification object:nil];
    
    self.activeController = NO;
    self.updateViewAlwaysOnAppear = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.updateViewOnAppear = YES;
    [self localizeStrings];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.activeController = YES;

    if (self.updateViewAlwaysOnAppear || self.updateViewOnAppear) {
        [self updateView];
        self.updateViewOnAppear = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.activeController = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - public methods

+ (instancetype)controller {
    return [[self alloc] init];
}

- (void)updateParentViewOnAppear {
    if (![self.parentController isKindOfClass:[INBasicViewController class]]) {
        return;
    }
    
    INBasicViewController *basicController = (INBasicViewController *)self.parentController;
    basicController.updateViewOnAppear = YES;
}


#pragma mark - methods to override

- (void)updateView {
    // to implement by subclasses
}


#pragma mark - default interface rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
