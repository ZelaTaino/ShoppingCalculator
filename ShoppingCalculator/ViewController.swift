//
//  ViewController.swift
//  ShoppingCalculator
//
//  Created by Glizela Taino on 1/25/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var originalPriceTextField: UITextField!
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var discountPriceTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var savedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originalPriceTextField.becomeFirstResponder()
        
        originalPriceTextField.delegate = self
        discountPriceTextField.delegate = self
        taxTextField.delegate = self
        
    }
    
    @IBAction func clearTextFields(_ sender: UIButton) {
        
        originalPriceTextField.text = ""
        discountPriceTextField.text = ""
        taxTextField.text = ""
        finalPriceLabel.text = "0.00"
        savedLabel.text = "0.00"
        
    }

    @IBAction func textChanged(_ sender: UITextField) {
        var originalPriceValue = "0"
        var discountValue = "0"
        var taxValue = "0"
        
        if let price = originalPriceTextField.text, isValid(input: price){
            originalPriceValue = price
        }
        
        if let discount = discountPriceTextField.text, isValid(input: discount){
            discountValue = discount
        }
        
        if let tax = taxTextField.text, isValid(input: tax){
            taxValue = tax
        }
        
        
        let finalPrice = calculate(originalPrice: Double(originalPriceValue)!, discount: Double(discountValue)!, tax: Double(taxValue)!)
        
        finalPriceLabel.text = "\(String(format: "%.2f", finalPrice))"
        
        
        var savedValue = Double(originalPriceValue)! - finalPrice
        
        if savedValue < 0 {
            savedValue = 0
        }
        
        savedLabel.text = "\(String(format: "%.2f", savedValue))"
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let string_list = Array(textField.text!.characters)
        var num_decimals = 0
        for letter in string_list{
            if letter == "."{
                num_decimals += 1
            }
        }
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            let letters = Array(textField.text!.characters)
            let num_letters = letters.count
            if num_letters > 8{
                return false
            }
            
            if num_decimals == 1 {
                //if last two numbers do not contain a decimal return true
                let last_letter = letters[num_letters - 1]
                let second_last_letter = letters[num_letters - 2]
                
                if last_letter == "." || second_last_letter == "." {
                    return true
                }else{
                    return false
                }
            }
            return true
            
        case ".":
            if num_decimals == 1{
                return false
            }else{
                return true
            }
        default:
            let string_list = Array(string.characters)
            if string_list.count == 0{
                return true
            }
            
            return false
        }
        
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
        finalPrice = finalPrice + ((tax/100) * finalPrice)
        
        return finalPrice
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

