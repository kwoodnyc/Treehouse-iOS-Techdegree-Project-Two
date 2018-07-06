//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Kristopher Wood 7/5/2018.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

struct Question {
    // Store the question
    let question: String
    // List to store the possible answers
    let answers: [String]
    // ID (0 to total answers less one) of the correct answer
    let answer: Int
    
    /*
         Verify that the answer selected is the correct one
     */
    func isAnswerCorrect(usingID id: Int) -> Bool {
        return id == answer
    }
}
