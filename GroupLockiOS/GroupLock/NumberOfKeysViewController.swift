//
//  NumberOfKeysViewController.swift
//  GroupLock
//
//  Created by Nikita Fedorov on 08/07/16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

class NumberOfKeysViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let maximumNumberOfKeys = 15
    var options : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...maximumNumberOfKeys {
            options.append(i)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(options[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRowInComponent(0) > pickerView.selectedRowInComponent(1) {
            pickerView.selectRow(pickerView.selectedRowInComponent(component), inComponent: -component + 1 , animated: true)
        }
    }
    
}