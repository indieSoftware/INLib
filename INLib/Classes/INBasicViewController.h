// INBasicViewController.h
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


/**
 The notification's name for setting the updateViewOnAppear flag or calling updateView directly if the view is currently visible.
 A data model should call
 
    [[NSNotificationCenter defaultCenter] postNotificationName:INBasicViewControllerShouldUpdateNotification object:self];
 
 when the model's data has changed and the view controller needs to update the view.
 */
extern NSString * const INBasicViewControllerShouldUpdateNotification;



/**
 The basic view controller for deriving from instead of UIViewController.
 
 This controller manages the updating of the view on appearence.
 When the view has loaded every string will automatically be localized by `INLocalizer`.
 An instance of a child class can be created with the static `controller` method.
 
 By default the controller only supports the portrait orientation mode, therefore any subclasses should override 
 `shouldAutorotateToInterfaceOrientation:` and `supportedInterfaceOrientations` to change this behavior if needed.

 @see INLocalizer
 @see controller
 */
@interface INBasicViewController : UIViewController


/**
 Creates and initializes a new instance of the view controller by loading an associated nib with the same name.

 Subclasses may also be created with this method.

 @return A new instance of the view controller.
 */
+ (instancetype)controller;


/**
 Flag which triggers a call of updateView when the view will appear.
 
 This flag will be automaticly set when a IBasicViewControllerShouldUpdateNotification is sent and the controller is not active.
 Set to YES if updateView should be called when viewWillAppear: is called.
 An instance of this controller may call updateParentViewOnAppear on self to set this property on the parent.
 After the call of updateView this flag is automaticly set to NO.
 In the controller's viewDidLoad method this flag is set defaultly to YES.

 @see updateView
 @see updateParentViewOnAppear
 */
@property (nonatomic, assign) BOOL updateViewOnAppear;


/**
 Flag which forces to call updateView on every viewWillAppear: call and overrides updateViewOnAppear.
 
 When set to YES, updateView will always be called when viewWillAppear: is called independently of the flag updateViewOnAppear.
 Default is NO.
 */
@property (nonatomic, assign) BOOL updateViewAlwaysOnAppear;


/**
 The parent view controller of this controller.
 
 This property has to be set manually if needed and may be used as a delegate reference which only needs to be casted to the correct view controller class by this controller.
 This property is not used by this class.
 */
@property (nonatomic, weak) UIViewController *parentController;


/**
 Flag indicating whether this view controller is active or not.
 
 Active means the view is visible and there is no other view controller above this controller.
 This property is only true if the controller's viewWillAppear: has been called, but viewWillDisapper: not yet.
 */
- (BOOL)isActiveController;


/**
 Sets the flag updateViewOnAppear on the parentController to YES.

 Does nothing if the parent controller is nil or is not of this class.
 Useful if a detail view controller has changed any data and wants the parent to be refreshed.
 */
- (void)updateParentViewOnAppear;


// ------------------------------------------------------------
#pragma mark - Methods for overriding
/// @name Methods for overriding

/**
 Called in viewWillAppear: if the flag updateViewOnAppear is set to YES or if the controller is active and the appropriate notification is received.
 
 This method does nothing and can be overridden by subclasses.
 A controller should handle here the updating of it's view because of the change of some model's data.
 This method should not be called by other controllers or it may be called unnecessarily multiple times, instead set the flag updateViewOnAppear to true or send a notification of the type INBasicViewControllerShouldUpdateNotification.
 However a controller may call it's own updateView method if needed.
 */
- (void)updateView;


@end
