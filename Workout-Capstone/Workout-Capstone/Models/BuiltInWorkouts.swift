//
//  BuiltInWorkouts.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/19/21.
//

import Foundation

class BuiltInWorkouts {
    
var workout1 = Workout(name: "Back Crusher", image: nil, timer: nil, exercises: [inclineDumbbellPress, latPullDown, skullCrushers, frontRaise, boxJump], requiresEquipment: true)
var workout2 = Workout(name: "Leg Slayer", image: nil, timer: nil, exercises: [barbellBenchPress, wideGripPullUps, barbellBicepCurl, dumbbellSquatWalk, dumbbellJumpSquat], requiresEquipment: true)
var workout3 = Workout(name: "Arm Destroyer", image: nil, timer: nil, exercises: [inclineBenchPress, singleArmDumbbellRow, cableTricepPushDown, bentOverDumbbellLatRaise, deadlift], requiresEquipment: true)
var workout4 = Workout(name: "Chest Day", image: nil, timer: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, jumpRope, pullUps, dips, latPullDown, boxJump], requiresEquipment: true)
}
