//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //fecha automaticamente o teclado
        billTextField.endEditing(true)
        
        //todos como false para ficar desmarcado.
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //sender para mandar qual está selecionado e fica como true para selecionar.
        sender.isSelected = true
        
        // Obtenha o título atual do botão que foi pressionado.
        // zeroPctButton
        // tenPctButton
        // twenyPctButton
        let buttonTitle = sender.currentTitle!
        
        //Remova o último caractere (%) do título e transforme-o novamente em uma String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Transforme a String em um Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //Divida a porcentagem expressa de 100 em um decimal, por exemplo. 10 se torna 0,1
        tip = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        //Defina a propriedade numberOfPeople como o valor do stepper como um número inteiro.
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //Pega o texto que o usuário digitou no billTextField
        let bill = billTextField.text!
        
        //Se o texto não for uma String vazia ""
        if bill != "" {
            //billTotal vai ser convertido em um numero flutuante
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        //Em Main.storyboard há uma transição entre CalculatorVC e ResultsVC com o identificador "goToResults".
        //Esta linha aciona o segue para acontecer.
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Se o segue atualmente acionado for o segue "goToResults".
        if segue.identifier == "goToResults" {
            
            //Receba a instância do VC de destino e digite cast para um ResultViewController.
            let destinationVC = segue.destination as! ResultsViewController
            
            //Define as propriedades do destino ResultsViewController.
            destinationVC.result = finalResult
            destinationVC.tip = Int (tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}
