//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Kristopher Wood on 7/5/18.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    let audioManager = AudioManager()
   
    let gameManager = GameManager()
    
    // Access to color information
    var colorSets: ColorSets!
    var color: Color!
    // Access to question information
    var questionSets: QuestionSets!
    var currentQuestion: Question!
    
    /*
     
     Finish Lightning Mode after Submission
     
 */
    
    
    // Total lightning mode seconds
    let totalLightningModeSeconds = 15
    // The current countdown
    var lightningModeSecondsLeft = 15
    // Timer for lightning mode and label
    weak var timer: Timer!
    var isTimerStarted = false
    
    // Outlets used for display labels
    @IBOutlet weak var mainDisplayMessage: UILabel!
    @IBOutlet weak var secondaryDisplayMessage: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    // Outlets used for answer buttons
    @IBOutlet weak var answerOneBox: UIButton!
    @IBOutlet weak var answerTwoBox: UIButton!
    @IBOutlet weak var answerThreeBox: UIButton!
    @IBOutlet weak var answerFourBox: UIButton!
    
    @IBOutlet weak var mainInteractButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioManager.playGameStartSound()
        setButtonsHiddenTo(true)
    }
    
   // Button Functions

    @IBAction func mainButtonClicked(_ sender: Any) {
        prepareForNewGame()
    }
    
    @IBAction func questionButtonClicked(_ sender: Any) {
        cancelTimerAsTimedOut(false)
        
        let button = sender as! UIButton
        let selectedAnswer = button.tag
        
        if currentQuestion.isAnswerCorrect(usingID: selectedAnswer) {
            button.backgroundColor = UIColor.green
            gameManager.logCorrectAnswer()
            audioManager.playRightAnswerSound()
            
            secondaryDisplayMessage.text = "Fab!"
        } else {
            button.backgroundColor = UIColor.red
            gameManager.logIncorrectAnswer()
            audioManager.playWrongAnswerSound()
            
            secondaryDisplayMessage.text = "Sorry, you may need HELP!"
            
            switch(currentQuestion.answer) {
            case 0: answerOneBox.backgroundColor = UIColor.green
            case 1: answerTwoBox.backgroundColor = UIColor.green
            case 2: answerThreeBox.backgroundColor = UIColor.green
            case 3: answerFourBox.backgroundColor = UIColor.green
            default: return
            }
        }
        
        setButtonTextToBlack()
        setButtonUsabilityTo(false)
        loadNextRoundWithDelay(seconds: 2)
    }
    
    
    
    func displayQuestion() {
        if gameManager.isGameOver() {
            displayGameOver()
            return
        }
        
        currentQuestion = questionSets.getNextQuestion()
        selectAndUpdateColor()
        
        switch(currentQuestion.answers.count) {
        case 2:
            answerOneBox.setTitle(currentQuestion.answers[0], for: .normal)
            answerTwoBox.setTitle(currentQuestion.answers[1], for: .normal)
            
            answerThreeBox.isHidden = true
            answerFourBox.isHidden = true
        case 3:
            answerOneBox.setTitle(currentQuestion.answers[0], for: .normal)
            answerTwoBox.setTitle(currentQuestion.answers[1], for: .normal)
            answerThreeBox.setTitle(currentQuestion.answers[2], for: .normal)
            
            answerThreeBox.isHidden = false
            answerFourBox.isHidden = true
        case 4:
            answerOneBox.setTitle(currentQuestion.answers[0], for: .normal)
            answerTwoBox.setTitle(currentQuestion.answers[1], for: .normal)
            answerThreeBox.setTitle(currentQuestion.answers[2], for: .normal)
            answerFourBox.setTitle(currentQuestion.answers[3], for: .normal)
            
            answerThreeBox.isHidden = false
            answerFourBox.isHidden = false
        default: return
        }
        
        mainDisplayMessage.text = currentQuestion.question
        secondaryDisplayMessage.text = ""
        
        setButtonUsabilityTo(true)
        
        runTimer()
    }
    
    func displayTimedOut() {
        gameManager.logIncorrectAnswer()
        audioManager.playWrongAnswerSound()
        
        secondaryDisplayMessage.text = "You ran out of time!"
        
        switch(currentQuestion.answer) {
        case 0: answerOneBox.backgroundColor = UIColor.green
        case 1: answerTwoBox.backgroundColor = UIColor.green
        case 2: answerThreeBox.backgroundColor = UIColor.green
        case 3: answerFourBox.backgroundColor = UIColor.green
        default: return
        }
        
        setButtonTextToBlack()
        setButtonUsabilityTo(false)
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func displayGameOver() {
        resetUIColor()
        
        mainDisplayMessage.text = "The End!"
        secondaryDisplayMessage.text = "Your score is \(gameManager.correctAnswers) / \(gameManager.totalAnswers)"
        mainInteractButton.setTitle("Get Back!", for: .normal)
        
        setButtonsHiddenTo(true)
        setMainButtonHiddenTo(false)
    }
    
   
    
    func prepareForNewGame() {
        setButtonsHiddenTo(false)
        setMainButtonHiddenTo(true)
        
        colorSets = ColorSets()
        questionSets = QuestionSets()
        gameManager.setupWith(questionSets: questionSets)
        displayQuestion()
    }
    
    func selectAndUpdateColor() {
        color = colorSets.randomColor()
        
        self.view.backgroundColor = color.mainColor
        
        mainDisplayMessage.textColor = color.textColor
        secondaryDisplayMessage.textColor = color.textColor
        timerLabel.textColor = color.textColor
        
        answerOneBox.backgroundColor = color.secondaryColor
        answerTwoBox.backgroundColor = color.secondaryColor
        answerThreeBox.backgroundColor = color.secondaryColor
        answerFourBox.backgroundColor = color.secondaryColor
        
        setTitleColor()
    }
    
    func setTitleColor() {
        answerOneBox.setTitleColor(color.textColor, for: .normal)
        answerTwoBox.setTitleColor(color.textColor, for: .normal)
        answerThreeBox.setTitleColor(color.textColor, for: .normal)
        answerFourBox.setTitleColor(color.textColor, for: .normal)
    }
    
    func setButtonsHiddenTo(_ value: Bool) {
        answerOneBox.isHidden = value
        answerTwoBox.isHidden = value
        answerThreeBox.isHidden = value
        answerFourBox.isHidden = value
    }
    
    func setMainButtonHiddenTo(_ value: Bool) {
        mainInteractButton.isHidden = value
    }
    
    func setButtonUsabilityTo(_ value: Bool) {
        answerOneBox.isEnabled = value
        answerTwoBox.isEnabled = value
        answerThreeBox.isEnabled = value
        answerFourBox.isEnabled = value
    }
    
    // Used when displaying answers for visbility
    func setButtonTextToBlack() {
        answerOneBox.setTitleColor(.black, for: .normal)
        answerTwoBox.setTitleColor(.black, for: .normal)
        answerThreeBox.setTitleColor(.black, for: .normal)
        answerFourBox.setTitleColor(.black, for: .normal)
    }
    
    func resetUIColor() {
        self.view.backgroundColor = colorSets.firstColors.mainColor
        
        mainDisplayMessage.textColor = colorSets.firstColors.textColor
        secondaryDisplayMessage.textColor = colorSets.firstColors.textColor
    }
    
    // Timer
    
    func runTimer() {
        if !isTimerStarted {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(timerTicked), userInfo: nil, repeats: true)
            timerLabel.textColor = color.textColor
            isTimerStarted = true
        }
    }
    
    func timerTicked() {
        if lightningModeSecondsLeft > 0 {
            timerLabel.text = String(lightningModeSecondsLeft)
            lightningModeSecondsLeft = lightningModeSecondsLeft - 1
        } else {
            cancelTimerAsTimedOut(true)
        }
    }
    
    func cancelTimerAsTimedOut(_ timedOut: Bool) {
        lightningModeSecondsLeft = totalLightningModeSeconds
        timerLabel.text = ""
        
        timer?.invalidate()
        isTimerStarted = false
        
        if timedOut {
            displayTimedOut()
        }
    }
    
   
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)

        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.displayQuestion()
        }
    }
}
