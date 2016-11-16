//
//  OnboardingPageVC.swift
//  Beacon
//
//  Created by Laticia Chance on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import UIKit

class OnboardingPageVC: UIPageViewController {
    
    let onboardingText = ["Too often we focus on the negative events or situations surrounding us. Beacon is daily your ray of positivity. Continue to find out more", "Getting started is simple. First, sign in anonymously or provide your name and location. Then share something positive with the Beacon community", "Did someone on the train give you a compliment? Are you grateful for your friends or family? Whatever it is, we want to hear it!"]
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageVC(VCorder: "First"),
                self.newPageVC(VCorder: "Second"),
                self.newPageVC(VCorder: "Third"),
                self.newPageVC(VCorder: "Final")]
    }()
    
    private func newPageVC(VCorder: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(VCorder)VC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UIPageViewControllerDataSource

extension OnboardingPageVC: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

