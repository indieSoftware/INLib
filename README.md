# INLib

[![CocoaDocs](http://cocoapod-badges.herokuapp.com/v/INLib/badge.png)](http://cocoadocs.org/docsets/INLib)

A little iOS Library with common operations, extensions and UI additions.


## Features

### Classes
- INAlertView: A UIAlertView which dismisses itself automatically when the app goes to the background. At plus this alert view class uses blocks instead of the delegate protocol.
- INBasicTableViewCell: A basic table view cell class for deriving from instead of UITableViewCell to get class methods for loading from a xib file, accessing the cell identifier and registering at a table view.
- INBasicTableViewHeaderFooterView: A basic table header/footer view class for deriving from instead of UITableViewHeaderFooterView which adds some static methods for creation and determination.
- INBasicViewController: A basic view controller which introduces a updateView method for subclasses, has a parentController property and can be loaded from a xib file with a static method.
- INLocalizer: A class for switching the language during runtime and retrieving the corresponding strings from a Localizable.strings file.
- INNavigationController: A UINavigationController substitution which forwards all rotation requests to the current top view controller and may forward any segue for unwinding calls to the destination segue.
- INRandom: A randomizer class which uses arc4random().
- INWindow: A UIWindow subclass which can ignore special events received by asking a delegate.

### Categories
- NSArray: arrayWithSet:, arrayReversed, firstObjectPassingTest:, arrayWithRandomizedOrder, descriptionWithStart:elementFormatter:lastElementFormatter:end:
- NSBundle: direct shortcut accessors for the bundle identifier and version
- NSDate: Date detail accessing, cached formatters, date comparison, date manipulation, date difference calculations
- NSDictionary / NSMutableDictionary: type safe accessors / setter, custom description method
- NSLocale: shortcut methods for the system's language and country code
- NSObject: Storing an object at runtime, NSNull comparison, a performSelector implementation
- NSString: manipulation and comparison methods, comparing and manipulating version strings
- UIColor: randomColor, colorWithHex:, RGB parts determination
- UIDevice: iPad determination, get display type, simulate a memory warning
- UIImage: shortcuts for saving as PNG or JPEG, image flipping, masking, scaling
- UIView: rounded corners, borders, image capturing

### Macros
- DLog() which logs via NSLog() only in DEBUG (non-release) mode.
- Singleton macro to turn a class easily into a singleton.
- STRINGIFY_MACROVALUE to get a macro's value into a NSString.

### C-Functions
- INDirectory-functions for easy access to the documents, caches and tmp directory.
- INRound, INCeil and INFloor functions which operates on positions after the period, i.e. INRound(6.66, 1) = 6.7


## Examples

To run the example project run `pod install` from the example's project directory first (cocoapods installed required).
Then open the workspace file INLibExample.xcworkspace with Xcode and run the example app or the tests.


## Requirements

iOS 6+, ARC enabled


## Installation

INLib is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

    pod "INLib"

or clone the repo manually and add the INLib directory to your project.

Include the INLib.h header file into your project to get access to all additions.


## Changelog

[CHANGELOG.md](./CHANGELOG.md)


## TODOs

- Add many more examples
- Add many more tests


## License

INLib is available under the MIT license. See the LICENSE file for more info.

