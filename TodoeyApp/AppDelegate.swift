//
//  AppDelegate.swift
//  TodoeyApp
//
//  Created by Jasur Salimov on 8/30/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 2) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("It was finished")
    }
}
