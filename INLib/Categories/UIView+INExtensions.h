// UIView+INExtensions.h
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


@interface UIView (INExtensions)

/**
 Enables the rounded corners of this view with a given radius.
 
 The default value for a window is 5.0. Use 10.0 to look like app icons.
 
 @param radius The radius for the corners.
 */
- (void)enableRoundCornerWithRadius:(float)radius;


/**
 Activates a border in a specified color and thickness for this view.
 
 May be used together with rounded corners.

 @param borderWidth The width in points the border should have.
 @param borderColor A color for the border.
 */
- (void)enableBorderWithWidth:(float)borderWidth andColor:(UIColor *)borderColor;


/**
 Creates an image of this view.
 
 Draws the view and the content into an image object which is more flexible than UIView's snapshotViewAfterScreenUpdates introduced in iOS 7.
 
 @return The image representation.
 */
- (UIImage *)imageFromView;


@end
