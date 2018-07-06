//
//  AudioManager.swift
//  TrueFalseStarter
//
//  Created by Kristopher Wood on 7/6/2018.
//  Copyright © 2018 Kristopher Wood. All rights reserved.
//

import AudioToolbox

class AudioManager {
    // References to the three sounds used
    var gameSound: SystemSoundID = 0
    var rightAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    
    // Initalize the manager by loading the sounds
    init () {
        loadSounds()
    }
    
    // Load all the needed sounds
    func loadSounds() {
        var pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        var soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "RightSound", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &rightAnswerSound)
        
        pathToSoundFile = Bundle.main.path(forResource: "WrongSound", ofType: "wav")
        soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswerSound)
    }
    
    // MARK: Methods to play sounds
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playRightAnswerSound() {
        AudioServicesPlaySystemSound(rightAnswerSound)
    }
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
}
