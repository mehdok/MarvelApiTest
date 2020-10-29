//
//  PluggableApplicationDelegate.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?

    /// Lazy implementation of application services list
    public lazy var lazyServices: [ApplicationService] = services()

    /// List of application services for binding to `AppDelegate` events
    open func services() -> [ApplicationService] {
        return [ /* Populated from sub-class */ ]
    }

    public override init() {
        super.init()

        lazyServices.forEach {
            $0.initialize()
        }
    }
}

public extension PluggableApplicationDelegate {
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [
            UIApplication
                .LaunchOptionsKey: Any
        ]? = nil
    ) -> Bool {
        return lazyServices.reduce(true) {
            $0 && $1
                .application(application,
                             willFinishLaunchingWithOptions: launchOptions)
        }
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication
                .LaunchOptionsKey: Any
        ]? = nil
    ) -> Bool {
        return lazyServices.reduce(true) {
            $0 && $1
                .application(application,
                             didFinishLaunchingWithOptions: launchOptions)
        }
    }
}

public extension PluggableApplicationDelegate {
    func applicationDidEnterBackground(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationDidEnterBackground(application)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationWillEnterForeground(application)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationDidBecomeActive(application)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationWillResignActive(application)
        }
    }

    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationProtectedDataWillBecomeUnavailable(application)
        }
    }

    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationProtectedDataDidBecomeAvailable(application)
        }
    }

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationDidReceiveMemoryWarning(application)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        lazyServices.forEach {
            $0.applicationWillTerminate(application)
        }
    }
}

public extension PluggableApplicationDelegate {
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        lazyServices.forEach {
            $0
                .application(application,
                             didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        lazyServices.forEach {
            $0
                .application(application,
                             didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
}
