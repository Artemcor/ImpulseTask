//
//  MainRouter.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 07.08.2022.
//

import UIKit

class MainRouter: Router {
    
    private var contollerStack = [UIViewController]()
    
    init(initialController: UIViewController) {
        contollerStack.append(initialController)
    }
    
    func present(_ controller: UIViewController, animated: Bool = true, presentationStyle: UIModalPresentationStyle = .fullScreen) {
        controller.modalPresentationStyle = presentationStyle
        contollerStack.last?.present(controller, animated: animated)
        contollerStack.append(controller)
    }
    
    func dismiss(animated: Bool = true) {
        contollerStack.last?.dismiss(animated: animated)
        contollerStack.removeLast()
    }

}
