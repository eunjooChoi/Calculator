//
//  ViewController.swift
//  Calculator
//
//  Created by USER on 2018. 7. 5..
//  Copyright © 2018년 Eunjoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // create property. !를 쓰는건 값이 없을리 없다고 확신하기 때문인가?
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        
        var sum: String = ""
        if let digit = sender.currentTitle {
            //print("touched \(digit).")
            sum = digit
        }
        if userIsInTheMiddleOfTyping {
            let textCurrentlyDisplay = display.text!
            display.text = textCurrentlyDisplay + sum
            
        }else{
            display.text = sum
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    private var displayValue: Double {
        get{
            // text가 없을수도 있기 때문에 text!
            // lable에 영어가 들어올 경우에는 double로 바꿀 수 없기 때문에 (display.text!)!
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalcuatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setoperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

