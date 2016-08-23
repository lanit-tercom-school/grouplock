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
    func displayKeys(_ viewModel: ProvideKey.Configure.ViewModel)
}

protocol ProvideKeyViewControllerOutput {
    var files: [File] { get set }
    var numberOfKeys: (Int, Int) { get set }

    func getKeys(_ request: ProvideKey.Configure.Request)
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



    /// Creates an instance of an image viewer
    var imageViewerProvider: ([UIImage]) -> ImageViewer = { images in
        return Agrume(images: images)
    }

    // MARK: - View Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // swiftlint:disable:next force_unwrapping (when this method is invoked collectionView is initialized)
        collectionViewConfigurator.configure(collectionView!, allowsMultipleSelection: true)
        output.getKeys(ProvideKey.Configure.Request())
    }

    // MARK: - Display logic

    func displayKeys(_ viewModel: ProvideKey.Configure.ViewModel) {

        let section = Section(viewModel.qrCodes)
        dataSource = DataSource(sections: section)

        let cellFactory = ViewFactory(reuseIdentifier: "QRCodeCell") {
            (cell, item: UIImage?, type, parentView, indexPath) -> ProvideKeyCell in
            cell.keyImageView.image = item
            if !cell.isSelected {
                cell.darkeningView.isHidden = true
            } else {
                cell.darkeningView.isHidden = false
            }
            return cell
        }


        dataSourceProvider = DataSourceProvider(dataSource: dataSource,
                                                    cellFactory: cellFactory,
                                                    supplementaryFactory: cellFactory)

        collectionView?.dataSource = dataSourceProvider.collectionViewDataSource
    }

    private func darkenItem(at indexPath: IndexPath) {
        guard let cell = collectionView?.cellForItem(at: indexPath) as? ProvideKeyCell else { return }
        cell.darkeningView.isHidden = false
    }

    fileprivate func showKey(at indexPath: IndexPath) {

        darkenItem(at: indexPath)
        let imageViewer = imageViewerProvider(dataSource[0].items)
        imageViewer.showFrom(self)
        imageViewer.showImage(atIndex: indexPath.item)
        imageViewer.didScroll = { [ unowned self ] index in
            let indexPathToDarken = IndexPath(item: index, section: indexPath.section)
            self.darkenItem(at: indexPathToDarken)
            // swiftlint:disable:next force_unwrapping (since by this time collectionView is initialized)
            self.collectionView!.selectItem(at: indexPathToDarken,
                                            animated: false,
                                            scrollPosition: [])
        }
    }
}

// MARK: UICollectionViewControllerDelegate
extension ProvideKeyViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {

        showKey(at: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        showKey(at: indexPath)
        return false
    }
}

extension ProvideKeyViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ProvideKeyConfigurator.configure(self)
    }
}
