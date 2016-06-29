//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mohammed Huraib on 6/28/16.
//  Copyright © 2016 Mohammed Huraib. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    
    // Outlets
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var devideButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    // Properties
    
    var btnSound: AVAudioPlayer!
    var buttonValueArray : [UIButton] = []
    var firstEnteredValue : Double = 0.0
    var secondEnteredValue : Double = 0.0
    var result : Double = 0.0
    var operationButtonPressed : Bool = false
    var equalButtonPressed : Bool = true
    var numberPressedAfterOperation : Bool = false
    var numberPressedAfterEqual : Bool = false
    var currentOperationButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonValueArray.append(zeroButton)
        buttonValueArray.append(oneButton)
        buttonValueArray.append(twoButton)
        buttonValueArray.append(threeButton)
        buttonValueArray.append(fourButton)
        buttonValueArray.append(fiveButton)
        buttonValueArray.append(sixButton)
        buttonValueArray.append(sevenButton)
        buttonValueArray.append(eightButton)
        buttonValueArray.append(nineButton)
        
        counterLabel.text="0"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        for x in 0 ..< buttonValueArray.count
        {
            if(sender==buttonValueArray[x])
            {
                if(operationButtonPressed)
                {
                    numberPressedAfterOperation = true
                    counterLabel.text = "\(x)"
                    operationButtonPressed=false
                }else{
                counterLabel.text =  counterLabel.text! + "\(x)"
                    numberPressedAfterOperation = false
                }
                
                if equalButtonPressed
                {
                    counterLabel.text = "\(x)"
                    numberPressedAfterEqual = true
                }else{
                    numberPressedAfterEqual = false
                }
            }
        }
        
        
    }
    
   
    @IBAction func equalsPressed(sender: UIButton) {
        
        playSound()
        
        if !equalButtonPressed
        {
            secondEnteredValue = Double(counterLabel.text!)!
        }
        
        if !numberPressedAfterEqual
        {
            calculateResult()
        }
        
        operationButtonPressed=false
        equalButtonPressed = true
        numberPressedAfterOperation = false
       
        
    }

    @IBAction func operationPressed (sender: UIButton){
        
        playSound()
        if numberPressedAfterOperation
        {
            secondEnteredValue = Double(counterLabel.text!)!
            calculateResult()
        }
        
        firstEnteredValue = Double(counterLabel.text!)!
        currentOperationButton = sender
        operationButtonPressed = true
        equalButtonPressed = false
        numberPressedAfterOperation = false
        
    }
    
    func multiply(firstValue : Double, secondValue : Double)->Double {
        return firstValue * secondValue
    }
    
    func devide(firstValue : Double, secondValue : Double)->Double {
        return firstValue / secondValue
    }
    
    func subtract(firstValue : Double, secondValue : Double)->Double {
        return firstValue - secondValue
    }
    
    func add(firstValue : Double, secondValue : Double)->Double {
        return firstValue + secondValue
    }
    
    func playSound (){
        btnSound.play()
    }
    
    func calculateResult(){
        
        if currentOperationButton == multiplyButton
        {
            result = multiply(firstEnteredValue, secondValue: secondEnteredValue)
            
        }else if currentOperationButton == devideButton
        {
            result = devide(firstEnteredValue, secondValue: secondEnteredValue)
            
        }else if currentOperationButton == subtractButton
        {
            result = subtract(firstEnteredValue, secondValue: secondEnteredValue)
            
        }else
        {
            result = add(firstEnteredValue, secondValue: secondEnteredValue)
        }
        
        firstEnteredValue = result
        counterLabel.text = "\(result)"
    }
   
    
    
}

