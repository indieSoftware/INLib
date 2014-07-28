// INNavigationController.h
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
 A UINavigationController substitution which forwards all rotation requests to the current top view controller and may forward any segue for unwinding calls to the destination segue.
 */
@interface INNavigationController : UINavigationController


/**
 When set to YES the navigation controller forwards any rotation requests to the navigation controller's top view controller instead of using the own default rotation behavior. Defaults to YES.
 
 This forwarding is handy when the navigation controller should be used as the window's root controller and the app allows different rotations, otherwise there will be no possibility for the root controller to restrict to selected rotations.
 */
@property (nonatomic, assign) BOOL forwardRotation;


/**
 When set to YES the navigation controller forwards the segueForUnwindingToViewController:fromViewController:identifier: calls to the `toViewController`. Defaults to NO so the default UINavigationController's behavior applies.
 
 A forwarding to the appropriate view controller is what will be the expected behavior, but each unwinded view controller then also needs to implement the method:
 
    - (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier;
 
 If using a navigation controller and setting this property to YES without the destination controller overrides segueForUnwindingToViewController:fromViewController:identifier: and returning a custom segue the unwinding won't work.
 To recreate the default behavior for navigation controllers the destination controller has to return a custom segue which calls popViewControllerAnimated: on this navigation controller.
 */
@property (nonatomic, assign) BOOL forwardSegueForUnwinding;


@end
