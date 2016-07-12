//
//  ChooseFileViewController.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.05.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit
import NUI
import JSQDataSourcesKit

protocol ChooseFileViewControllerInput {
    func displayCollectionView(with viewModel: ChooseFileViewModel)
}

protocol ChooseFileViewControllerOutput {
    var files: [File] { get set }
    var selectedFiles: [Int : File] { get set }
    func fetchFiles()
}

class ChooseFileViewController: UICollectionViewController, ChooseFileViewControllerInput {
    
    var output: ChooseFileViewControllerOutput!
    var router: ChooseFileRouter!
    
    private let relativeInset = CGFloat(1.0 / 12.0)
    
    typealias CollectionViewCellFactory = ViewFactory<File, ChooseFileViewCell>
    private var dataSourceProvider:  DataSourceProvider<FetchedResultsController<File>,
                                                                      CollectionViewCellFactory,
                                                                      CollectionViewCellFactory>!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.fetchFiles()
        collectionView?.applyNUI()
        collectionView?.allowsMultipleSelection = true
        
        // FIXME: This causes a lag when entering this screen. This property has to be set in the background.
        
        nextButton.setTitleTextAttributes(
            [NSForegroundColorAttributeName : NUISettings.getColor("font-color-disabled", withClass: "BarButton")],
            forState: .Disabled
        )
    }
    
    // TODO: collectionView must be reloaded as it appears.
    // But this is a subtle moment. Need to resolve selection issue.

    // MARK: UICollectionViewDataSource

    func displayCollectionView(with viewModel: ChooseFileViewModel) {
        
        let cellFactory = ViewFactory(reuseIdentifier: "fileToProcessCell")
        { (cell, item: File?, type, parentView, indexPath) -> ChooseFileViewCell in
            
            cell.filenameLabel.text = viewModel.formatFileInfo(item!).name
            cell.thumbnailView.image = viewModel.formatFileInfo(item!).thumbnail
            
            return cell
        }
        
        let fetchedResultsDelegateProvider = FetchedResultsDelegateProvider(
            cellFactory: cellFactory,
            collectionView: collectionView!
        )
        
        viewModel.fetchedResultsController.delegate = fetchedResultsDelegateProvider
            .collectionDelegate
        
        let collectionViewDataSourceProvider = DataSourceProvider(
            dataSource: viewModel.fetchedResultsController,
            cellFactory: cellFactory,
            supplementaryFactory: cellFactory
        )
        
        dataSourceProvider = collectionViewDataSourceProvider
        
        collectionView?.dataSource = dataSourceProvider.collectionViewDataSource
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ChooseFileViewCell
        
        cell.layer.borderWidth = CGFloat(NUISettings.getFloat("selected-border-width",
                                                              withClass: "CollectionViewCell"))
        nextButton.enabled = true
        output.selectedFiles[indexPath.item] = output.files[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ChooseFileViewCell
        cell.layer.borderWidth = 0
        
        output.selectedFiles[indexPath.item] = nil
        
        if output.selectedFiles.count == 0 {
            nextButton.enabled = false
        }
    }
}

extension ChooseFileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let sectionInset = collectionView.frame.width * relativeInset
        let width = (collectionView.frame.width - 3*sectionInset) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let sectionInset = collectionView.frame.width * relativeInset
        return UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        let sectionInset = collectionView.frame.width * relativeInset / 1.5
        return sectionInset
    }
}

extension ChooseFileViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ChooseFileConfigurator.configure(self)
    }
}
