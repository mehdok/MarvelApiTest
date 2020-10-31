# Project structure
Project consists of a workspace and several frameworks creates in `Xcode 12`. Before opening the project please run `pod install` through the terminal. After opening `MarvelApiTest.xcworkspace` please do as follow to prevent any error:
* Build `DomainLayer`
* Build `NetworkLayer`
* Build `DataLayer`
* Run `Project`

# Architect
used `MVVM-C` as main architect and build the project with [uncle bob's CleanArch](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) in mind. I used the Reactive concept via `RxSwift`, `RxCocoa` and other Rx stuff from the community for binding all pieces together. The project consist of 3 encapsulated `framework` as CleanArchitecture suggests, they are as follows:

#### DomainLayer
Responsible for providing `Dependency Injection` mechanism, `repository protocols` for `network` and `use cases`.

#### NetworkLayer
As its name suggests this module is responsible for handling network requests, parsing results and handling errors. It's communication with the outer world is only via `NetworkModule` and `NetworkModuleMock`.

#### DataLayer
For this project the `DataLayer` module is responsible for connecting 2 previous modules and providing a UseCase for weathers. But the `DataLayer` has more responsibility than that.

#### MainProject (ElementsWeather)
Each screen consists of 4 main parts, `Coordinator`, `ViewModel`, `ViewController`, `Storyboard` that are all tied together via binding.

###### Coordinator
Coordinator is responsible for creating and connecting `ViewController` and `ViewModel`, pushing the view into navigation and returning the results if any exists.

###### ViewModel
ViewModel is responsible for communicating via `view` and `usecases` and delivering final results to `coordinator`.

###### ViewController, Storyboard
The combination of these 2 is responsible for showing UI and handling other ui events, including show loading, show error messages, handling touches and so on.
