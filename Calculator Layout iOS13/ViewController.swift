//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labell: UILabel!
    var expressionArray = [String]()
    var groupNumber = String()
    var usedEqualt = 0
    
    
    
    func addNumber(_ numberString: String) {
        if usedEqualt == 1 || labell.text == "0" {
            
            if numberString == "."{
                let ceroPunto = "0" + numberString
                print(ceroPunto)
                groupNumber = ceroPunto
                labell.text = ceroPunto
                print("here")
            } else {
                labell.text = numberString
                groupNumber = numberString
                usedEqualt = 0
            }
           
        } else  {
            labell.text! += numberString
            groupNumber += numberString
            
        }
    }
    // number
    
    @IBAction func reset(_ sender: UIButton) {
        labell.text = "0"
        expressionArray.removeAll()
        groupNumber = ""
        usedEqualt = 0
    }
    @IBAction func cero(_ sender: UIButton) {addNumber("0")}
    @IBAction func one(_ sender: UIButton) {addNumber("1")}
    @IBAction func two(_ sender: UIButton) {addNumber("2")}
    @IBAction func three(_ sender: UIButton) {addNumber("3")}
    @IBAction func four(_ sender: UIButton) {addNumber("4")}
    @IBAction func five(_ sender: UIButton) {addNumber("5")}
    @IBAction func six(_ sender: UIButton) {addNumber("6")}
    @IBAction func seven(_ sender: UIButton) {addNumber("7")}
    @IBAction func eight(_ sender: UIButton) {addNumber("8")}
    @IBAction func nine(_ sender: UIButton) {addNumber("9")}
    @IBAction func punto(_ sender: UIButton) {
        if !groupNumber.contains(".") {
            addNumber(".")}
    }
    // operater
    
    @IBAction func equal(_ sender: UIButton) {
        expressionArray.append(groupNumber)
        let resultString = calcularExpresion()
        expressionArray.removeAll()
        
        labell.text = resultString
        groupNumber = resultString
        usedEqualt = 1
    }
    func calcularResultado(_ array: [String], _ simbolo: String) -> [String] {
        var newArray = array
        
        for index in newArray.indices {
            if newArray[index] == simbolo {
                guard let num1 = Float(newArray[index - 1]), let num2 = Float(newArray[index + 1]) else {
                    continue
                }
                let resultado: Float
                switch simbolo {
                    
                case "*":
                    resultado = num1 * num2
                case "/":
                    resultado = num1 / num2
                default:
                    fatalError("Operador no válido: \(simbolo)")
                }
                newArray[index - 1] = String(resultado)
                newArray.remove(at: index)
                newArray.remove(at: index)
                return calcularResultado(newArray, simbolo)
            }
        }
        return newArray
        
    }
    
    func calcularExpresion() -> String {
        var total = ""
        var original = expressionArray
        
        if original.contains("*") {
            original = calcularResultado(original, "*")
        }
        if original.contains("%") {
            original = calcularResultado(original, "%")
        }
        if original.contains("/") {
            original = calcularResultado(original, "/")
        }
        if original.contains("+") || original.contains("-") {
            total = addAndSub(original)
            return total
        }
        
        if let resultado = original.first {
            total = resultado
        }
    
        
        return total
    }
    
    func addAndSub(_ arraySubAdd: [String]) -> String {
        let arraySubAdd = arraySubAdd
        var result: Float = 0.0
        
        if arraySubAdd.first == "-" {
            result -= convertStringInt(arraySubAdd[1])
        } else {
            result += convertStringInt(arraySubAdd[0])
        }
        
        for indice in stride(from: 1, to: arraySubAdd.count, by: 1){
            if arraySubAdd[indice] == "-" {
                result -= convertStringInt(arraySubAdd[indice+1])
            }
            if arraySubAdd[indice] == "+" {
                result += convertStringInt(arraySubAdd[indice+1])
            }
        }
        func convertStringInt(_ numberString: String) -> Float {
            guard let numberInt = Float(numberString) else {
                print("is dont number")
                return 0
            }
            return numberInt
        }
        return String(result)
    }
    
    
    
    
    
    
    
    
    
    
    
    func operadores(_ operador: String){
        if !groupNumber.isEmpty {
            expressionArray.append(groupNumber)
        }
        
        if expressionArray.count % 2 != 0 {
            labell.text! += operador
            expressionArray.append(operador)
            groupNumber = ""
            usedEqualt = 0
            
        }

}
    
    
    
    @IBAction func plus(_ sender: UIButton) {operadores("+")}
    @IBAction func minus(_ sender: UIButton) {operadores("-")}
    @IBAction func time(_ sender: UIButton) {operadores("*")}
    @IBAction func divide(_ sender: UIButton) {operadores("/")}
    
    @IBAction func plusMnus(_ sender: UIButton) {
        let arrayOperator = ["*", "/", "+", "-", "%"]
        if !expressionArray.contains(where: { arrayOperator.contains($0) }) {
            print(groupNumber)
            if let floatValue = Float(groupNumber){
                var intNumber = Int(floatValue)
                intNumber *= -1
                labell.text = String(intNumber)
                groupNumber = String(intNumber)
            }
        }
    }
    func calcularOperacion(_ num1: Int, _ operador: String, _ num2: Int) -> Int {
        switch operador {
        case "*":
            return num1 * num2
        case "/":
            return num1 / num2
        case "%":
            return (num1 * num2) / 100 // Calcula el porcentaje
        default:
            fatalError("Operador no válido: \(operador)")
        }
    }

  
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

