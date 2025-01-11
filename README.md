
# FlyingFloatingMenu
<img alt="Static Badge" src="https://img.shields.io/badge/Xcode-UIView-xcode?&logo=xcode&color=CF212E"> <a href='https://github.com/ibrahimTasdemir27/FlyingFloatingMenu/' target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/iOS-swift-xcode?logo=swift">
<a href='https://www.linkedin.com/in/ibrahim-halil-taşdemir-ios-developer-111631245/' target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/-0B66C2?logo=linkedin">
<a href='https://github.com/ibrahimTasdemir27/' target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/ibrahimtasdmr27-RFRatingView-xcode?logo=GitHub&color=CF212E">

- Flying Menu

## Preview
https://github.com/user-attachments/assets/c7ba04c2-4989-494a-bc77-b20dbde7179b


## Requirements
- iOS 14.0
- Xcode 15.0+
- Swift 5.10+



## Swift Package Manager

To integrate FlyingFloatingMenu into your Xcode project using Swift Package Manager, add it to the dependencies value of your Package.swift


```
dependencies: [
    .package(url: "https://github.com/ibrahimTasdemir27/FlyingFloatingMenu", .upToNextMajor(from: "2.0.0"))
]
```



## Usage
```swift
import FlyingFloatingMenu

    private let floatingButton = FlyingFloatingMenu(
        args: .init(
            topButtonStyleOptions: (
                [
                    .setTint(.black),
                    .setTag(27),
                    .setSkeleton(.loadablecolor),
                ],
                [
                    
                ]
            ),
            backButtonArgs: FlyingFloatingMenu.backButtonSymbols.enumerated().map({
                .init(buttonStyleOptions: (
                    [
                        .setRadius(25),
                        .setTint(.systemGray6),
                        .setBackground(FlyingFloatingMenu.backButtonBackgrounds[$0])
                    ], 
                    [
                        .setImage(.init(systemName: $1)?.withConfiguration(UIImage.SymbolConfiguration.init(pointSize: 18, weight: .semibold)))
                    ]
                )
                )
            }), onTapButton: {
                print("$$onTapButton:")
            }
        )
    )

```



