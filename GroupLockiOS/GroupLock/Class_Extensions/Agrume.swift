//
//  Agrume.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Agrume

/**
 * A class conforming to `ImageViewer` protocol is responsible for presenting an interface for viewing
 * a single image or an array of images.
 */
protocol ImageViewer {

    /**
     Presents viewing interface.

     - parameter viewController: A view controller from which the image viewer should be presented.
     */
    func showFrom(_ viewController: UIViewController)

    /**
     Provides an initial state for the image viewer if more than one image is to be used.

     - parameter index: An index of image in the data source that should be presented initially.
     */
    func showImage(atIndex index: Int)

    /// A handler that is called each time the image viewer scrolls to a next image.
    var didScroll: ((_ index: Int) -> Void)? { get set }
}

extension Agrume: ImageViewer {}

extension ImageViewer where Self: Agrume {
    func showFrom(_ viewController: UIViewController) {
        showFrom(viewController, backgroundSnapshotVC: nil)
    }
}
