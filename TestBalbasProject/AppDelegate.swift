//
//  AppDelegate.swift
//  TestBalbasProject
//
//  Created by 平野裕貴 on 2024/10/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ViewControllerをルートビューコントローラとして設定
        let viewController = ViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
