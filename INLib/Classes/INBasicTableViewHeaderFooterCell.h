// INBasicTableViewHeaderFooterCell.h
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
 A basic table header/footer view class for deriving from instead of UITableViewHeaderFooterView.
 
 This view class has some static accessor methods for retrieving the reuse identifier which is class dependant.
 At plus the default's height can be read from the nib file.
 These table view header footer cells can be used together with UITableView's `registerNib:forHeaderFooterViewReuseIdentifier:`.
 
 @warning *Instances of this class need to have an associated nib file to it which has to be named exactly the same as the class itself and have a single header/footer view in it with the reuse identifier set.*
 */
@interface INBasicTableViewHeaderFooterView : UITableViewHeaderFooterView


/**
 Creates and initializes a new instance of the table header/footer view by loading the corresponding nib file.
 
 @return A new instance of the view.
 */
+ (instancetype)view;


/**
 Returns the default height of the table header/footer view.
 
 @return The height of the view saved in the nib file.
 */
+ (CGFloat)viewDefaultHeight;


/**
 Returns the reuse identifier.
 
 @return The identifier of the view saved in the nib file.
 */
+ (NSString *)viewIdentifier;


/**
 Registers this header/footer view class to a table view for automatic managing and instantiating of footer and header.
 
 @param tableView The table view instance which wants this header/footer view to be registered.
 */
+ (void)registerAtTableView:(UITableView *)tableView;


@end
