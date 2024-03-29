//
//  AppDelegate.swift
//  PCG
//
//  Created by Bobby Keffury on 4/20/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown
import Stripe
import ProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        DropDown.startListeningToKeyboard()
        StripeAPI.defaultPublishableKey = "pk_test_51JAgHeDI7R80RtSVqhYB0hXW9MCwOLLiQxtr0dASYPGyt2AumicDhwG0F5ZxD2NLPOvZ8NX2Nz4E2yBvsx7vP0y1009STwJYdc"
        
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorAnimation = UIColor(named: "Navy")!
        ProgressHUD.colorStatus = UIColor(named: "Navy")!
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

