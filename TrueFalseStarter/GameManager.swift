//
//  GameManager.swift
//  TrueFalseStarter
//
//  Created by Kristopher Wood on 7/6/2018.
//  Copyright © 2017 Treehouse. All rights reserved.
//

class GameManager {
    // Question set reference
    var questionSets: QuestionSets! = nil
    
    // number of correct answers vs total answers
    var correctAnswers: Int = 0
    var totalAnswers: Int = 0
    
    // Store a correct answer
    func logCorrectAnswer() {
        correctAnswers += 1
        totalAnswers += 1
    }
    
    // Store an incorrect answer
    func logIncorrectAnswer() {
        totalAnswers += 1
    }
    
    // Game over? (total questions = total answers)
    func isGameOver() -> Bool {
        return totalAnswers == questionSets.totalQuestions
    }
    
    // Reset the manager for a new game
    func setupWith(questionSets: QuestionSets) {
        self.questionSets = questionSets
        
        correctAnswers = 0
        totalAnswers = 0
    }
}
