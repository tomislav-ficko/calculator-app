//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Tomislav Ficko on 28/03/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var entryField: UILabel!
    
    var currentEntry = "0" //Representation of the entry field, for updating the entryField view
    
    
    @IBAction func resultButton(_ sender: UIButton) {
        var expressionElements: [String] = [] //backwards ordered, first element was last in entry field
        var currentElement = ""
        var lastChar = ""
        
        // Parsing expression
        lastChar = String(currentEntry.suffix(1))
        while lastChar != "" {
            if isOperator(char: lastChar) {
                expressionElements.append(lastChar)
                currentEntry = deleteLastChar(string: currentEntry)
                lastChar = getLastChar(string: currentEntry)
                continue
            }
            
            currentElement = lastChar + currentElement
            currentEntry = deleteLastChar(string: currentEntry)
            lastChar = getLastChar(string: currentEntry)
            if isOperator(char: lastChar) {
                expressionElements.append(currentElement)
            }
        }
        
        // Calculating expression
        expressionElements = expressionElements.reversed()
        currentEntry = calculateResult(array: expressionElements)
        
    }
    func calculateResult (array: [String]) -> String {
        for (index, element) in array.enumerated() {
            if element == "×" || element == "÷" {
                let num1 = Float(array[index - 1])!
                let num2 = Float(array[index + 1])!
                var result = calculate(firstNumber: num1, secondNumber: num2, operation: element)
            }
        }
        //TODO
        return ""
    }
    func calculate(firstNumber: Float, secondNumber: Float, operation: String) -> String {
        if operation == "×" {
            return String(firstNumber * secondNumber)
        } else if operation == "÷" {
            if secondNumber == Float(0) {
                return "Cannot divide by 0!"
            }
            return String(firstNumber / secondNumber)
        } else if operation == "+" {
            return String(firstNumber + secondNumber)
        } else {
            return String(firstNumber - secondNumber)
        }
    }
    func getLastChar(string: String) -> String {
        return String(string.suffix(1))
    }
    func deleteLastChar(string: String) -> String {
        let length = string.count
        return String(string.prefix(length - 1))
    }
//    struct ParseHelper {
//        var startingString = ""
//        var expressionElements: [String] = []
//
//    }
    func isDivisionWithZero(dividend: Float, divisor: Float) -> Bool {
        if divisor == Float(0) {
            return true
        }
        return false
    }
    @IBAction func deleteSwipe(_ sender: UISwipeGestureRecognizer) {
        deleteLastChars(numberOfChars: 1)
        printString()
    }
    @IBAction func percentButton(_ sender: UIButton) {
        var currentEntryDuplicate = currentEntry
        var numberAsString = ""
        
        //TODO need to implement this as a new function which would retrieve chars of the string on which it is called
        // (e.g. currentEntryDuplicate.getLastChars(1))
        var lastChar = String(currentEntryDuplicate.suffix(1))
        
        if !isOperator(char: lastChar) {
            repeat {
                numberAsString = lastChar + numberAsString
                
                //TODO need to implement this as a new function which would delete chars of the string on which it is called
                // (e.g. currentEntryDuplicate.deleteLastChars(1))
                let length = currentEntryDuplicate.count
                currentEntryDuplicate = String(currentEntryDuplicate.prefix(length - 1))
                
                lastChar = String(currentEntryDuplicate.suffix(1))
            } while lastChar != "" && !isOperator(char: lastChar) // Repeat until we come across an operator or to the beginning of the string
            
            // At this point, the number has been removed from currentEntryDuplicate, which means that the new number can just be concatenated
            
            if let number = Float(numberAsString) {
                let result = number / 100
                currentEntryDuplicate = currentEntryDuplicate + String(result)
                currentEntry = currentEntryDuplicate
                printString()
            } else {
                print("ERROR: An error occurred while calculating the percentage, the last number couldn't be cast as Float.")
            }
        }
    }
    @IBAction func posNegButton(_ sender: UIButton) {
        if currentEntry.prefix(1) == "-" {
            removeMinus()
        }
        else {
            addMinus()
        }
        printString()
    }
    @IBAction func clearButton(_ sender: UIButton) {
        currentEntry = "0"
        printString()
    }
    
    
    func printString() {
        entryField.text = currentEntry
    }
    func removeMinus() {
        let stringLength = currentEntry.count
        currentEntry = String(currentEntry.suffix(stringLength - 1))
    }
    func addMinus() {
        currentEntry = "-" + currentEntry
    }
    func addCharAndPrint(char: String) {
        currentEntry = currentEntry + char
        printString()
    }
    func getLastChars(numberOfChars: Int) -> String {
        return String(currentEntry.suffix(numberOfChars))
    }
    func deleteLastChars(numberOfChars: Int) { //TODO change to accept string and number of chars, return finished string
        let stringLength = currentEntry.count
        currentEntry = String(currentEntry.prefix(stringLength - numberOfChars))
    }
    func deleteLastCharIfOperator() { //TODO change to accept string, return finished string
        let lastChar = String(currentEntry.suffix(1))
        if isOperator(char: lastChar) {
            deleteLastChars(numberOfChars: 1)
        }
    }
    func isOperator(char: String) -> Bool {
        let operators = ["÷", "×", "-", "+"]
        for operatorChar in operators {
            if char == operatorChar {
                return true
            }
        }
        return false
    }
    func addOperatorAndPrint(char: String) {
        deleteLastCharIfOperator()
        addCharAndPrint(char: char)
    }
    func addNumberAndPrint(char: String) {
        if currentEntry.count == 1 && isLastCharZero() {
            deleteLastChars(numberOfChars: 1)
        }
        addCharAndPrint(char: char)
    }
    func isLastCharZero() -> Bool {
        if String(currentEntry.suffix(1)) == "0" {
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
        if currentEntry.count == 1 && isLastCharZero() {
            return
        }
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
