# TakeawayChallenge
 Takeaway iOS Case Study

## Table of contents
* [Screenshots](#screenshots)
* [General info](#general-info)
* [Requirements](#requirements)
* [Design Pattern](#design-pattern)
* [Built-in Packages](#built-in-Packages)
* [Technologies](#technologies)
* [Dependencies](#dependencies)
* [Setup](#setup)

## Screenshots
<div align="left">
    <img src="/Screenshots/1.png" width="200px"</img>
    <img src="/Screenshots/2.png" width="200px"</img>
    <img src="/Screenshots/3.png" width="200px"</img>
    <img src="/Screenshots/4.png" width="200px"</img> 
</div>

## General info
This is an iOS Project that developed using `UIKit` framework for Takeaway iOS case study. It is a 2 pages application which are restaurant list and sorting options page for the listed restaurants in `UITableView`. Also, You can filter in restaurant list searching by restaurant names using `UISearchBar`. The first one is that RestaurantList page contains in total 4 child controllers that are called `Base`, `SearchBar`, `SelectedSortingOption` and `SearchResults`. The second one is that SortingOption page contains a `UITableView` to display filtering options.

## Requirements
iOS11+

## Design Pattern
MVVM design pattern was preferred together with `RxSwift`, used to make the project more readable, easily testable and maintainable. One of the biggest advantage of MVVM design pattern is that it seperates business and UI logics. Besides, the slight difference between commonly known MVVM and the one used in this project is using IO(Input/Output) structure as structs for view models. Also, view models were created as `function` instead of `class` to avoid retain cycle risk between controller and view model bindings.
<br />
Also, builder pattern is used to create view controllers. Each page has own builder as a public access control and these builders are used for creation of contollers. It provides us to hide the implementation of each controller and it's components.

## Navigation
Coordinator pattern was used to provide navigation between controllers in order to decoupling them by using builders. The biggest advantage is that decreasing compile time(faster compilation) by decoupling dependencies between controllers.

## Built-in Packages
There are in total 6 Swift Packages included in the project. All Swift Packages are separated to two main folders that called packages & domains.
<br /><br />
packages folder contains;
* Coordinators <br />
It is a navigation layer. Entire app navigation flows are managed by this layer. For the current situation, we have only one coordinator that called RestaurantCoordinator. We can scale our navigation layer by creating different flows in the app.

* Entities <br />
It is a simple Swift Package that contains common model objects used by multiple packages. All common model objects are kept inside this package. The main purpose for creation of this package that avoiding well known compiler error `cyclomatic dependency` in modular projects.

* FileReader <br />
It is a core local file reader implementation. It reads the file from the given bundle, then parse and return the target object. It also includes `RestaurantReader` library. The main purpose is that handling each domain's data demands individually by splitting each domain as a library in this package.

* Helper <br />
It is a layer that provides some useful and simplified `Foundation` and `UIKit` extensions.

* RxHelper <br />
This layer includes in total 2 libraries that are called `RxHelper` & `RxTestHelper`. RxHelper provides some useful and simplified RxSwift extensions. Besides, RxTestHelper provides some useful and simplified `TestScheduler` extension. It is important that RxTestHelper library is only linked for test targets.

<br />
domains folder contains; <br />

* Restaurant <br />
It is a Swift Package that includes Restaurant domain specific flows that are called RestaurantList & SortingOptions in the project. RestaurantList and SortingOptions are libraries that included in Restaurant swift package. Also, Restaurant swift package includes all unit test implementations that belongs to restaurant domain in test targets by splitting screen based test target. In addition, RestaurantList is the root screen of the window. 

## Technologies
The app is developed using:
* Swift Language version: 5
* Swift Packages
* Xcode Version 12.5.1 (12E507)

## Dependencies
Only `RxSwift` is used in the project as a 3rd party dependency.
	
## Setup
You only need to wait for a while when you open the project to install RxSwift dependency in the swift package collection.
