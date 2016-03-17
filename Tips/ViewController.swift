//
//  ViewController.swift
//  Tips
//
//  Created by Atakishiyev Orazdurdy on 3/17/16.
//  Copyright © 2016 orazz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalLabel_2: UILabel!
    @IBOutlet weak var totalLabel_3: UILabel!
    @IBOutlet weak var totalLabel_4: UILabel!
    
    @IBOutlet weak var totalBackView: UIView!
    
    @IBOutlet weak var billFieldTopConstant: NSLayoutConstraint!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPercentages = [String:Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billField.text = ""
        self.billField.placeholder = "$"
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalLabel_2.text = "$0.00"
        totalLabel_3.text = "$0.00"
        totalLabel_4.text = "$0.00"
        
        self.totalBackView.alpha = 0.0
        self.tipControl.alpha = 0.0
        self.billFieldTopConstant.constant = 80
        self.billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let defPercentages = defaults.dictionaryForKey("defPercentages") as? [String: Double] {
            tipPercentages = defPercentages
        }else{
            tipPercentages = ["0":0.18, "1":0.2, "2":0.22]
            defaults.setObject(tipPercentages, forKey: "defPercentages")
        }
        
        tipControl.setTitle(String(tipPercentages["0"]!*100) + "%", forSegmentAtIndex: 0)
        tipControl.setTitle(String(tipPercentages["1"]!*100) + "%", forSegmentAtIndex: 1)
        tipControl.setTitle(String(tipPercentages["2"]!*100) + "%", forSegmentAtIndex: 2)
        calculate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        if billField.text!.isEmpty {
            UIView.animateWithDuration(0.2, animations: {
                self.totalBackView.alpha = 0.0
                self.tipControl.alpha = 0.0
                self.billFieldTopConstant.constant = 80
            })
        }else{
            UIView.animateWithDuration(0.2, animations: {
                self.tipControl.alpha = 1.0
                self.totalBackView.alpha = 1.0
                self.billFieldTopConstant.constant = 13
            })
        }
        calculate()
    }
    
    func calculate() {
        let tipPercentage = tipPercentages["\(tipControl.selectedSegmentIndex)"]
        
        
        let billAmount = (billField.text! as NSString).doubleValue
        let tip = billAmount * tipPercentage!
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        totalLabel_2.text = String(format: "$%.2f", total/2)
        totalLabel_3.text = String(format: "$%.2f", total/3)
        totalLabel_4.text = String(format: "$%.2f", total/4)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

