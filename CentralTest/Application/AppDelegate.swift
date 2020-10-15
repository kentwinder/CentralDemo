//
//  AppDelegate.swift
//  CentralTest
//
//  Created by Kent Winder on 10/12/20.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupKeyboardManager()
        showInitialViewController(window: &window)
        return true
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    public func showInitialViewController(window: inout UIWindow?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

