# INLib CHANGELOG

## 4.0.1

- Added forwarding the status bar style from the top view controller by INNavigationController.
- Minor Bugfixes


## 4.0

- Bugfix: Using [NSBundle bundleForClass:self] instead of [NSBundle mainBundle], so INLocalizer can also be used in an IBDesignable view
- Removed the weekNumberOfYearBeginningWithFirstWeekday: method from the NSDate extension and introduced a cachedGregorianCalendar
- Bugfix: Using NSDateComponents instead of NSDateFormatter for various NSDate extension methods and other bugfixes in NSDate+INExtension
- Removed the stringifying methods from NSDate+INExtension
- Added Tests for NSDate+INExtensions
- Added [NSBundle bundleShortVersion] to get the short version number.


## 3.3.1

- Bugfix: UI_USER_INTERFACE_IDIOM is in iOS 8.3 no macro anymore
- Repaced some "(long)fabs()" to "labs()"


## 3.3

- Added some year calculation methods to the NSDate category.
- INLocalizer replaced the macro with a global function for compatibility with swift and added +localizeString: as an alternative
- Deprecated INAlertView
- INWindowDelegate made the optional method mandatory
- INBasicTableViewCell made NSStringFromClass swift compatible


## 3.2

- Added INRandom methods for random unsigned Integers
- Added a `randomObject` method in NSArray+INExtensions
- Added the classes INScrollView and INTableView with the ability to cancel touches on certain or all views when dragging
- Fixes monthsBetweenDate: in NSDate+INExtensions
- Added the possibility to instantiate an INCoreDataManager instance with a specific model version
- Fixed the duplicateStoreToUrl: method in INCoreDataManager


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
