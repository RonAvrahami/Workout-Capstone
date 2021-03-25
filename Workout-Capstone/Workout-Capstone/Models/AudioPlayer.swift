//
//  AudioPlayer.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/25/21.
//

import Foundation
import AVFoundation
var passedTimeGoalSound: AVAudioPlayer?

func playSound() {
    let path = Bundle.main.path(forResource: "", ofType:nil)!
    let url = URL(fileURLWithPath: path)

    do {
        passedTimeGoalSound = try AVAudioPlayer(contentsOf: url)
        passedTimeGoalSound?.play()
    } catch {
        print(error)
    }
    
}
