//
//  Router.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 07.08.2022.
//

import UIKit

protocol Router {
    func present(_ controller: UIViewController, animated: Bool, presentationStyle: UIModalPresentationStyle)
    func dismiss(animated: Bool)
}
