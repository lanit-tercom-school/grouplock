//
//  LibraryPageViewController.swift
//  
//
//  Created by Sergej Jaskiewicz on 12.05.16.
//
//

import UIKit

class LibraryPageViewController: UIPageViewController {

    override func viewDidLoad() {
        dataSource = self
    }

}

extension LibraryPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
}