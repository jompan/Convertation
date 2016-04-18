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
    var weightUnits2 : NSDictionary!
    var timeUnits3 : NSDictionary!
    var heatUnits4 : NSDictionary!
    var speedUnits5 : NSDictionary!
    var bitUnits6 : NSDictionary!
    
    var tempKeys : NSArray!
    var lengthKeys1 : NSArray!
    var weightKeys2 : NSArray!
    var timeKeys3 : NSArray!
    var heatKeys4 : NSArray!
    var speedKeys5 : NSArray!
    var bitKeys6 : NSArray!


    

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
        let filePath3 = appBundle.pathForResource("timeList", ofType: "plist")!
        let filePath4 = appBundle.pathForResource("heatList", ofType: "plist")!
        let filePath5 = appBundle.pathForResource("speedList", ofType: "plist")!
        let filePath6 = appBundle.pathForResource("bitList", ofType: "plist")!




        //load the contents of the file into the dictionary
        tempUnits = NSDictionary(contentsOfFile: filePath1)
        lengthUnits1 = NSDictionary(contentsOfFile: filePath1)
        weightUnits2 = NSDictionary(contentsOfFile: filePath2)
        timeUnits3 = NSDictionary(contentsOfFile: filePath3)
        heatUnits4 = NSDictionary(contentsOfFile: filePath4)
        speedUnits5 = NSDictionary(contentsOfFile: filePath5)
        bitUnits6 = NSDictionary(contentsOfFile: filePath6)



        
        //Initiailze the keys with the names of the units
        tempKeys = lengthUnits1.allKeys as NSArray
        lengthKeys1 = lengthUnits1.allKeys as NSArray
        weightKeys2 = weightUnits2.allKeys as NSArray
        timeKeys3 = timeUnits3.allKeys as NSArray
        heatKeys4 = heatUnits4.allKeys as NSArray
        speedKeys5 = speedUnits5.allKeys as NSArray
        bitKeys6 = bitUnits6.allKeys as NSArray




        //Sort the keys in alphabetical in ascending order
        tempKeys = lengthKeys1.sort(sortKeys)
        lengthKeys1 = lengthKeys1.sort(sortKeys)
        weightKeys2 = weightKeys2.sort(sortKeys)
        timeKeys3 = timeKeys3.sort(sortKeys)
        heatKeys4 = heatKeys4.sort(sortKeys)
        speedKeys5 = speedKeys5.sort(sortKeys)
        bitKeys6 = bitKeys6.sort(sortKeys)



        
        
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
        tempKeys = weightKeys2
        tempUnits = weightUnits2
        pickerLength = weightKeys2.count
        
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]
    }

    @IBAction func timeButton(sender: AnyObject) {
        
        tempKeys = timeKeys3
        tempUnits = timeUnits3
        pickerLength = timeKeys3.count
        
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]
    }
    @IBAction func heatButton(sender: AnyObject) {
        tempKeys = heatKeys4
        tempUnits = heatUnits4
        pickerLength = heatKeys4.count
        
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]

    }
    
    @IBAction func speedButton(sender: AnyObject) {
        tempKeys = speedKeys5
        tempUnits = speedUnits5
        pickerLength = speedKeys5.count
        
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]
    }
    
    @IBAction func bitButton(sender: AnyObject) {
        tempKeys = bitKeys6
        tempUnits = bitUnits6
        pickerLength = bitKeys6.count
        
        
        [self.pvUnitTo .reloadAllComponents()]
        [self.pvUnitFrom .reloadAllComponents()]
    }
    
}

