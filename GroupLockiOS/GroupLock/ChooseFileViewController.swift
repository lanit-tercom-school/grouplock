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
    func displayFiles(with viewModel: ChooseFile.Configure.ViewModel)
}

protocol ChooseFileViewControllerOutput {
    
    func setFetchedResultsDelegate(request: ChooseFile.SetDelegate.Request)
    func configureFetchedResultsController(request: ChooseFile.Configure.Request)
    func fetchFiles(request: ChooseFile.FetchFiles.Request)
    
    var numberOfSelectedFiles: Int { get }
    func fileSelected(request: ChooseFile.SelectFiles.Request)
    func fileDeselected(request: ChooseFile.SelectFiles.Request)
    
    var chosenFiles: [File] { get }
    var encryption: Bool { get set }
}

class ChooseFileViewController: UICollectionViewController, ChooseFileViewControllerInput {
    
    var output: ChooseFileViewControllerOutput!
    var router: ChooseFileRouter!
    
    private typealias FileInfo = ChooseFile.Configure.ViewModel.FileInfo
    private typealias CollectionViewCellFactory = ViewFactory<FileInfo, ChooseFileViewCell>
    private typealias DataSource = FetchedResultsController<File>
    private typealias FileInfoFetchedResultsController = PresentedDataSource<DataSource, FileInfo>
    private var dataSourceProvider: DataSourceProvider<FileInfoFetchedResultsController,
                                                       CollectionViewCellFactory,
                                                       CollectionViewCellFactory>!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = ChooseFile.Configure.Request(forEncryption: output.encryption)
        output.configureFetchedResultsController(request)
        
        collectionView?.applyNUI()
        collectionView?.allowsMultipleSelection = true
        
        nextButton.setTitleTextAttributes(
            [NSForegroundColorAttributeName : NUISettings.getColor("font-color-disabled", withClass: "BarButton")],
            forState: .Disabled
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        output.fetchFiles(ChooseFile.FetchFiles.Request())
    }
    
    // TODO: collectionView must be reloaded as it appears.
    // But this is a subtle moment. Need to resolve selection issue.

    func displayFiles(with viewModel: ChooseFile.Configure.ViewModel) {
        
        let cellFactory = ViewFactory(reuseIdentifier: "fileToProcessCell")
        { (cell, item: ChooseFile.Configure.ViewModel.FileInfo?,
            type, parentView, indexPath) -> ChooseFileViewCell in
            
            cell.filenameLabel.text = item?.name
            cell.thumbnailView.image = item?.thumbnail
            
            return cell
        }
        
        let fetchedResultsDelegateProvider = FetchedResultsDelegateProvider(
            cellFactory: cellFactory,
            collectionView: collectionView!
        )
        
        let request = ChooseFile.SetDelegate.Request(
            fetchedResultsControllerDelegate: fetchedResultsDelegateProvider.collectionDelegate
        )
        output.setFetchedResultsDelegate(request)
        
        let collectionViewDataSourceProvider = DataSourceProvider(
            dataSource: viewModel.fileInfoDataSource,
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
        let request = ChooseFile.SelectFiles.Request(indexPath: indexPath)
        output.fileSelected(request)
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ChooseFileViewCell
        cell.layer.borderWidth = 0
        
        let request = ChooseFile.SelectFiles.Request(indexPath: indexPath)
        output.fileDeselected(request)
        
        if output.numberOfSelectedFiles == 0 {
            nextButton.enabled = false
        }
    }
}

extension ChooseFileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let width = CollectionViewLayoutProperties.getItemWidth(forCollectionView: collectionView)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let sectionInset = CollectionViewLayoutProperties.getSectionInset(forCollectionView: collectionView)
        return UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {

        return CollectionViewLayoutProperties.getSectionInset(forCollectionView: collectionView) *
            CollectionViewLayoutProperties.minimumLineSpacingFactor
    }
}

extension ChooseFileViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        ChooseFileConfigurator.configure(self)
    }
}
