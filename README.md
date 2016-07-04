GroupLock
===

[![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20Android-blue.svg)]()
[![License](https://img.shields.io/badge/license-Apache%202.0-lightgrey.svg)](LICENSE)

|| Status |
| --- |---|
| Travis CI (iOS) | [![Build Status](https://travis-ci.org/lanit-tercom-school/grouplock.svg?branch=master)](https://travis-ci.org/lanit-tercom-school/grouplock) |
| Code Coverage (iOS) | [![codecov](https://codecov.io/gh/lanit-tercom-school/grouplock/branch/master/graph/badge.svg)](https://codecov.io/gh/lanit-tercom-school/grouplock) |
| Code Quality (Swift) | [![codebeat badge](https://codebeat.co/badges/ca8bbb83-555b-443a-ad6e-eee0e1b8c24e)](https://codebeat.co/projects/github-com-lanit-tercom-school-grouplock) |
| Code Quality (Java) | [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a11a8331fa464c7abddfccbe911631f1)](https://www.codacy.com/app/lanit-tercom-school/grouplock?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=lanit-tercom-school/grouplock&amp;utm_campaign=Badge_Grade) |


Hey! This is a GroupLock project. This will allow you (in near future) to stay non-stressed about your file you sent to your mum.

Installation
------------

### Android
1. Download [Java Development Kit](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).
1. Download [Android Studio](https://developer.android.com/sdk/index.html)
1. Sign up for [genymotion.com](https://www.genymotion.com/account/create/) and download [Genymotion](https://www.genymotion.com/pricing-and-licensing/) with VirtualBox
1. Install JDK
1. Install Android Studio
1. Install VirtualBox and Genymotion. After installation run Genymotion and add virtual device.

Run Android Studio.

1. Go to **File → Open**, choose **GroupLockApplication** and press **OK**
1. Go to **Preferences → Plugins** and click **Browse Repositories**, then look for **Genymotion**. Right click and choose **Download and Install**.
1. Restart Android Studio. You should see a new icon (**Genymotion Device Manager**) in your IDE.
1. Open **Genymotion Device Manager** and start your virtual device.
1. In Android Studio, press the **Play** or **Debug** button, and you should see the dialog that asks you to choose an emulator. One of them will be the Genymotion emulator. After you choose that emulator and press **OK**, it will run the application in the Genymotion emulator.

### iOS

For building an app on iOS you need a Mac with Xcode intalled on it. You can get Xcode from Mac App Store.

1. Make sure you have the latest version of [CocoaPods](https://cocoapods.org) intalled. In order to install CocoaPods open **Terminal** and execute the following command: ` $ sudo gem install cocoapods`
1. Clone the repository and go to `GroupLockiOS` directory in Terminal.
1. Execute `$ pod install`. All the needed dependencies will be installed.
1. The project is ready to work with.

**Important:** use `GroupLock.xcworkspace` file, not `GroupLock.xcodeproj`!
