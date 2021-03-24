//
//  BuiltInWorkouts.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/19/21.
//

import Foundation

class BuiltInWorkouts {
    


var chestArray = [chestWorkout1, chestWorkout2, chestWorkout3, chestWorkout4]
var armArray = [armWorkout1, armWorkout2, armWorkout3, armWorkout4]
var legArray = [legWorkout1]
var coreArray = [coreWorkout1]
var shoulderArray = [shoulderWorkout1]
var backArray = [backWorkout1]
}
var backWorkout1 = Workout(name: "Back Crusher", image: nil, timer: nil, exercises: [inclineDumbbellPress, latPullDown, skullCrushers, frontRaise, boxJump], requiresEquipment: true)
var legWorkout1 = Workout(name: "Leg Slayer", image: nil, timer: nil, exercises: [barbellBenchPress, wideGripPullUps, barbellBicepCurl, dumbbellSquatWalk, dumbbellJumpSquat], requiresEquipment: true)
var armWorkout1 = Workout(name: "Arm Destroyer", image: nil, timer: nil, exercises: [inclineBenchPress, singleArmDumbbellRow, cableTricepPushDown, bentOverDumbbellLatRaise, deadlift], requiresEquipment: true)
var armWorkout2 = Workout(name: "No Pain No Gain", image: nil, timer: nil, exercises: [barbellBicepCurl, wideGripPullUps, cableBicepCurl, singleArmDumbbellRow], requiresEquipment: true)
var armWorkout3 = Workout(name: "Curls for Gurls", image: nil, timer: nil, exercises: [frontRaise, jumpRope, pullUps, pushUps], requiresEquipment: true)
var armWorkout4 = Workout(name: "Arm of steel", image: nil, timer: nil, exercises: [cableBicepCurl, barbellBicepCurl], requiresEquipment: true)
var chestWorkout4 = Workout(name: "Chest Day", image: nil, timer: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, jumpRope, pullUps, dips, latPullDown, boxJump], requiresEquipment: true)
var chestWorkout1 = Workout(name: "Lower Chest Killer", image: nil, timer: nil, exercises: [dips, cableTricepPushDown, pushUps, inclineDumbbellPress, frontRaise, skullCrushers], requiresEquipment: true)
var chestWorkout2 = Workout(name: "Chest shred", image: nil, timer: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, singleArmDumbbellTricepsExtension, pullUps], requiresEquipment: true)
var chestWorkout3 = Workout(name: "Best Chest", image: nil, timer: nil, exercises: [inclineDumbbellPress, skullCrushers, barbellBenchPress, singleArmDumbbellTricepsExtension, cableTricepPushDown, pushUps, jumpRope], requiresEquipment: true)
var coreWorkout1 = Workout(name: "abStract", image: nil, timer: nil, exercises: [shoulderTapPlanks], requiresEquipment: false)
    
var shoulderWorkout1 = Workout(name: "Boulders day", image: nil, timer: nil, exercises: [], requiresEquipment: true)
