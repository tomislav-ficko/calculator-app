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
    let divisionError = "Cannot divide with 0!"
    
    enum Operator: String, CaseIterable {
        case plus = "+"
        case multiply = "×"
        case minus = "-"
        case divide = "÷"
    }
    
    @IBAction func resultButton(_ sender: UIButton) {
        var expressionElements: [String] = []
        var currentElement = ""
        var lastChar = ""
        
        // Parsing expression
        lastChar = String(currentEntry.suffix(1))
        while lastChar != "" { // TODO Currently it doesn't work for negative numbers, must enable minus to be part of a number, not only an operator
            if isOperator(char: lastChar) {
                expressionElements.append(lastChar)
                currentEntry = deleteLastChar(string: currentEntry)
                lastChar = getLastChar(string: currentEntry)
                continue
            }
            
            currentElement = lastChar + currentElement
            currentEntry = deleteLastChar(string: currentEntry)
            lastChar = getLastChar(string: currentEntry)
            if isOperator(char: lastChar) || lastChar == "" {
                expressionElements.append(currentElement)
                currentElement.removeAll()
            }
        }
        
        // Calculating expression
        expressionElements = expressionElements.reversed() // Until now, the array was ordered backwards
        currentEntry = calculateResult(array: expressionElements)
        printString()
    }
    func calculateResult (array: [String]) -> String {
        var mutableArray = array
        var tempArray: [String] = []
        var currentOperatorIndex = 0
        var result = ""
        var errorFlag = false
        
        while true {
            for (index, element) in mutableArray.enumerated() { //calculate multiplication and division
                if element == Operator.multiply.rawValue || element == Operator.divide.rawValue {
                    currentOperatorIndex = index
                    let num1 = Float(array[currentOperatorIndex - 1])!
                    let num2 = Float(array[currentOperatorIndex + 1])!
                    result = calculate(firstNumber: num1, secondNumber: num2, operation: element)
                    
                    if result == divisionError {
                        mutableArray.removeAll()
                        mutableArray.append(divisionError)
                        errorFlag = true
                        break
                    }
                    
                    for (index, element) in mutableArray.enumerated() { // After calculating the result, we have to populate a new array and insert the result value instead of the previous two numbers and operator
                        if index == currentOperatorIndex - 1 || index == currentOperatorIndex {
                            continue
                        }
                        if index == currentOperatorIndex + 1 {
                            tempArray.append(result)
                            continue
                        }
                        tempArray.append(element)
                    }
                    
                    mutableArray = tempArray
                    tempArray.removeAll()
                }
                
                if element == Operator.minus.rawValue || element == Operator.plus.rawValue {
                    currentOperatorIndex = index
                    let num1 = Float(array[currentOperatorIndex - 1])!
                    let num2 = Float(array[currentOperatorIndex + 1])!
                    result = calculate(firstNumber: num1, secondNumber: num2, operation: element)
                    
                    for (index, element) in mutableArray.enumerated() { // After calculating the result, we have to populate a new array and insert the result value instead of the previous two numbers and operator
                        if index == currentOperatorIndex - 1 || index == currentOperatorIndex {
                            continue
                        }
                        if index == currentOperatorIndex + 1 {
                            tempArray.append(result)
                            continue
                        }
                        tempArray.append(element)
                    }
                    
                    mutableArray = tempArray
                    tempArray.removeAll()
                }
                
            }
            if errorFlag == true {
                break
            }
            
            if mutableArray.count == 1 {
                break // Break when we reduced the array to the final result (only one element left)
            }
        }
        
        return mutableArray[0]
    }
    func calculate(firstNumber: Float, secondNumber: Float, operation: String) -> String {
        if operation == Operator.multiply.rawValue {
            return String(firstNumber * secondNumber)
        } else if operation == Operator.divide.rawValue {
            if secondNumber == Float(0) {
                return divisionError
            }
            return String(firstNumber / secondNumber)
        } else if operation == Operator.plus.rawValue {
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
        if currentEntry.prefix(1) == Operator.minus.rawValue {
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
        currentEntry = Operator.minus.rawValue + currentEntry
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
        for operatorChar in Operator.allCases {
            if char == operatorChar.rawValue {
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
        addOperatorAndPrint(char: Operator.divide.rawValue)
    }
    @IBAction func multiplyButton(_ sender: UIButton) {
        addOperatorAndPrint(char: Operator.multiply.rawValue)
    }
    @IBAction func subtractButton(_ sender: UIButton) {
        addOperatorAndPrint(char: Operator.minus.rawValue)
    }
    @IBAction func addButton(_ sender: UIButton) {
        addOperatorAndPrint(char: Operator.plus.rawValue)
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
