//
//  CaruselViewController.swift
//  ImpulseTask
//
//  Created by Artem Stozhok on 06.08.2022.
//

import UIKit

protocol CaruselViewControllerDelegate: AnyObject {
    func continueButtonPressed()
    func showAlert()
}

class CaruselViewController: UIPageViewController {
    
    weak var caruselDelegate: CaruselViewControllerDelegate?
    
    // MARK: - Variables
    
    var pages = [UIViewController]()
    
    var shouldConvertToNextButton = false
    var continueButtonPressed = false
    
    // MARK: - Constants
    
    let initialPage = 0

    //External Controls
    let nextButton = UIButton(type: .system)
    let pageControl = UIPageControl()
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        style()
        layout()
    }
    
    // MARK: - Actions
    
    @objc private func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        if pageControl.currentPage == pages.count - 1 {
            convertCaruselButtonToContiniue()
            shouldConvertToNextButton = true
        }
    }
    
    @objc private func continiueTapped(_ sender: UIButton) {
        if continueButtonPressed == false {
            caruselDelegate?.continueButtonPressed()
        } else {
            caruselDelegate?.showAlert()
            return
        }
        continueButtonPressed = true
    }
    
    // MARK: - Private
    
    private func configure() {
        dataSource = self
        delegate = self
        
        let page1 = PageViewController(imageName: "boostProductivity", titleText: "Boost Productivity", subtitleText: "Take your productivity to the next level")
        
        let page2 = PageViewController(imageName: "workSeamlessly", titleText: "Work Seamlessly", subtitleText: "Get your work done seamlessly without interruption")
        
        let page3 = PageViewController(imageName: "achieveYourGoals", titleText: "Achieve Your Goals", subtitleText: "Boosted productivity will help you achieve the desired goals")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    private func style() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage

        let buttonTitleFont = UIFont(name: "Inter-Bold", size: 16)
        nextButton.titleLabel?.font = buttonTitleFont
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = UIColor(named: "elementsColor")
        nextButton.layer.cornerRadius = 10

        convertCaruselButtonToNext()
    }
    
    private func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            nextButton.heightAnchor.constraint(equalToConstant: 52),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -28),
            pageControl.heightAnchor.constraint(equalToConstant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func convertCaruselButtonToNext() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.removeTarget(nil, action: nil, for: .allEvents)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
    }
    
    private func convertCaruselButtonToContiniue() {
        nextButton.setTitle("Continue", for: .normal)
        nextButton.removeTarget(nil, action: nil, for: .allEvents)
        nextButton.addTarget(self, action: #selector(continiueTapped(_:)), for: .primaryActionTriggered)
    }
    
    private func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
}

// MARK: - PageViewController DataSource

extension CaruselViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

// MARK: - PageViewController Delegate

extension CaruselViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        
        if pageControl.currentPage == pages.count - 1 {
            convertCaruselButtonToContiniue()
            shouldConvertToNextButton = true
        } else if shouldConvertToNextButton {
            convertCaruselButtonToNext()
            shouldConvertToNextButton = false
        }
    }
}


