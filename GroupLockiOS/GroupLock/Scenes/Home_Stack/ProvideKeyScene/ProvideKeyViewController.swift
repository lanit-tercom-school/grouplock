//
//  ProvideKeyViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol ProvideKeyViewControllerInput {
    func displayKeys(with viewModel: ProvideKey.Configure.ViewModel)
}

protocol ProvideKeyViewControllerOutput {
    
    var numberOfKeys: (Int, Int) { get }
    func getKeys(request: ProvideKey.Configure.Request)
}

class ProvideKeyViewController: UICollectionViewController, ProvideKeyViewControllerInput {
    
    var output: ProvideKeyViewControllerOutput!
    var router: ProvideKeyRouter!
    
    // MARK: - View Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        collectionView?.applyNUI()
        
        guard let collectionViewLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        CollectionViewGridLayout.setCollectionViewFlowLayout(for: collectionView!,
                                                             withBaseLayout: collectionViewLayout)
    }
    
    // MARK: - Display logic
    
    func displayKeys(with viewModel: ProvideKey.Configure.ViewModel) {
        
    }
}

extension ProvideKeyViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ProvideKeyConfigurator.configure(self)
    }
}
