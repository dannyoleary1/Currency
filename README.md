# Currency
A simple iOS currency conversion app written in Swift, using the Fixer.io API (http://fixer.io)

Used as a teaching assignment for students of Waterford Institute of Technology (http://www.wit.ie).

## Changes
As part of this assignment, a number of changes have been made.
>You made need to run: `pod install` to install the dependencies.

The changes that needed to be made, and a short description of how I completed the task:
**Github Integration**: `Complete`

**Wiring up Outlets**: `Complete`. This was done from the interface builder to drag the relevant Outlets that I needed.

**Four Extra Currencies**: `Complete`

**Auto Layout Issues Resolved**: `Complete`. Note that it supports both Portrait and Landscape. I decided to get rid of the status bar from the landscape version however because it makes more sense to have a 'full screen' effect in landscape.

**Decimal Keyboard, Dismissal, & Obfuscation issue resolved:** `Complete`. For this I used a plugin called IQKeyboardManager: https://github.com/hackiftekhar/IQKeyboardManager. This solved the issue of obfuscation. I made an extension of UITextField to make a 'Done' button to dismiss, and simply changed to use the Decimal Pad.

**Nicer Activity Indicator:*** `Complete`. For this I used a plugin called: https://github.com/ninjaprox/NVActivityIndicatorView, this was purely for styling purposes and it's much the same as a normal ActivityIndicator.

**Other UI Work: Icons, Launch Screen, General UI:** `Complete`. Icons have been added. A very simple launch screen was included and there's some General UI stuff including: AutoLayout, TableView, and PickerView.

**Updating deprecated function call:** `Complete`. Depreciated function was changed to use session.dataTask.

**Extra Feature:** `Complete`. An extra feature was added into the project to allow a user to add in additional currencies. These are hardcoded into an additional class, and support all of fixer.io's currencies. It uses a pickerview plugin called: https://github.com/skywinder/ActionSheetPicker-3.0 which adds the pickerView and then I update the tableView to correspond with that.
