//
//  SettingsVCTableViewController.swift
//  Tips
//
//  Created by Atakishiyev Orazdurdy on 3/17/16.
//  Copyright © 2016 orazz. All rights reserved.
//

import UIKit

class SettingsVCTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tipPercentages = [String:Double]()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let defPercentages = defaults.dictionaryForKey("defPercentages") as? [String:Double] {
            tipPercentages = defPercentages
        }else{
            tipPercentages = ["0":0.18, "1":0.2, "2":0.22]
            defaults.setObject(tipPercentages, forKey: "defPercentages")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
        let value = tipPercentages["\(indexPath.row)"]
        cell.percentField.tag = indexPath.row
        cell.percentField.text = String(format: "%.f", value!*100)

        // Configure the cell...

        return cell
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

class Cell: UITableViewCell, UITextFieldDelegate  {
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var percentField: UITextField!
    
    var valueChanged: (Void -> Void)?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        
        valueChanged?()
    }
    
    /// Dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func percentageChanged(sender: UITextField) {
        if var defPercentages = defaults.dictionaryForKey("defPercentages") as? [String:Double] {
            switch sender.tag {
                case 0: defPercentages["0"] = (sender.text! as NSString).doubleValue/100
                case 1: defPercentages["1"] = (sender.text! as NSString).doubleValue/100
                case 2: defPercentages["2"] = (sender.text! as NSString).doubleValue/100
            default: break
            }
            defaults.setObject(defPercentages, forKey: "defPercentages")
        }
    }
}
