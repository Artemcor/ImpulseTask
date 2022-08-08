//
//  Coordinator.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 06.08.2022.
//

import Foundation
import UIKit

class MainFlowCoordinator {
    
    private struct Constants {
        struct nibNames {
            static let startScreen = "StartScreen"
            static let caruselScreen = "CaruselScreen"
            static let timerScreen = "TimerSceen"
        }
    }
    
    // MARK: - Variables
    
    var router: MainRouter?

    // MARK: - Constants
    
    private let window: UIWindow
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public
    
    func createFlow() {
        let startViewController = StartViewController(nibName: Constants.nibNames.startScreen, bundle: nil)
        startViewController.delegate = self
        
        window.rootViewController = startViewController
        router = MainRouter(initialController: startViewController)
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private
    
    private func createCaruselScreen() {
        let caruselViewController = CaruselViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        caruselViewController.caruselDelegate = self
        
        router?.present(caruselViewController)
    }
    
    private func createCountDownScreen() {
        let countdownViewController = CountdownViewController(nibName: Constants.nibNames.timerScreen, bundle: nil)
        countdownViewController.delegate = self
        
        router?.present(countdownViewController, presentationStyle: .overFullScreen)
    }
}

// MARK: - StartViewController Delegate

extension MainFlowCoordinator: StartViewControllerDelegate {
    
    func startButtonPressed() {
        createCaruselScreen()
    }
}

// MARK: - CaruselViewController Delegate

extension MainFlowCoordinator: CaruselViewControllerDelegate {
    
    func showAlert() {
        let alert = AlertSevice.caruselAlert {
            self.router?.dismiss()
        }
        router?.present(alert)
    }
    
    func continueButtonPressed() {
        createCountDownScreen()
    }
}

// MARK: - CountdownViewController Delegate

extension MainFlowCoordinator: CountdownViewControllerDelegate {
    
    func dismiss() {
        router?.dismiss()
    }
}
    
