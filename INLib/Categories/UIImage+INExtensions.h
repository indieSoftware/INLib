// UIImage+INExtensions.h
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


@interface UIImage (INExtensions)

/// Saves this image as an JPG file to disc.
/// @param filePath The file path to save the file to.
- (void)saveAsJpeg:(NSString *)filePath;

/// Saves this image as an PNG file to disc.
/// @param filePath The file path to save the file to.
- (void)saveAsPng:(NSString *)filePath;

/// Calculates the size for this image so it aspect fits into a given size.
/// @param inSize The size in which the image has to aspect fit into.
/// @return The size in which the image aspect fits into the given size.
- (CGSize)sizeToAspectFitInSize:(CGSize)inSize;

/// Scales the image to a given size.
/// @param inSize The size of the new image.
/// @return The new scaled image.
- (UIImage *)scaledImageWithSize:(CGSize)inSize;

/// Flips the image. Usefull if the image has been drawn with Core Graphics and thus is upside down.
/// @return A new image with the original upside down.
- (UIImage *)flipUpsideDown;

/// Creates a new image by masking the caller. Only these parts of the image will be rendered to the returning image which corresponding areas are dark in the mask image.
/// @param maskImage The gray scaled image to use as the alpha mask. This mask is scaled if it is not of the same size as the caller.
/// @return A new image with the masked content of the caller's.
- (UIImage *)imageWithMask:(UIImage *)maskImage;


@end
