// UIView+INExtensions.m
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


#import "UIView+INExtensions.h"
//#import <QuartzCore/QuartzCore.h>


@implementation UIView (INExtensions)

- (void)enableRoundCornerWithRadius:(float)radius {
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius = radius;
}

- (void)enableBorderWithWidth:(float)borderWidth andColor:(UIColor *)borderColor {
	self.layer.borderWidth = borderWidth;
	self.layer.borderColor = borderColor.CGColor;
}


- (UIImage *)imageFromView {
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, 0.f);

    BOOL hidden = [self isHidden];
    [self setHidden:NO];
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    [self setHidden:hidden];
    
    return image;
}

- (UIView *)snapshotFromView {
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        // iOS 7
        return [self snapshotViewAfterScreenUpdates:NO];
    } else {
        // iOS 6 fallback
        UIImage *image = [self imageFromView];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        return imageView;
    }
}


@end
