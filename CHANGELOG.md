# INLib CHANGELOG

## 2.2

- Added the property `forwardSegueForUnwinding` to INNavigationController and the possibility to forward any call of segueForUnwindingToViewController:fromViewController:identifier: to the destination controller.


## 2.1

- Added descriptionWithStart:elementFormatter:lastElementFormatter:end: to NSArray+INExtensions.
- Added descriptionWithStart:pairFormatter:lastPairFormatter:end:keys:printKeysAfterValues: to NSDictionary+INExtensions.
- Added tests for NSDictionary+INExtensions.


## 2.0

- Typo correction in a method name of NSString+INExtensions.
- Added some version string manipulation methods to NSString+INExtensions.
- Added tests for NSString+INExtensions.
- Moved the date formatter caching from NSDate+INExtensions to the new category NSDateFormatter+INExtensions.


## 1.0

Initial release includes:
- INAlertView
- INBasicTableViewCell
- INBasicTableViewHeaderFooterView
- INBasicViewController
- INLocalizer
- INNavigationController
- INRandom
- INWindow
- Categories for NSArray, NSBundle, NSDate, NSDictionary, NSLocale, NSObject, NSString, UIColor, UIDevice, UIImage, UIView
- Some Macros
- Some C-Functions
