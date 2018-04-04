# SelectionScrollBar

[![Version](https://img.shields.io/cocoapods/v/SelectionScrollBar.svg?style=flat)](http://cocoapods.org/pods/SelectionScrollBar)
[![License](https://img.shields.io/cocoapods/l/SelectionScrollBar.svg?style=flat)](http://cocoapods.org/pods/SelectionScrollBar)
[![Platform](https://img.shields.io/cocoapods/p/SelectionScrollBar.svg?style=flat)](http://cocoapods.org/pods/SelectionScrollBar)

## Purpose

The purpose of this project was to create a scrollable bar that allows users to make a selection. It was originally created to provide users with predictions as they type in a UITextField. The implementation is modeled after UITableView in a naive way.

The SelectionScrollBar datasource provides buttons to be placed in the scrollable area. Currently this simply places all of the supplied buttons into the scrollbar at once, instead of reusing views as a UITableView does. This is a known issue, simply because for current use only a few simple buttons are shown at any given time. Optimizations for reusing the button views are planned for a future update.

The SelectionScrollBar delegate sends interaction events. When a button is tapped the index of the tappped button will be sent as well as the title of the button.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

To provide selections to a SelectionScrollBar the datasource must be set.

### DataSource

```swift
func selectionScrollBarSelectionCount(for scrollBar: SelectionScrollBar) -> Int
```
This function provides the count of the total number of selections to be shown in the scrollbar. Similar to UITableView's numberOfCells. 

```swift
func selectionScrollBar(_ scrollBar: SelectionScrollBar, buttonForIndex index: Int) -> UIButton
```
This function provides a button for each index of the scrollbar. The total indiciis is equal to the count that was provided. Similar to UITableView's cellForRowAt.

### Delegate 

In order to interact with the elements inside the scrollbar the delegate must be set. There are two optional functions.

```swift
func selectionScrollBar(_ scrollBar: SelectionScrollBar, didSelectButtonAtIndex index: Int)
```
This function provides the index of the button that was tapped. This corresponds to the button that was provided by the datasource selectionScrollBar(_ scrollBar: SelectionScrollBar, buttonForIndex index: Int) call.

```swift
func selectionScrollBar(_ scrollBar: SelectionScrollBar, didSelectTitle title: String?)
```
This function provides the title of the button that was tapped.

## Installation

SelectionScrollBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SelectionScrollBar'
```

## Author

AJ Bartocci, bartocci.aj@gmail.com

## License

SelectionScrollBar is available under the MIT license. See the LICENSE file for more info.
