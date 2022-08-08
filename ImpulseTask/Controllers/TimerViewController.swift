//
//  CountdownViewController.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 07.08.2022.
//

import UIKit

protocol CountdownViewControllerDelegate: AnyObject {
    func dismiss()
}

class CountdownViewController: UIViewController {
    
    private struct Contstant {
        static let second = 1
        static let timeToRecord = 60
    }
    
    weak var delegate: CountdownViewControllerDelegate?
    
    // MARK: - Outlets

    @IBOutlet private weak var countDownLabel: UILabel!
    @IBOutlet private weak var progressLineView: UIView!
    @IBOutlet private weak var progressView: UIView!
    @IBOutlet private weak var continueButton: UIButton!
    
    @IBOutlet private weak var progressLineRightConstraint: NSLayoutConstraint!
    
    // MARK: - Variebles

    private var timer: Timer?
    private var secondsNumber = 0
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureTimer()
    }
    
    // MARK: - Actions
    
    @IBAction private func continueButtonPressed(_ sender: Any) {
        delegate?.dismiss()
    }
    
    // MARK: - Private
    
    private func configure() {
        continueButton.isEnabled = false
        continueButton.alpha = 0.4
    }
    
    private func enableContinueButton() {
        continueButton.isEnabled = true
        continueButton.alpha = 1
    }
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateCountdownTitles),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func updateProgressLine(percent: CGFloat) {
        progressLineRightConstraint.constant = CGFloat(-percent * progressView.frame.width)
    }

    @objc private func updateCountdownTitles() {
        secondsNumber += Contstant.second
        
        let progress = CGFloat(0.0 + ( (Float(secondsNumber)) / Float(Contstant.timeToRecord)))
        updateProgressLine(percent: progress)
        
        if secondsNumber > 9 {
            countDownLabel.text = "00:\(secondsNumber)"
        } else {
            countDownLabel.text = "00:0\(secondsNumber)"
        }
        
        if secondsNumber == Contstant.timeToRecord {
            countDownLabel.text = "01:00"
            enableContinueButton()
            timer?.invalidate()
        }
    }
}


