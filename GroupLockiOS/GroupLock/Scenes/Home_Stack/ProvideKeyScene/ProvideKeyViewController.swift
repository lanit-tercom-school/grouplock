//
//  ProvideKeyViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import JSQDataSourcesKit
import Agrume

protocol ProvideKeyViewControllerInput {
    func displayKeys(with viewModel: ProvideKey.Configure.ViewModel)
}

protocol ProvideKeyViewControllerOutput {
    var files: [File] { get set }
    var numberOfKeys: (Int, Int) { get set }

    func getKeys(request: ProvideKey.Configure.Request)
}

class ProvideKeyViewController: UICollectionViewController, ProvideKeyViewControllerInput {

    var output: ProvideKeyViewControllerOutput!
    var router: ProvideKeyRouter!

    var collectionViewConfigurator: CollectionViewConfiguratorProtocol = CollectionViewConfigurator()

    typealias CollectionViewCellFactory = ViewFactory<UIImage, ProvideKeyCell>
    typealias CollectionViewDataSource = DataSource<Section<UIImage>>
    var dataSourceProvider: DataSourceProvider<CollectionViewDataSource,
                                                       CollectionViewCellFactory,
                                                       CollectionViewCellFactory>!
    var dataSource: CollectionViewDataSource!

    lazy var agrume: AgrumeProtocol = { return Agrume(images: self.dataSource[0].items) }()

    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // swiftlint:disable:next force_unwrapping (when this method is invoked collectionView is initialized)
        collectionViewConfigurator.configure(collectionView!, allowsMultipleSelection: true)
        output.getKeys(ProvideKey.Configure.Request())
    }

    // MARK: - Display logic

    func displayKeys(with viewModel: ProvideKey.Configure.ViewModel) {

        let section = Section(viewModel.qrCodes)
        dataSource = DataSource(sections: section)

        let cellFactory = ViewFactory(reuseIdentifier: "QRCodeCell") {
            (cell, item: UIImage?, type, parentView, indexPath) -> ProvideKeyCell in
            cell.keyImageView.image = item
            if !cell.selected {
                cell.darkeningView.hidden = true
            } else {
                cell.darkeningView.hidden = false
            }
            return cell
        }


        dataSourceProvider = DataSourceProvider(dataSource: dataSource,
                                                    cellFactory: cellFactory,
                                                    supplementaryFactory: cellFactory)

        collectionView?.dataSource = dataSourceProvider.collectionViewDataSource
    }

    private func darkenItem(atIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? ProvideKeyCell else { return }
        cell.darkeningView.hidden = false
    }

    private func showKey(atIndexPath indexPath: NSIndexPath) {

        darkenItem(atIndexPath: indexPath)

        agrume.showFrom(self)
        agrume.showImageAtIndex(indexPath.item)
        agrume.didScroll = { [ unowned self ] index in
            let indexPathToDarken = NSIndexPath(forItem: index, inSection: indexPath.section)
            self.darkenItem(atIndexPath: indexPathToDarken)
            // swiftlint:disable:next force_unwrapping (since by this time collectionView is initialized)
            self.collectionView!.selectItemAtIndexPath(indexPathToDarken,
                                                       animated: false,
                                                       scrollPosition: .None)
        }
    }
}

// MARK: UICollectionViewControllerDelegate
extension ProvideKeyViewController {

    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {

        showKey(atIndexPath: indexPath)
    }

    override func collectionView(collectionView: UICollectionView,
                                 shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        showKey(atIndexPath: indexPath)
        return false
    }
}

extension ProvideKeyViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ProvideKeyConfigurator.configure(self)
    }
}
