//
//  ViewController.swift
//  Convertation
//
//  Created by Joel Kronman on 2016-04-14.
//  Copyright © 2016 Joel Kronman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var units : NSDictionary!
    var keys : NSArray!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //1. get a refernce to the app bundle
        let appBundle = NSBundle.mainBundle()
        //2.get a reference to the path of the file that contains the unit
        let filePath = appBundle.pathForResource("unitsList", ofType: "plist")!
        //load the contents of the file into the dictionary
        units = NSDictionary(contentsOfFile: filePath)
        //Initiailze the keys with the names of the units
        keys = units.allKeys as NSArray
        //Sort the keys in alphabetical in ascending order
        keys = keys.sort(sortKeys)
    }
    
    func sortKeys(first: AnyObject, second: AnyObject) -> Bool {
        let firstKey = first as! String
        let secondKey = second as! String
        return firstKey.caseInsensitiveCompare(secondKey) == NSComparisonResult.OrderedAscending
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = keys.objectAtIndex(row) as! String
        
        return title
    }
    
}

