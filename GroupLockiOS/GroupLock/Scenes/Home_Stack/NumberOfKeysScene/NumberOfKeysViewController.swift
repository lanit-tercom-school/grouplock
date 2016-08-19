//
//  NumberOfKeysViewController.swift
//  GroupLock
//
//  Created by Nikita Fedorov on 08/07/16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import UIKit

protocol NumberOfKeysViewControllerInput {

}

protocol NumberOfKeysViewControllerOutput {
    var numberOfKeys: Int { get }
    var files: [File] { get set }
}

class NumberOfKeysViewController: UIViewController {

    var output: NumberOfKeysViewControllerOutput!
    var router: NumberOfKeysRouter!

    @IBOutlet var pickerView: UIPickerView!
}

extension NumberOfKeysViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return output.numberOfKeys

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
}

extension NumberOfKeysViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRow(inComponent: 0) > pickerView.selectedRow(inComponent: 1) {
            pickerView.selectRow(pickerView.selectedRow(inComponent: component),
                                 inComponent: -component + 1,
                                 animated: true)
        }
    }
}

extension NumberOfKeysViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
        NumberOfKeysConfigurator.configure(self)
    }
}
