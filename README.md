<img width="1280" alt="MicrosoftTeams-image (18)" src="https://github.com/SimformSolutionsPvtLtd/SSExpandableSwipeUpView/assets/99391641/9bf6dfb6-8e99-4435-acdb-dc57967acac6">


# SSExpandableSwipeUpView

SSExpandableSwipeUpView is a powerful Swift library developed using the SwiftUI framework for iOS applications. It resembles iPhone notification tray, also known as the Notification Center, is a centralized hub designed to provide users with a quick and organized overview of their incoming alerts, messages, and updates. Accessible by swiping down from the top edge of the screen, the notification tray displays a chronological list of notifications from various apps and system events. The library offers a wide range of customizable options. SSExpandableSwipeUpView is simple to integrate into your existing projects and offers excellent performance, making it an essential tool for any iOS developer contributing to a seamless and personalized user experience.
 
# Features!
  - Group stack view like notification control center
  - Clear all and remove options
  - Expand and collapse views 
  - Fully customizable 
  - CocoaPods


<center><img src="https://github.com/SimformSolutionsPvtLtd/SSExpandableSwipeUpView/assets/99391641/e062b418-d30b-45e0-bd15-d4ebf08eb1e0" height="500"/></center>

  
# Requirements
  - iOS 16
  - Xcode 14

# Installation
 **CocoaPods**
 
- You can use CocoaPods to install SSExpandableSwipeUpView by adding it to your Podfile:

       use_frameworks!
       pod 'SSExpandableSwipeUpView'

-  
       import UIKit
       import SSExpandableSwipeUpView
       
**Swift Package Manager**
 
- When using Xcode 11 or later, you can install SSExpandableSwipeUpView by going to your Project settings > Swift Packages and add the repository by providing the GitHub URL. Alternatively, you can go to File > Swift Packages > Add Package Dependencies...

- import SSExpandableSwipeUpView

**Manually**

- Add SSExpandableSwipeView folder from /Sources folder to your project.

# Usage

```swift
var viewModel = SectionContentsViewModel()
    
init() {
   setupViewModel()
 }
    
private func setupViewModel() {
let gPayContents = [
      SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Alex, You have received $10M in your account!", createdDate: Date()),
      SwipeViewContent(appImageName: "googlePay", title: "Payment Received", subtitle: "Alex, You have received $5M in your account!", createdDate: Date())]

let teamsContents = [
      SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Hey, Alex", createdDate: Date()),
      SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "What is the progress?", createdDate: Date()),
      SwipeViewContent(appImageName: "teams", title: "Gotham Steve", subtitle: "Are you on timeline?", createdDate: Date())]

      viewModel.addSection(title: "Google Pay", isExpanded: true, swipeViewContents: gPayContents)
      viewModel.addSection(title: "Teams", isExpanded: true, swipeViewContents: teamsContents)
}

var body: some View {
      SSExpandableSwipeUpView(viewModel: viewModel, backgroundWallpaper: Image("wallpaper"), onOptions: { banner in
            /// swipe view banner content options click event
       })
    }
```
# More Customization
You can customize fonts of banner Header, title and body also you can add image name ("appImageName") as per your data.
```swift
SwipeViewContent(appImageName: "googlePay", title: "Payment Received", titleFontStyle: (font: "YOUR_FONT_NAME", size: 20, color: .blue),
subtitle: "Alex, You have received $10M in your account!", subtitleFontStyle: (font: "YOUR_FONT_NAME", size: 18, color: .yellow), createdDate: Date())
```

Section title customization
```swift
viewModel.addSection(title: "Google Pay", titleFontStyle: (font: "YOUR_FONT_NAME", size: 40, color: .red),
isExpanded: true, swipeViewContents: gPayContents)
```

## 🤝 How to Contribute

Whether you're helping us fix bugs, improve the docs, or a feature request, we'd love to have you! :muscle:

Check out our [**Contributing Guide**](CONTRIBUTING.md) for ideas on contributing.

## Find this example useful? ❤️

Give a ⭐️ if this project helped you!

## Check out our other Libraries

<h3><a href="https://github.com/SimformSolutionsPvtLtd/Awesome-Mobile-Libraries"><u>🗂 Simform Solutions Libraries→</u></a></h3>

## MIT License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

    
[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/assets/svg/badges/C-ffb83f-7198e9a1b7ad7f73977b0c9a5c7c3fffbfa25f262510e5681fd8f5a3188216b0.svg
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
[platform-image]:https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat
[platform-url]:http://cocoapods.org/pods/LFAlertController
[cocoa-image]:https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg
[cocoa-url]:https://img.shields.io/cocoapods/v/LFAlertController.svg
[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[PR-url]:http://makeapullrequest.com

