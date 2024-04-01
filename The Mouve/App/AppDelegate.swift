//
//  AppDelegate.swift
//  The Mouve
//
//  Created by Samuel Ojogbo on 3/30/24.
//

import Foundation
import FirebaseCore
import Firebase
import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        FirebaseApp.configure()
        registerForRemoteNotifications(application) //TODO: Request authorization in a more user friendly way

        return true
    }
    
    func registerForRemoteNotifications(_ application: UIApplication) {
        Messaging.messaging().delegate = self // Firebase Messaging requirement
        
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()

    }
    
    func application(_ application: UIApplication, 
                     configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}
