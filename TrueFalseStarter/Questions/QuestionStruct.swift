//
//  QuestionStruct.swift
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
  
    let answer: Int
    
   // function to verify correct answer
    func isAnswerCorrect(usingID id: Int) -> Bool {
        return id == answer
    }
}
