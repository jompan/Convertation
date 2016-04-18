//
//  ViewController.swift
//  Convertation
//
//  Created by Joel Kronman on 2016-04-14.
//  Copyright © 2016 Joel Kronman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var tempUnits : NSDictionary!
    var lengthUnits1 : NSDictionary!
    var units2 : NSDictionary!
    var units3 : NSDictionary!

    var tempKeys : NSArray!
    var lengthKeys1 : NSArray!
    var keys2 : NSArray!
    var keys3 : NSArray!
    

    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var pvUnitFrom: UIPickerView!
    @IBOutlet weak var pvUnitTo: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1. get a refernce to the app bundle
        let appBundle = NSBundle.mainBundle()
        
        //2.get a reference to the path of the file that contains the unit
        let filePath1 = appBundle.pathForResource("lengthList", ofType: "plist")!
        let filePath2 = appBundle.pathForResource("weightList", ofType: "plist")!

        //load the contents of the file into the dictionary
        tempUnits = NSDictionary(contentsOfFile: filePath1)
        lengthUnits1 = NSDictionary(contentsOfFile: filePath1)
        units2 = NSDictionary(contentsOfFile: filePath2)
        
        //Initiailze the keys with the names of the units
        tempKeys = lengthUnits1.allKeys as NSArray
        lengthKeys1 = lengthUnits1.allKeys as NSArray
        keys2 = units2.allKeys as NSArray

        //Sort the keys in alphabetical in ascending order
        tempKeys = lengthKeys1.sort(sortKeys)
        lengthKeys1 = lengthKeys1.sort(sortKeys)
        keys2 = keys2.sort(sortKeys)

        
        
    }
    
    var pickerLength = 12
    
    func sortKeys(first: AnyObject, second: AnyObject) -> Bool {
        let firstKey = first as! String
        let secondKey = second as! String
        return firstKey.caseInsensitiveCompare(secondKey) == NSComparisonResult.OrderedAscending
        
    }

    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerLength
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        title = tempKeys.objectAtIndex(row) as! String
        
        return title
    }
    
    @IBAction func convert() {
        //1. Retrieve the amount from the text field
        let amountAsString = txtAmount.text!
        let numberFormatter = NSNumberFormatter()
        let amountAsNumber = numberFormatter.numberFromString(amountAsString)!
        let amountAsFloat = amountAsNumber.floatValue
        
        //2. Retrieve the unit that the user select to convert from
        let indexOfSelectedUnitFrom = pvUnitFrom.selectedRowInComponent(0)
        let unitFrom = tempKeys.objectAtIndex(indexOfSelectedUnitFrom) as! String
        
        //3. Retrieve the unit that the user selected to convert to
        let indexOfSelectedUnitTo = pvUnitTo.selectedRowInComponent(0)
        let unitTo = tempKeys.objectAtIndex(indexOfSelectedUnitTo) as! String
        
        //4. apply the two step conversion
        let conversionFactorToStart = tempUnits.valueForKey(unitFrom) as! Float
        let resultAsInch = amountAsFloat * conversionFactorToStart
        
        let conversionFactorFromStart = tempUnits.valueForKey(unitTo) as! Float
        let result = resultAsInch / conversionFactorFromStart
        
        //5. format the result as a string
        let resultAsString = String.localizedStringWithFormat("%0.3f %@ = %.3f %@",amountAsFloat,unitFrom,result,unitTo)
        
        //6. assign the result string to the label
        lblResult.text = resultAsString
        
        //7. dismiss the keyboard from the text field
        txtAmount.resignFirstResponder()
    }

    @IBAction func lengthButton(sender: AnyObject) {
        
        tempKeys = lengthKeys1
        tempUnits = lengthUnits1
        pickerLength = lengthKeys1.count
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]
    }
    
    @IBAction func weightButton(sender: AnyObject) {
        tempKeys = keys2
        tempUnits = units2
        pickerLength = keys2.count
        
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]
    }

}

