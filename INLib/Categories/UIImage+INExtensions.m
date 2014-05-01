// UIImage+IExtensions.m
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


#import "UIImage+INExtensions.h"


@implementation UIImage (INExtensions)

- (void)saveAsJpeg:(NSString *)filePath {
    [UIImageJPEGRepresentation(self, 1.0) writeToFile:filePath atomically:YES];
}
 
- (void)saveAsPng:(NSString *)filePath {
    [UIImagePNGRepresentation(self) writeToFile:filePath atomically:YES];
}

- (CGSize)sizeToAspectFitInSize:(CGSize)inSize {
    CGFloat widthFactor = inSize.width / self.size.width;
    CGFloat heightFactor = inSize.height / self.size.height;
    CGFloat factor = fmin(widthFactor, heightFactor);
    return CGSizeMake(self.size.width * factor, self.size.height * factor);
}

- (UIImage *)scaledImageWithSize:(CGSize)inSize {
    CGRect newFrame = CGRectMake(0.f, 0.f, inSize.width, inSize.height);
    UIGraphicsBeginImageContext(inSize);
    [self drawInRect:newFrame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)flipUpsideDown {
    UIGraphicsBeginImageContext(self.size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageWithMask:(UIImage *)maskImage {
	CGImageRef maskRef = maskImage.CGImage;
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), NULL, false);
	CGImageRef maskedImageRef = CGImageCreateWithMask(self.CGImage, mask);
    CGImageRelease(mask);
	UIImage *image = [UIImage imageWithCGImage:maskedImageRef];
    CGImageRelease(maskedImageRef);
    return image;
}


@end
