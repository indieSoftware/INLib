// INTableView.h
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
 A UITableView subclass which adopts the additions added to INScrollView.
 
 @see INScrollView
 */
@interface INTableView : UITableView

/**
 Array with NSString objects of the class names to cancel touches on when dragging.
 
 Normally a scroll view will not cancel touches on buttons, though by adding the class name of UIButton to this list will do this.
 The method touchesShouldCancelInContentView: will return true if the touch is on a class which is listed in this array.
 
 Example of creating the array:
    
    tableView.classesToCancelTouchesOn = @[NSStringFromClass([UIButton class])];
 
 This list may be used in conjunction with viewsToCancelTouchesOn and offers the possibility to cancel all types of objects at once.
 The string will be compared with the string of the view's class name, so there won't be an exception if the given class name doesn't exist.
 However, due to the string comparision the exact class name has to be added to the array, including all sublcasses, i.e. a custom UIButton subclass has also be added otherwise it won't trigger.
 
 @see viewsToCancelTouchesOn
 */
@property (nonatomic, strong) NSArray *classesToCancelTouchesOn;


/**
 Array with UIView objects which to cancel touches on when dragging.
 
 Normally a scroll view will not cancel touches on buttons, though by adding the object to this list will do this.
 The method touchesShouldCancelInContentView: will return true if the touch is on a view which is listed in this array.
 
 Example of creating the array:
 
    tableView.viewsToCancelTouchesOn = @[myButton];
 
 This list may be used in conjunction with classesToCancelTouchesOn and offers the possibility to precisely exclude certain objects.
 Both view's, in the list an on the scroll view are compared with isEqual:.
 
 @see classesToCancelTouchesOn
 */
@property (nonatomic, strong) NSArray *viewsToCancelTouchesOn;


@end
