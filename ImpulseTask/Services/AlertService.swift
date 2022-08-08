//
//  AlertService.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 07.08.2022.
//

import UIKit

class AlertSevice {
    
    static func caruselAlert(okButtonHandler: @escaping () -> ()) -> UIViewController {
        let alert = UIAlertController(title: "Thank you for your interest", message: "The functionality is under development", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            okButtonHandler()
        })
        alert.overrideUserInterfaceStyle = .dark
        return alert
    }
}
