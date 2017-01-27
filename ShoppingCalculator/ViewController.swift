//
//  ViewController.swift
//  ShoppingCalculator
//
//  Created by Glizela Taino on 1/25/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var originalPriceTextField: UITextField!
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var discountPriceTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func textChanged(_ sender: UITextField) {
        var originalPriceValue = "0"
        var discountValue = "0"
        var taxValue = "0"
        
        if let price = originalPriceTextField.text, isValid(input: price){
            originalPriceValue = price
            if let discount = discountPriceTextField.text, isValid(input: discount){
                discountValue = discount
                if let tax = taxTextField.text, isValid(input: tax){
                    taxValue = tax
                    
                }
            }
        }
        
        let finalPrice = calculate(originalPrice: Double(originalPriceValue)!, discount: Double(discountValue)!, tax: Double(taxValue)!)
        
        finalPriceLabel.text = "\(finalPrice)"
        
    }
    
    func isValid(input: String) -> Bool {
        //empty, zero (who cares if it's zero), negative, not numbers
        
        let inputValue = Double(input)
        if inputValue == nil{
            return false
        }
        
        return true
    }
    
    
    func calculate(originalPrice: Double, discount: Double, tax: Double) -> Double {
        
        var finalPrice = originalPrice - ((discount/100) * originalPrice)
        finalPrice = originalPrice + ((tax/100) * originalPrice)
        
        return finalPrice
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

