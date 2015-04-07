// INAlertView.h
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
 A UIAlertView which dismisses itself automatically when the app goes to the background. At plus this alert view class uses blocks instead of the delegate protocol.
 
 @deprecated Use UIAlertController instead
 */
__deprecated
@interface INAlertView : UIAlertView

/**
 Shows a UIAlertView.
 
 Calls showAlertWithTitle:message:firstButtonTitle:secondButtonTitle:firstButtonIsCancelButton:dismissHandler: with the second button title set to nil.
 
 @param title The alert's title.
 @param message The alert's message body.
 @param buttonTitle The alert's single button's title.
 @param dismissHandler The block to call when the alert dismisses.
 @see showAlertWithTitle:message:firstButtonTitle:secondButtonTitle:firstButtonIsCancelButton:dismissHandler:
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle dismissHandler:(void (^)(NSInteger pressedButtonIndex))dismissHandler;


/**
 Creates ans shows a new alert view with the given title and message and 2 buttons.
 
 This alert has one or two buttons, so the first button must have a title, but the second may be nil.
 Setting the firstButtonIsCancelButton to NO will set the cancelButtonIndex property to 1, otherwise it is set to 0.
 The dismissHandler will be called when the alert is about to dismiss, but may be nil.
 
 @param title The alert's title.
 @param message The alert's message body.
 @param firstButtonTitle The alert's first button's title.
 @param secondButtonTitle The alert's second button's title.
 @param firstButtonIsCancelButton If set to YES then the first button will be used as the cancel button and will be pressed when dismissed automatically, otherwise the second button will be used as the cancel button.
 @param dismissHandler The block to call when the alert dismisses.
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message firstButtonTitle:(NSString *)firstButtonTitle secondButtonTitle:(NSString *)secondButtonTitle firstButtonIsCancelButton:(BOOL)firstButtonIsCancelButton dismissHandler:(void (^)(NSInteger pressedButtonIndex))dismissHandler;


/**
 Creates ans shows a new alert view with the given title and message and 3 buttons.

 This alert has up to three buttons, so the first button must have a title, but the second and third may be nil. However, the second cannot be nil if the third isn't.
 The dismissHandler will be called when the alert is about to dismiss, but may be nil.
 @param title The alert's title.
 @param message The alert's message body.
 @param firstButtonTitle The alert's first button's title.
 @param secondButtonTitle The alert's second button's title.
 @param thirdButtonTitle THe alert's third button's title.
 @param cancelButtonIndex The index of the button which will be used as the cancel button and will be pressed when dismissed automatically. The index begins with 0 for the first button and goes up unitl 2 for the third button.
 @param dismissHandler The block to call when the alert dismisses.
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message firstButtonTitle:(NSString *)firstButtonTitle secondButtonTitle:(NSString *)secondButtonTitle thirdButtonTitle:(NSString *)thirdButtonTitle cancelButtonIndex:(NSInteger)cancelButtonIndex dismissHandler:(void (^)(NSInteger pressedButtonIndex))dismissHandler;


@end
