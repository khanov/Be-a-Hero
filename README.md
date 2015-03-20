<img src="http://khanov.com/be-a-hero-icon.jpg" width="140">
# Be a Hero

This is my app for Myriad Mobile's iOS Internship Challenge - Summer 2015.

#### Launch

This project uses CocoaPods, run `pod install` to install necessary pods and open the `Be a Hero.xcworkspace` file.

#### Requirements

* Xcode 6.2
* iOS 8.2

## Objective

Once upon a time, a brave hero could simply go to a town center to discover a list of quests with which to feed himself. Unfortunately, as with all things, as the world becomes more complicated, the life of a hero becomes more difficult and busy. Today, it is a heroic quest to simply even find the town center. We have been tasked with simplifying this process.

As a potential Mobile Master, your duty is to construct a solution for this terrible injustice in the form of a 21st century Quest-Board. Here, damsels in distress, kings under siege, and townsfolk threatened by dangerous beasts will make their quests available to all the great heroes of the world. By connecting heroes with quest-givers, you will not only improve the lives of citizens in our great kingdom, but also the lives of heroes whom we rely upon.

## Screen Description

All screens support both portrait and landscape orientation (using Auto Layout).

### Login Screen

<img src="http://khanov.com/login-screen.png" height="667">

Allows user to enter name and email.

* Both fields are required.
* Email is validated before posting to API.
* Email and name is saved to NSUserDefaults.
* HTTP Post request is performed to API with the submitted data.

### Kingdom List Screen

<img src="http://khanov.com/list-screen.png" height="667">

Displays Kingdom info in a list.

* Kindom information is fetched by sending an HTTP Get request to API.
* Kingdom name and image is displayed in the list.
* Log Out removes user's name and email from NSUserDefaults and navigates back to the Login Screen.

### Kingdom Details Screen

<img src="http://khanov.com/details-screen.png" height="667">

Displays all the detail information about selected Kingdom.

* Kingdom details are fetched by sending an HTTP Get request to API.
* Displays Kingdom name, image, population, and climate.
* Displays all available quests in this Kingdom with info about their givers.

## Open Source Components

* [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* [Realm](https://github.com/realm/realm-cocoa)
* [Async](https://github.com/duemunk/Async)
