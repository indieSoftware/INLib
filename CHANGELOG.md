# INLib CHANGELOG

## 3.2

- Added INRandom methods for random unsigned Integers
- Added a `randomObject` method in NSArray+INExtensions
- Added the classes INScrollView and INTableView with the ability to cancel touches on certain or all views when dragging
- Fixes monthsBetweenDate: in NSDate+INExtensions
- Added the possibility to instantiate an INCoreDataManager instance with a specific model version
- ...


## 3.1

- Fixes INBasicTableViewHeaderFooterView for iOS 8 and Xcode 6
- Added a `controller` property to INBasicTableViewHeaderFooterView
- Fixed the singleton macro by calling dispatch_once and resetting the once token in destroySharedInstance
- Added `dateInformationForComponents:` to NSDate+INExtensions to specify which components to load
- Added the `CoreData` subspec with extensions and classes to use with Core Data


## 3.0

- Added the property `forwardSegueForUnwinding` to INNavigationController and the possibility to forward any call of segueForUnwindingToViewController:fromViewController:identifier: to the destination controller.
- Removed methods from UIDevice+INExtensions: hasRetinaDisplay, has3Dot5InchesDisplay, has4InchesDisplay
- Changed the INBasicTableViewCell parentController property's name to controller and the type from UIViewController* to id
- NSDate category changes due to deprecated constants in iOS 8


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
