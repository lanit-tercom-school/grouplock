//
//  Agrume.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import Agrume

protocol AgrumeProtocol {
    func showFrom(viewController: UIViewController)
    func showImageAtIndex(index: Int)
    var didScroll: ((index: Int) -> Void)? { get set }
}

extension Agrume: AgrumeProtocol {}

extension AgrumeProtocol where Self: Agrume {
    func showFrom(viewController: UIViewController) {
        showFrom(viewController, backgroundSnapshotVC: nil)
    }
}
