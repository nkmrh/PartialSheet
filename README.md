<p align="center">
  <img width="150" src="https://user-images.githubusercontent.com/11211914/80854827-92824400-8c7e-11ea-898f-7232aaaf69ed.png">
</p>
<p align="center">
     <img src="https://img.shields.io/github/license/AndreaMiotto/PartialSheet">
    <img src="https://img.shields.io/github/v/release/andreamiotto/PartialSheet">
    <img src="https://img.shields.io/github/stars/andreamiotto/PartialSheet">
    <img src="https://img.shields.io/github/last-commit/AndreaMiotto/PartialSheet">
</p>

# PartialSheet

A custom SwiftUI modifier to present a Partial Modal Sheet based on his content size.

**Version 3.0 has been released, there are a lot of breaking changes, make sure to read the guide before update!**


## Index

- [Features](#features)
- [Version 2](#version-2)
- [Installation](#installation)
- [How To Use](#how-to-use)
- [Wiki - Full Guide](https://github.com/AndreaMiotto/PartialSheet/wiki)


## iPhone Preview

<img src="https://user-images.githubusercontent.com/11211914/68700576-6c100580-0585-11ea-847b-99f0450311a4.gif" width="250"><img src="https://user-images.githubusercontent.com/11211914/68700574-6c100580-0585-11ea-9727-8a02ec36b118.gif" width="250">

## iPad Preview
<img src="https://user-images.githubusercontent.com/11211914/79673521-af019380-821d-11ea-82f5-49d75e83d7c0.png" width="500">

## Mac Preview
<img src="https://user-images.githubusercontent.com/11211914/79673482-7eb9f500-821d-11ea-93e0-60fc32e554ee.png" width="600">


## Features

#### Availables
- \[x]  Slidable and dismissable with drag gesture
- \[x]  Variable height based on his content
- \[x]  Callable from any view in the hierarchy with one modifier
- \[x]  Customizable colors
- \[x]  Material blurred background
- \[x]  Keyboard compatibility
- \[x]  Landscape compatibility
- \[x]  iPhone compatibility (iOS 15.0 +)
- \[x]  iPad compatibility (iOS 15.0 +)
- \[x]  Mac compatibility (MacOS 12.0 +)
- \[x]  Version 2 compatibile with older OS

#### Nice to have
- \[ ] ScrollView and List compatibility: as soon as Apple adds some API to handle better ScrollViews

## Version 3
The new version brings a lot of breaking changes and a lot of improvments:
- The Partial Sheet now is more SwiftUI. To use it you will semply need to call a modifier directly from the view.

## Installation

#### Requirements
- iOS 15.0+ / macOS 12.0+
- Xcode 11.2+
- Swift 5+
- If you need to be compatible with a previous version of macos and ios check the version 2

#### Via Swift Package Manager

In Xcode 13 or grater, in your project, select: `File > Swift Packages > Add Pacakage Dependency`.

In the search bar type **PartialSheet** and when you find the package, with the **next** button you can proceed with the installation.

If you can't find anything in the panel of the Swift Packages you probably haven't added yet your github account.
You can do that under the **Preferences** panel of your Xcode, in the **Accounts** section.

##  How to Use

*You can read more on the [wiki - full guide](https://github.com/AndreaMiotto/PartialSheet/wiki).*

To use the **Partial Sheet** you need to follow just three simple steps

1. Add a PartialSheet to the current view. You should attach it to your Root View.

```Swift
let contentView = ContentView()
                    .attachPartialSheetToRoot()
    
if let windowScene = scene as? UIWindowScene {
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: contentView)
    self.window = window
    window.makeKeyAndVisible()
}
```
2. Add the **Partial View** to your *Root View*, and if you want give it a style. In your RootView file at the end of the builder add the following modifier:

```Swift
 view
     .partialSheet(isPresented: $isPresented) {
        Text("Content of the Sheet")
     }
```

If you want a starting point in the **Examples** directory you can find some examples with different boilerplates.

###  Using Pickers

When using pickers it is needed to register an onTapGesture. This some how makes the picker being able to reconize the drag before the dragGesture on the sheet.

```Swift
struct PickerSheetView: View {
    var strengths = ["Mild", "Medium", "Mature"]
    @State private var selectedStrength = 0

    var body: some View {
        VStack {
            VStack {
                Text("Settings Panel").font(.headline)
                Picker(selection: $selectedStrength, label: EmptyView()) {
                    ForEach(0 ..< strengths.count) {
                        Text(self.strengths[$0])
                    }
                }.onTapGesture {
                    // Fixes issue with scroll
                }
            }
            .padding()
            .frame(height: 250)
        }
    }
}
```
