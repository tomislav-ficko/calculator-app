//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Tomislav Ficko on 28/03/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var entryField: UILabel!
    
    var currentState: Float = 0 //Representation of the entry field, for calculation
    var currentString: String = "0" //Representation of the entry field, for updating the entryField view


    @IBAction func deleteSwipe(_ sender: UISwipeGestureRecognizer) {
    }
    @IBAction func percentButton(_ sender: UIButton) {
    }
    @IBAction func posNegButton(_ sender: UIButton) {
        currentState = -1 * currentState
        
        if(currentString.prefix(1) == "-") {
            let stringLength = currentString.count
            currentString = String(currentString.suffix(stringLength - 1)) //Removing the minus in front of the whole string
        }
        else {
            currentString = "-" + currentString
        }
        
        entryField.text = currentString
    }
    @IBAction func clearButton(_ sender: UIButton) {
        currentState = 0
        currentString = "0"
        entryField.text = currentString
    }
    @IBAction func divideButton(_ sender: UIButton) {
    }
    @IBAction func multiplyButton(_ sender: UIButton) {
    }
    @IBAction func subtractButton(_ sender: UIButton) {
    }
    @IBAction func addButton(_ sender: UIButton) {
    }
    @IBAction func resultButton(_ sender: UIButton) {
    }
    
    @IBAction func commaButton(_ sender: UIButton) {
    }
    @IBAction func zeroButton(_ sender: UIButton) {
    }
    @IBAction func oneButton(_ sender: UIButton) {
    }
    @IBAction func twoButton(_ sender: UIButton) {
    }
    @IBAction func threeButton(_ sender: UIButton) {
    }
    @IBAction func fourButton(_ sender: UIButton) {
    }
    @IBAction func fiveButton(_ sender: UIButton) {
    }
    @IBAction func sixButton(_ sender: UIButton) {
    }
    @IBAction func sevenButton(_ sender: UIButton) {
    }
    @IBAction func eightButton(_ sender: UIButton) {
    }
    @IBAction func nineButton(_ sender: UIButton) {
    }
    
}
