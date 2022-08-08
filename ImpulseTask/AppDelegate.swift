//
//  AppDelegate.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 06.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: MainFlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = MainFlowCoordinator(window: window!)
        coordinator?.createFlow()

        return true
    }
}
