## HEALIOS TECHNICAL ASSESMENT

### Basic Information

The assesment consist of developing an iOS App in Swift that fetch resources from a service and persist them in Core Data. As soon as the resources are persisted, no connetions are allowed.

The app is developed using XCode 11.6 and is compiled in Swift 5.0

### Architecture
The app is develope using a MVVM architecture using coordinators, viewControllers and viewModels. 
Network layer is developed using RxSwift and Alamofire.

### Dependencies

 **_RxSwift & RxCocoa_**
 
 Rx is a generic abstraction of computation expressed through Observable<Element> interface.

It tries to port as many concepts from the original version as possible, but some concepts were adapted for more pleasant and performant integration with iOS/macOS environment.

Cross platform documentation can be found on ReactiveX.io.

Like the original Rx, its intention is to enable easy composition of asynchronous operations and event/data streams.

KVO observing, async operations and streams are all unified under abstraction of sequence. This is the reason why Rx is so simple, elegant and powerful.

**_Alamofire_**

Alamofire is an HTTP networking library written in Swift.

#### Install Cocoa Pods

- this installs the CocoaPods application
- CocoaPods is a Ruby gem
- do the same to update Cocoa Pods

```bash
$ sudo gem install cocoapods
```

---


#### Creating a Podfile

```
pod init
```


---

#### The Podfile


```ruby
platform :ios, '9.0'
use_frameworks! # Comment this if you're not using Swift 
                # and don't want to use dynamic frameworks

#inhibit_all_warnings!

project 'MyApp.xcodeproj'

target 'MyApp' do
  pod 'SwiftyJSON'
  pod 'KingFisher'
end
```

---

## Install pods

- Install project dependencies according to versions from a Podfile.loc
- creates a Workspace
    - __use the workspace!__

```bash
$ pod install

Analyzing dependencies
Downloading dependencies
Generating Pods project
Integrating client project
...
```

---

## Update / add / remove pods

1. edit Podfile
1. run `pod install` again

---


### Contributing

If you spot an error / typo / dead link / something missing, please file an issue.
Pull requests are always welcome ;-)

###LICENSE

MIT - Licence

Copyright (c) 2020 Eugenio Barquin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
