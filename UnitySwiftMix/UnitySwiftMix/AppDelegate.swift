//
//  AppDelegate.swift
//  UnitySwiftMix
//
//  Created by xu on 2019/11/19.
//  Copyright © 2019 tech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
            
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UnityEmbeddedSwift.setLaunchinOptions(launchOptions, mainWindow: nil)
        UnityEmbeddedSwift.initUnity()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        UnityEmbeddedSwift.instance.applicationWillResignActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UnityEmbeddedSwift.instance.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        UnityEmbeddedSwift.instance.applicationWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UnityEmbeddedSwift.instance.applicationDidBecomeActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UnityEmbeddedSwift.instance.applicationWillTerminate(application)
    }
    
}

