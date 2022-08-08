//
//  PageViewController.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 06.08.2022.
//

import UIKit

class PageViewController: UIViewController {
    
    private struct Constants {
        struct nibName {
            static let pageScreen = "PageScreen"
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var pageImage: UIImageView!
    
    @IBOutlet private weak var pageMainTitle: UILabel!
    @IBOutlet private weak var pageSubtitle: UILabel!
    
    // MARK: - Variables
    
    private var imageName = ""
    private var titleText = ""
    private var subtitleText = ""
    
    // MARK: - Initializer
    
    init(imageName: String, titleText: String, subtitleText: String) {
        super.init(nibName: Constants.nibName.pageScreen, bundle: nil)
        self.imageName = imageName
        self.titleText = titleText
        self.subtitleText = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Private
    
    private func configure() {
        pageImage.image = UIImage(named: imageName)
        pageMainTitle.text = titleText
        pageSubtitle.text = subtitleText
    }
}
