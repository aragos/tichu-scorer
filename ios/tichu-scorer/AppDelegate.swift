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
    var playerController: PlayerController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        gameStateController = GameStateController()
        playerController = PlayerController()
        
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let menuViewController = navigationController.topViewController as? MenuViewController else {
            return true
        }
        menuViewController.gameStateController = gameStateController
        menuViewController.playerController = playerController
        
        return true
    }
}

