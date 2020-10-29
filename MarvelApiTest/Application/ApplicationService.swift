//
//  ApplicationService.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

public protocol ApplicationService {
    func initialize()

    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [
            UIApplication
                .LaunchOptionsKey: Any
        ]?
    ) -> Bool

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication
                .LaunchOptionsKey: Any
        ]?
    ) -> Bool

    func applicationDidEnterBackground(_ application: UIApplication)

    func applicationWillEnterForeground(_ application: UIApplication)

    func applicationDidBecomeActive(_ application: UIApplication)

    func applicationWillResignActive(_ application: UIApplication)

    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication)

    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication)

    func applicationDidReceiveMemoryWarning(_ application: UIApplication)

    func applicationWillTerminate(_ application: UIApplication)

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error)
}

// MARK: - Optionals

extension ApplicationService {
    func initialize() {}

    func application(
        _: UIApplication,
        willFinishLaunchingWithOptions _: [
            UIApplication
                .LaunchOptionsKey: Any
        ]? = nil
    ) -> Bool { true }

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [
            UIApplication
                .LaunchOptionsKey: Any
        ]? =
            nil
    ) -> Bool { true }

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillResignActive(_: UIApplication) {}

    func applicationProtectedDataWillBecomeUnavailable(_: UIApplication) {}

    func applicationProtectedDataDidBecomeAvailable(_: UIApplication) {}

    func applicationDidReceiveMemoryWarning(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}

    func application(
        _: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken _: Data
    ) {}

    func application(
        _: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError _: Error
    ) {}
}
