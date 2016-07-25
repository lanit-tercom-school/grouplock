//
//  NumberOfKeysViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 20.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

class NumberOfKeysViewControllerTests: XCTestCase {
    
    struct Seeds {
        struct PickerViewDataSource {
            static let numberOfComponents = 2
            static let numberOfKeys = 42
            static let arbitraryRow = 23
            static let titleForArbitraryRow = "24"
        }
        
        struct PickerViewDelegate {
            static let min = 10
            static let max = 5
        }
    }
    
    // MARK: Subject under test
    var sut: NumberOfKeysViewController!
    
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        setupNumberOfKeysViewController()
    }
    
    override func tearDown() {
        
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupNumberOfKeysViewController() {
        
        let bundle = NSBundle.mainBundle()
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard
            .instantiateViewControllerWithIdentifier("NumberOfKeysViewController") as! NumberOfKeysViewController
        loadView()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        NSRunLoop.currentRunLoop().runUntilDate(NSDate())
    }
    
    // MARK: - Test doubles
    
    class NumberOfKeysViewControllerOutputStub: NumberOfKeysViewControllerOutput {
        var numberOfKeys = Seeds.PickerViewDataSource.numberOfKeys
        var files: [File]!
    }
    
    class NumberOfKeysRouterSpy: NumberOfKeysRouter {
        
        var passDataToProvideKeyScene_called = false
        
        override func passDataToProvideKeyScene(segue: UIStoryboardSegue) {
            passDataToProvideKeyScene_called = true
        }
    }
    
    // MARK: - Tests
    
    func test_ThatPickerViewDataSource_ReturnsCorrectNumberOfComponents() {
        
        // Given
        let expectedNumberOfComponents = Seeds.PickerViewDataSource.numberOfComponents
        let pickerView = sut.pickerView
        
        // When
        let returnedNumberOfComponents = sut.numberOfComponentsInPickerView(pickerView)
        
        // Then
        XCTAssertEqual(expectedNumberOfComponents, returnedNumberOfComponents,
                       "PickerView data source should provide the correct number of components")
    }
    
    func test_ThatPickerViewDataSource_ReturnsCorrectNumberOfRows() {
        
        // Given
        sut.output = NumberOfKeysViewControllerOutputStub()
        let expectedNumberOfRows = Seeds.PickerViewDataSource.numberOfKeys
        let pickerView = sut.pickerView
        
        // When
        let returnedNumberOfRowsInComponent0 = sut.pickerView(pickerView, numberOfRowsInComponent: 0)
        let returnedNumberOfRowsInComponent1 = sut.pickerView(pickerView, numberOfRowsInComponent: 1)
        
        // Then
        XCTAssertEqual(returnedNumberOfRowsInComponent0, returnedNumberOfRowsInComponent1,
                       "Numbers of rows in both components should be equal")
        XCTAssertEqual(expectedNumberOfRows, returnedNumberOfRowsInComponent0,
                       "PickerView data source should provide the correct number of components")
    }
    
    func test_ThatPickerViewDataSource_ReturnsCorrectTitleForRow() {
        
        // Given
        let row = Seeds.PickerViewDataSource.arbitraryRow
        let expectedTitleOfRow = Seeds.PickerViewDataSource.titleForArbitraryRow
        let pickerView = sut.pickerView
        
        // When
        let returnedTitleOfRowInComponent0 = sut.pickerView(pickerView, titleForRow: row, forComponent: 0)
        let returnedTitleOfRowInComponent1 = sut.pickerView(pickerView, titleForRow: row, forComponent: 1)
        
        // Then
        XCTAssertEqual(returnedTitleOfRowInComponent0, returnedTitleOfRowInComponent1,
                       "Titles of the same rows in each component should be the equal")
        XCTAssertEqual(expectedTitleOfRow, returnedTitleOfRowInComponent0,
                       "PickerView data source should provide the correct title for a row")
    }
    
    func test_ThatPickerViewDelegate_CorrectsIfMinSetGreaterThanMax() {
        
        // Given
        sut.output = NumberOfKeysViewControllerOutputStub()
        let pickerView = sut.pickerView
        
        // When
        sut.pickerView.selectRow(Seeds.PickerViewDelegate.max, inComponent: 1, animated: false)
        sut.pickerView(pickerView, didSelectRow: Seeds.PickerViewDelegate.max, inComponent: 1)
        sut.pickerView.selectRow(Seeds.PickerViewDelegate.min, inComponent: 0, animated: false)
        sut.pickerView(pickerView, didSelectRow: Seeds.PickerViewDelegate.min, inComponent: 0)
        
        // Then
        XCTAssertEqual(pickerView.selectedRowInComponent(0), pickerView.selectedRowInComponent(1),
                       "PickerView delegate should correct picker view's values so that MIN" +
            "is never greater than MAX")
        
        let expectedSelectedRowInComponent1 = Seeds.PickerViewDelegate.min
        XCTAssertEqual(expectedSelectedRowInComponent1, pickerView.selectedRowInComponent(1),
                       "If MIN is set incorrectly after MAX, MAX should be adjusted")
    }
    
    func test_ThatPickerViewDelegate_CorrectsIfMaxSetLessThanMin() {
        
        // Given
        sut.output = NumberOfKeysViewControllerOutputStub()
        let pickerView = sut.pickerView
        
        // When
        sut.pickerView.selectRow(Seeds.PickerViewDelegate.min, inComponent: 0, animated: false)
        sut.pickerView(pickerView, didSelectRow: Seeds.PickerViewDelegate.min, inComponent: 0)
        sut.pickerView.selectRow(Seeds.PickerViewDelegate.max, inComponent: 1, animated: false)
        sut.pickerView(pickerView, didSelectRow: Seeds.PickerViewDelegate.max, inComponent: 1)
        
        // Then
        XCTAssertEqual(pickerView.selectedRowInComponent(0), pickerView.selectedRowInComponent(1),
                       "PickerView delegate should correct picker view's values so that MIN" +
            "is never greater than MAX")
        
        let expectedSelectedRowInComponent0 = Seeds.PickerViewDelegate.max
        XCTAssertEqual(expectedSelectedRowInComponent0, pickerView.selectedRowInComponent(0),
                       "If MIN is set incorrectly before MAX, MIN should be adjusted")
    }
    
    func test_ThatNumberOfKeysViewController_PassesDataToProvideKeyScene() {
        
        // Given
        let numberOfKeysRouterSpy = NumberOfKeysRouterSpy()
        sut.router = numberOfKeysRouterSpy
        sut.router.viewController = sut
        
        // When
        sut.performSegueWithIdentifier("ProvideKey", sender: nil)
        
        // Then
        XCTAssertTrue(numberOfKeysRouterSpy.passDataToProvideKeyScene_called,
                      "Performing segue should trigger passing data to ProvideKey scene")
    }
}
