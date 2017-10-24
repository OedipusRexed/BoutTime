//
//  ViewController.swift
//  Bout Time
//
//  Created by Aaron Revalee on 10/16/17.
//  Copyright © 2017 OedipusRexed. All rights reserved.
//

import UIKit
import Foundation
import GameKit

class ViewController: UIViewController {
    
    @IBOutlet weak var FirstEventLabel: UILabel!
    @IBOutlet weak var FirstDownButton: UIButton!
    @IBOutlet weak var SecondEventLabel: UILabel!
    @IBOutlet weak var SecondUpButton: UIButton!
    @IBOutlet weak var SecondDownButton: UIButton!
    @IBOutlet weak var ThirdEventLabel: UILabel!
    @IBOutlet weak var ThirdUpButton: UIButton!
    @IBOutlet weak var ThirdDownButton: UIButton!
    @IBOutlet weak var StartGameButton: UIButton!
    @IBOutlet weak var FourthEventLabel: UILabel!
    @IBOutlet weak var FourthUpButton: UIButton!
    @IBOutlet weak var NextRoundSuccessButton: UIButton!
    @IBOutlet weak var NextRoundFailButton: UIButton!
    @IBOutlet weak var CountdownTimer: UILabel!
    @IBOutlet weak var TapOrShakeLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        CountdownTimer.text = String(60)
        
        FirstEventLabel.isHidden = true
        SecondEventLabel.isHidden = true
        ThirdEventLabel.isHidden = true
        FourthEventLabel.isHidden = true
        StartGameButton.isHidden = false
        FirstDownButton.isHidden = true
        SecondDownButton.isHidden = true
        SecondUpButton.isHidden = true
        ThirdDownButton.isHidden = true
        ThirdUpButton.isHidden = true
        FourthUpButton.isHidden = true
        CountdownTimer.isHidden = true
        TapOrShakeLabel.isHidden = true
        NextRoundSuccessButton.isHidden = true
        NextRoundFailButton.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var event: [EventData]
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let eventData = try PlistConverter.arrayFromList(fromFile: "EventData", ofType: "plist")
            let eventArray = try EventUnpacker.eventfromArray(array: eventData)
            
            self.event = eventArray
        } catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }

    
    // MARK: Timer Functionality
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func updateCounter() {
        if seconds != 0 {
            seconds -= 1
            CountdownTimer.text = "\(seconds)" } else {
                endGame()
                checkAnswer()
        }
    }

    func endGame() {
        timer.invalidate()
        seconds = 60
        isTimerRunning = false
        CountdownTimer.text = "\(seconds)"
    }

    func checkAnswer() {
        // Check Answer functionality *Need to Build*
        
    }
    
    func populateEvents() {
        
    }
    
    
    @IBAction func StartGame(_ sender: UIButton) {
        
        FirstEventLabel.isHidden = false
        SecondEventLabel.isHidden = false
        ThirdEventLabel.isHidden = false
        FourthEventLabel.isHidden = false
        StartGameButton.isHidden = true
        FirstDownButton.isHidden = false
        SecondDownButton.isHidden = false
        SecondUpButton.isHidden = false
        ThirdDownButton.isHidden = false
        ThirdUpButton.isHidden = false
        FourthUpButton.isHidden = false
        CountdownTimer.isHidden = false
        TapOrShakeLabel.isHidden = false
        NextRoundSuccessButton.isHidden = true
        NextRoundFailButton.isHidden = true
        
        TapOrShakeLabel.text = "Shake To Complete!"
        
        startTimer()

    }

    
// functions for event lists
    
    func initialEvents () { initialEventArray.append(contentsOf: event)
    }
    
    func randomizeEvent () { indexOfSelectedEvent = GKRandomSource.sharedRandom().nextInt(upperBound: initialEventArray.count)
    }
    
    func transferUsedEvent() {
        usedEventArray.append(initialEventArray[indexOfSelectedEvent])
        initialEventArray.remove(at: indexOfSelectedEvent)
    }
    
    
    
    
    
    
    
}









