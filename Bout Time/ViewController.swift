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

class ViewController: UIViewController, UIWebViewDelegate{
    
    
    @IBOutlet weak var FirstEventButton: UIButton!
    @IBOutlet weak var FirstDownButton: UIButton!
    @IBOutlet weak var SecondEventButton: UIButton!
    @IBOutlet weak var SecondUpButton: UIButton!
    @IBOutlet weak var SecondDownButton: UIButton!
    @IBOutlet weak var ThirdEventButton: UIButton!
    @IBOutlet weak var ThirdUpButton: UIButton!
    @IBOutlet weak var ThirdDownButton: UIButton!
    @IBOutlet weak var FourthEventButton: UIButton!
    @IBOutlet weak var FourthUpButton: UIButton!
    @IBOutlet weak var NextRoundSuccessButton: UIButton!
    @IBOutlet weak var NextRoundFailButton: UIButton!
    @IBOutlet weak var CountdownTimer: UILabel!
    @IBOutlet weak var TapOrShakeLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        CountdownTimer.text = String(60)
        TapOrShakeLabel.text = "Shake To Complete!"
        
        startTimer()
        assignEventLabels()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var event: [EventData]
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let eventData = try PlistConverter.arrayFromList(fromFile: "EventData", ofType: "plist")
            let eventArray = try EventUnpacker.eventFromArray(array: eventData)
            
