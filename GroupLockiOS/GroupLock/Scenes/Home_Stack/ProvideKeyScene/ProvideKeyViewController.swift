//
//  ProvideKeyViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import JSQDataSourcesKit

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
    
    private typealias CollectionViewCellFactory = ViewFactory<UIImage, ProvideKeyCell>
    private typealias CollectionViewDataSource = DataSource<Section<UIImage>>
    private var dataSourceProvider: DataSourceProvider<CollectionViewDataSource,
                                                       CollectionViewCellFactory,
                                                       CollectionViewCellFactory>!
    
    // MARK: - View Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        output.getKeys(ProvideKey.Configure.Request())
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
        
        let section = Section(viewModel.qrCodes)
        let dataSource = DataSource(sections: section)
        
        let cellFactory = ViewFactory(reuseIdentifier: "QRCodeCell")
        { (cell, item: UIImage?, type, parentView, indexPath) -> ProvideKeyCell in
            cell.keyImageView.image = item
            return cell
        }
        
        
        dataSourceProvider = DataSourceProvider(dataSource: dataSource,
                                                    cellFactory: cellFactory,
                                                    supplementaryFactory: cellFactory)
        
        
        collectionView?.dataSource = dataSourceProvider.collectionViewDataSource
    }
}

extension ProvideKeyViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ProvideKeyConfigurator.configure(self)
    }
}
