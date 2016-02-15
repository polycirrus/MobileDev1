//
//  LengthConverterViewController.swift
//  Mobile Development 1
//
//  Created by Aliaksandr on 2/15/16.
//
//

import UIKit

class LengthConverterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let lengthConverter = LengthConverter()
    let lengthUnits: [LengthUnit] = LengthUnit.values
    
    @IBOutlet weak var leftUnitPicker: UIPickerView!
    @IBOutlet weak var rightUnitPicker: UIPickerView!
    
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leftUnitPicker.selectRow(0, inComponent: 0, animated: false)
        rightUnitPicker.selectRow(0, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return lengthUnits.count
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lengthUnits[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == leftUnitPicker {
            lengthConverter.fromUnit = lengthUnits[row]
            updateRightValue()
        }
        if pickerView == rightUnitPicker {
            lengthConverter.toUnit = lengthUnits[row]
            updateLeftValue()
        }
    }
    
    @IBAction func leftValueChanged(sender: UITextField) {
        updateRightValue()
    }
    
    @IBAction func rightValueChanged(sender: UITextField) {
        updateLeftValue()
    }
    
    private func updateLeftValue() {
        if let rightValue = Double(rightTextField.text!) {
            let newLeftValue = lengthConverter.reverseConvert(rightValue)
            rightTextField.text = String(newLeftValue)
        }
        else {
            rightTextField.text = "-'"
        }
    }
    
    private func updateRightValue() {
        if let leftValue = Double(leftTextField.text!) {
            let newRightValue = lengthConverter.convert(leftValue)
            leftTextField.text = String(newRightValue)
        }
        else {
            leftTextField.text = "-'"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