            self.event = eventArray
        } catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }

    // MARK: Shake gesture to skip timer or show next round
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            if isTimerRunning == true {
                checkAnswer()
            } else if isTimerRunning == false {
                nextRound(UIEventSubtype.motionShake)
            }
        }
    }
    
    // MARK: Navigates to each additional view with correct link or score
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scoreSegue" {
            let scoreViewController = segue.destination as? EndGameScoreController
            if let svc = scoreViewController {
                svc.score = correctAnswers
            }
        }
        
        // Allows ScoreController to restart game when dismissed
        if let destination = segue.destination as? EndGameScoreController {
            destination.delegate = self
        }
        
        if segue.identifier == "firstWebSegue" {
            let webViewController = segue.destination as? WebController
            if let wvc = webViewController {
                wvc.clickedFirst = URL(string: firstURL)
            }
        }
        
        if segue.identifier == "secondWebSegue" {
            let webViewController = segue.destination as? WebController
            if let wvc = webViewController {
                wvc.clickedSecond = URL(string: secondURL)
            }
        }
        
        if segue.identifier == "thirdWebSegue" {
            let webViewController = segue.destination as? WebController
            if let wvc = webViewController {
                wvc.clickedThird = URL(string: thirdURL)
            }
        }
        
        if segue.identifier == "fourthWebSegue" {
            let webViewController = segue.destination as? WebController
            if let wvc = webViewController {
                wvc.clickedFourth = URL(string: fourthURL)
            }
        }
    }

    // MARK: Game navigation
    @IBAction func nextRound(_ sender: Any) {
        if initialEventArray.count >= 4 && roundsPlayed <= 6 {
            startTimer()
            showCurrentEvent()
        } else {
            restartGame()
        }
    }
    
    func reloadMainGame() {
        restartGame()
    }
    
    
    // MARK: Game Function
    func showCurrentEvent() {
        if initialEventArray.count >= 4 {
            disableButtons()
            enableArrows()
            assignEventButtons()
            TapOrShakeLabel.text = ""
            roundsPlayed += 1
        } else {
            print("Not enough events to play!")
        }
    }
    
    func calculateOrder() {
        if firstYear <= secondYear && secondYear <= thirdYear && thirdYear <= fourthYear {
            correctOrder = true
        } else {
            correctOrder = false
        }
    }
    
    func checkAnswer() {
        stopTimer()
        hideTimer()
        calculateOrder()
        enableButtons()
        disableArrows()
        
        if correctOrder == true && roundsPlayed <= 5 {
            playDingSound()
            NextRoundSuccessButton.isHidden = false
            NextRoundFailButton.isHidden = true
            TapOrShakeLabel.text = "Tap events to learn more"
            
            correctAnswers += 1
        } else if correctOrder == false && roundsPlayed <= 5 {
            playBuzzSound()
            NextRoundSuccessButton.isHidden = true
            NextRoundFailButton.isHidden = false
            TapOrShakeLabel.text = "Tap events to learn more"
            
        } else if correctOrder == true && roundsPlayed == 6 {
            playDingSound()
            correctAnswers += 1
            checkTotalScore()
            TapOrShakeLabel.text = "Tap events to learn more"
            
        } else if correctOrder == false && roundsPlayed == 6 {
            playBuzzSound()
            checkTotalScore()
            TapOrShakeLabel.text = "Tap events to learn more"
        }
    }
    
    
    func restartGame() {
        startTimer()
        roundsPlayed = 0
        correctAnswers = 0
        resetEventArray()
        showCurrentEvent()
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
    
    func stopTimer() {
        timer.invalidate()
        isTimerRunning = false
        seconds = Int(60.0)
        CountdownTimer.text = "\(seconds)"
    }
    
    func hideTimer() {
        CountdownTimer.isHidden = true
    }
    
   
    
    func assignEventButtons() {
    
        func assignTopButton() {
            randomizeEvent()
            FirstEventButton.setTitle(initialEventArray[indexOfSelectedEvent].Event, for: .normal)
            firstURL = initialEventArray[indexOfSelectedEvent].URL
            firstYear = initialEventArray[indexOfSelectedEvent].Year
            transferUsedEvent()
        }
    
        func assignMidTopButton() {
            randomizeEvent()
            SecondEventButton.setTitle(initialEventArray[indexOfSelectedEvent].Event, for: .normal)
            secondURL = initialEventArray[indexOfSelectedEvent].URL
            secondYear = initialEventArray[indexOfSelectedEvent].Year
            transferUsedEvent()
        }
        
        func assignMidBotButton() {
            randomizeEvent()
            ThirdEventButton.setTitle(initialEventArray[indexOfSelectedEvent].Event, for: .normal)
            thirdURL = initialEventArray[indexOfSelectedEvent].URL
            thirdYear = initialEventArray[indexOfSelectedEvent].Year
            transferUsedEvent()
        }
    
        func assignBottomButton() {
            randomizeEvent()
            FourthEventButton.setTitle(initialEventArray[indexOfSelectedEvent].Event, for: .normal)
            fourthURL = initialEventArray[indexOfSelectedEvent].URL
            fourthYear = initialEventArray[indexOfSelectedEvent].Year
            transferUsedEvent()
        }
    
    assignTopButton()
    assignMidTopButton()
    assignMidBotButton()
    assignBottomButton()
    
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
    
    func resetEventArray() {
        usedEventArray.removeAll()
        initialEventArray.append(contentsOf: usedEventArray)
    }

// MARK: Activating/Deactivating Buttons and Arrows
    
    func disableArrows() {
        FirstDownButton.isEnabled = false
        SecondUpButton.isEnabled = false
        SecondDownButton.isEnabled = false
        ThirdUpButton.isEnabled = false
        ThirdDownButton.isEnabled = false
        FourthUpButton.isEnabled = false
        
    }
    
    func enableArrows() {
        FirstDownButton.isEnabled = true
        SecondUpButton.isEnabled = true
        SecondDownButton.isEnabled = true
        ThirdUpButton.isEnabled = true
        ThirdDownButton.isEnabled = true
        FourthUpButton.isEnabled = true
    }
    
    func disableButtons() {
        FirstEventButton.isEnabled = false
        SecondEventButton.isEnabled = false
        ThirdEventButton.isEnabled = false
        FourthEventButton.isEnabled = false
    }
    
    func enableButtons() {
        FirstEventButton.isEnabled = true
        SecondEventButton.isEnabled = true
        ThirdEventButton.isEnabled = true
        FourthEventButton.isEnabled = true
    }











}
