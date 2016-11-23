//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Rafael Nicoleti on 17/11/16.
//  Copyright © 2016 Rafael Nicoleti. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundUrl = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer.init(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func buttonNumberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        
        outputLbl.text = runningNumber
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    @IBAction func onPressedDivide(_ sender: Any) {
        processOperation(operation: Operation.Divide)
    }
    @IBAction func onPressedMultiply(_ sender: Any) {
        processOperation(operation: Operation.Multiply)
    }
    @IBOutlet weak var onPressedSubtract: UIButton!
    
    @IBAction func onPressedSubtractt(_ sender: Any) {
        processOperation(operation: Operation.Subtract)
    }
    @IBAction func onPressedAdd(_ sender: Any) {
        processOperation(operation: Operation.Add)
    }
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            //A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

