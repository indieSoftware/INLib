// INBasicTableViewCell.h
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
 A basic table view cell class for deriving from instead of UITableViewCell.
 
 This cell class has some static accessor methods for retrieving the cell's identifier which is class dependant.
 At plus the default's height can be read from the nib file and a parent controller class can be assigned to a property which is for call back behavior.
 These table view cells can be used together with UITableView's `registerNib:forCellReuseIdentifier:`.
 
 @warning *Instances of this class need to have an associated nib file to it which has to be named exactly the same as the class itself and have a single cell view in it with the cell identifier set.*
 */
@interface INBasicTableViewCell : UITableViewCell


/**
 Creates and initializes a new instance of the table view cell by loading the corresponding nib file.

 @return A new instance of the table view cell.
 */
+ (instancetype)cell;


/**
 Returns the default height of the table view cell.
 
 @return The height of the table view cell saved in the nib file.
 */
+ (CGFloat)cellDefaultHeight;


/**
 Returns the cell identifier.
 
 @return The identifier of the table view cell saved in the nib file.
 */
+ (NSString *)cellIdentifier;


/**
 Registers this table view cell class to a table view for automatic managing and instantiating.

 @param tableView The table view instance which wants this cell calss to be registered.
 */
+ (void)registerAtTableView:(UITableView *)tableView;


/**
 A weak reference to a contoller.
 
 May be used to pass button events or other callbacks back to a controller object.
 This property is not used by this class and any UIViewController or other NSObject may be assigned to it.
 */
@property (nonatomic, weak) id controller;


@end
