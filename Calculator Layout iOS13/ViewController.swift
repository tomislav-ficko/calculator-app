//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Tomislav Ficko on 28/03/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var entryField: UILabel!
    
    var result: Float = 0
    var currentString: String = "0" //Representation of the entry field, for updating the entryField view
    
    
    @IBAction func resultButton(_ sender: UIButton) {
        //TODO calculate whole string and print result
    }
    @IBAction func deleteSwipe(_ sender: UISwipeGestureRecognizer) {
        deleteLastChar()
        printString()
    }
    @IBAction func percentButton(_ sender: UIButton) {
        //TODO take last number in currentString (look back for the last number all the way to the beginning or to the first previous operator, remember the position of the operator), divide it by 100 and replace (print) the number with the new value
    }
    @IBAction func posNegButton(_ sender: UIButton) {
        if(currentString.prefix(1) == "-") {
            removeMinus()
        }
        else {
            addMinus()
        }
        printString()
    }
    @IBAction func clearButton(_ sender: UIButton) {
        result = 0
        currentString = "0"
        printString()
    }
    
    
    func printString() {
        entryField.text = currentString
    }
    func removeMinus() {
        let stringLength = currentString.count
        currentString = String(currentString.suffix(stringLength - 1))
    }
    func addMinus() {
        currentString = "-" + currentString
    }
    func addCharAndPrint(char: String) {
        currentString = currentString + char
        printString()
    }
    func deleteLastChar() {
        let stringLength = currentString.count
        currentString = String(currentString.prefix(stringLength - 1))
    }
    func deleteLastCharIfOperator() {
        let operators = ["÷", "×", "-", "+"]
        let lastChar = currentString.suffix(1)
        for char in operators {
            if(char == lastChar) {
                deleteLastChar()
                return
            }
        }
    }
    func addOperatorAndPrint(char: String) {
        deleteLastCharIfOperator()
        addCharAndPrint(char: char)
    }
    func addNumberAndPrint(char: String) {
        if(currentString.count == 1 && isCharZero()){
            deleteLastChar()
        }
        addCharAndPrint(char: char)
    }
    func isCharZero() -> Bool {
        if(String(currentString.suffix(1)) == "0") {
            return true
        }
        return false
    }
    
    
    @IBAction func divideButton(_ sender: UIButton) {
        addOperatorAndPrint(char: "÷")
    }
    @IBAction func multiplyButton(_ sender: UIButton) {
        addOperatorAndPrint(char: "×")
    }
    @IBAction func subtractButton(_ sender: UIButton) {
        addOperatorAndPrint(char: "-")
    }
    @IBAction func addButton(_ sender: UIButton) {
        addOperatorAndPrint(char: "+")
    }
    @IBAction func dotButton(_ sender: UIButton) {
        addCharAndPrint(char: ".")
    }
    @IBAction func zeroButton(_ sender: UIButton) {
        addCharAndPrint(char: "0")
    }
    @IBAction func oneButton(_ sender: UIButton) {
        addNumberAndPrint(char: "1")
    }
    @IBAction func twoButton(_ sender: UIButton) {
        addNumberAndPrint(char: "2")
    }
    @IBAction func threeButton(_ sender: UIButton) {
        addNumberAndPrint(char: "3")
    }
    @IBAction func fourButton(_ sender: UIButton) {
        addNumberAndPrint(char: "4")
    }
    @IBAction func fiveButton(_ sender: UIButton) {
        addNumberAndPrint(char: "5")
    }
    @IBAction func sixButton(_ sender: UIButton) {
        addNumberAndPrint(char: "6")
    }
    @IBAction func sevenButton(_ sender: UIButton) {
        addNumberAndPrint(char: "7")
    }
    @IBAction func eightButton(_ sender: UIButton) {
        addNumberAndPrint(char: "8")
    }
    @IBAction func nineButton(_ sender: UIButton) {
        addNumberAndPrint(char: "9")
    }
    
}
