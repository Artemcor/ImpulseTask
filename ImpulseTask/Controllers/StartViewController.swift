//
//  ViewController.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 06.08.2022.
//

import UIKit

protocol StartViewControllerDelegate: AnyObject {
    func startButtonPressed()
}

class StartViewController: UIViewController {
    
    weak var delegate: StartViewControllerDelegate?
    
    // MARK: - Actions
    
    @IBAction func startButtonPressed(_ sender: Any) {
        delegate?.startButtonPressed()
    }
}

