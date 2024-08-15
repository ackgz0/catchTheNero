//
//  ViewController.swift
//  catchTheNero
//
//  Created by eray on 14.08.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeRemaining: UILabel!
    
    @IBOutlet weak var yourScore: UILabel!
    
    @IBOutlet weak var highestScore: UILabel!
    
    @IBOutlet weak var nero1: UIImageView!
    
    @IBOutlet weak var nero2: UIImageView!
    
    @IBOutlet weak var nero3: UIImageView!
    
    @IBOutlet weak var nero4: UIImageView!
    
    @IBOutlet weak var nero5: UIImageView!
    
    @IBOutlet weak var nero6: UIImageView!
    
    @IBOutlet weak var nero7: UIImageView!
    
    @IBOutlet weak var nero8: UIImageView!
    
    @IBOutlet weak var nero9: UIImageView!
    
    
    
    var timer = Timer()
    var timer2 = Timer()
    var counter = 0
    var score = 0
    var highest = 0
    var neroArray = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourScore.text = "Score: \(score)"
        
        nero1.isUserInteractionEnabled = true
        nero2.isUserInteractionEnabled = true
        nero3.isUserInteractionEnabled = true
        nero4.isUserInteractionEnabled = true
        nero5.isUserInteractionEnabled = true
        nero6.isUserInteractionEnabled = true
        nero7.isUserInteractionEnabled = true
        nero8.isUserInteractionEnabled = true
        nero9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        nero1.addGestureRecognizer(recognizer1)
        nero2.addGestureRecognizer(recognizer2)
        nero3.addGestureRecognizer(recognizer3)
        nero4.addGestureRecognizer(recognizer4)
        nero5.addGestureRecognizer(recognizer5)
        nero6.addGestureRecognizer(recognizer6)
        nero7.addGestureRecognizer(recognizer7)
        nero8.addGestureRecognizer(recognizer8)
        nero9.addGestureRecognizer(recognizer9)
        
        neroArray = [nero1, nero2, nero3, nero4, nero5, nero6, nero7, nero8, nero9]
        
        counter = 10
        
        timeRemaining.text = "Time Remaining: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
        
        timer2 = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideNero), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideNero() {
        
        for nero in neroArray {
            nero.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(neroArray.count - 1)))
        
        neroArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        yourScore.text = "Score: \(score)"
    }
    
    @objc func decreaseTime() {
        
        counter -= 1
        timeRemaining.text = "Time Remaining: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            timer2.invalidate()
            
            for nero in neroArray {
                nero.isHidden = true
            }
            
            if score > highest {
                highest = score
                highestScore.text = "Highest score: \(score)"
            }
            
            let alert = UIAlertController(title: "Times Up!", message: "Play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                
                self.score = 0
                self.yourScore.text = "Score: \(self.score)"
                self.counter = 10
                self.timeRemaining.text = "Time remaining: \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseTime), userInfo: nil, repeats: true)
                
                self.timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideNero), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

