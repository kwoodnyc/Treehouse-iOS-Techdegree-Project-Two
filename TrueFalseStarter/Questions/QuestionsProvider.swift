//
//  QuestionsProviderModel.swift
//  TrueFalseStarter
//
//  Created by Kristopher Wood on 7/5/2018.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//
import GameKit

class QuestionsProvider {
    // Store the total number of questions
    let totalQuestions = 8
    // Store a list of all the questions
    var questions: [Question] = [
        Question(question: "In what Beatles song did George Harrison first play the sitar?",
                 answers: ["Across the Universe", "Norwegian Wood", "Within You, Without You", "I'm Looking Through You"],
                 answer: 1),
        Question(question: "Who took Ringo's place on drums when he temporarily quit the band during the recording of The White Album?",
                 answers: ["Charlie Watts", "Ginger Baker", "Paul McCartney", "Phil Collins"],
                 answer: 2),
        Question(question: "Which pop artist designed the cover of the White Album?",
                 answers: ["Andy Warhol", "Peter Blake", "Richard Hamilton", "Peter Max"],
                 answer: 2),
        Question(question: "Why did George Martin make the Beatles rerecord the song Please Please Me?",
                 answers: ["It was too slow", "John Lennon was sick", "The lyrics were too explicit", "The drumming was subpar"],
                 answer: 0),
        Question(question: "What was the working title of With a Little Help from my Friends?",
                 answers: ["Grannie Smith", "Badfinger Boogie", "Auntie Gin's Theme", "Scrambled Eggs"],
                 answer: 1),
        Question(question: "What band did Ringo leave to join the Beatles?",
                 answers: ["Alan Caldwell and the Storm", "Rory Storm and the Hurricanes", "Johnny and the Moondogs", "Tony Sheridan's Beat Brothers"],
                 answer: 1),
        Question(question: "Who was the original drummer for the Beatles?",
                 answers: ["Richard Starkey", "Stuart Sutcliff", "Bill Wyman", "Pete Best"],
                 answer: 3),
        Question(question: "Which Beatle crossed Abbey Road first?",
                 answers: ["John", "Paul", "George", "Ringo"],
                 answer: 0),
    ]
    
    /*
         Function to return the next question
     */
    func getNextQuestion() -> Question {
        let selected = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        let questionSelected = questions[selected]
        
        questions.remove(at: selected)
        return questionSelected
    }
}
