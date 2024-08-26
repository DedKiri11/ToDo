//
//  AppDelegate.swift
//  To-do
//
//  Created by Кирилл Зезюков on 26.08.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = ViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: vc)
        return true
    }
}

