//
//  AppDelegate.swift
//  tichu-scorer
//
//  Created by Peter Schmitt on 5/5/19.
//  Copyright © 2019 Peter Schmitt. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gameStateController: GameStateController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        gameStateController = GameStateController()
        
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let scoreViewController = navigationController.viewControllers[0] as? ScoreViewController else {
            return true
        }
        scoreViewController.gameStateController = gameStateController
        
        return true
    }
}

