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
 A UINavigationController substitution which forwards all rotation requests to the current top view controller and any segue for unwinding to the destination segue.
 */
@interface INNavigationController : UINavigationController


/**
 When set to YES the navigation controller forwards any rotation requests to the navigation controller's top view controller instead of using the own default rotation behavior. Defaults to YES.
 
 This forwarding is handy when the navigation controller should be used as the window's root controller and the app allows different rotations, otherwise there will be no possibility for the root controller to restrict to selected rotations.
 */
@property (nonatomic, assign) BOOL forwardRotation;


/**
 When set to YES the navigation controller forwards the segueForUnwindingToViewController:fromViewController:identifier: calls to the `toViewController`. Defaults to YES.
 
 A forwarding to the appropriate view controller is what will be the expected behavior and seems to be a bug in iOS not to do so.
 Just by using this navigation controller should fix this.
 Assigning NO to this property will reset the behavior to the default of a UINavigationController.
 */
@property (nonatomic, assign) BOOL forwardSegueForUnwinding;


@end
