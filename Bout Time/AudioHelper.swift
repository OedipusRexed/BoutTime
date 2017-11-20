//
//  AudioHelper.swift
//  Bout Time
//
//  Created by Aaron Revalee on 10/22/17.
//  Copyright © 2017 OedipusRexed. All rights reserved.
//

import AudioToolbox


var dingSound: SystemSoundID = 0
var buzzSound: SystemSoundID = 0

func loadDingSound() {
    if let pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav") {
        let soundURL = URL(fileURLWithPath: pathToSoundFile)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &dingSound)
    }
}

func loadBuzzSound() {
    if let pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav") {
        let soundURL = URL(fileURLWithPath: pathToSoundFile)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &buzzSound)
    }
}

func loadAllSounds() {
    loadDingSound()
    loadBuzzSound()
}

func playDingSound() {
    AudioServicesPlaySystemSound(dingSound)
}

func playBuzzSound() {
    AudioServicesPlaySystemSound(buzzSound)
}
