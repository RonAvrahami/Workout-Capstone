//
//  BuiltInWorkouts.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/19/21.
//

import Foundation
import UIKit
class BuiltInWorkouts {
    


var chestArray = [chestWorkout1, chestWorkout2, chestWorkout3, chestWorkout4]
var armArray = [armWorkout1, armWorkout2, armWorkout3, armWorkout4]
var legArray = [legWorkout1, legWorkout2, legWorkout3, legWorkout4]
var coreArray = [coreWorkout1, coreWorkout2, coreWorkout3, coreWorkout4]
var shoulderArray = [shoulderWorkout1, shoulderWorkout2, shoulderWorkout3, shoulderWorkout4]
var backArray = [backWorkout1, backWorkout2, backWorkout3, backWorkout4]
}

var backWorkout1 = Workout(name: "Back Crusher", image: UIImage(named: "25"), timer: nil, exercises: [inclineDumbbellPress, latPullDown, skullCrushers, frontRaise, boxJump], requiresEquipment: true)
var backWorkout2 = Workout(name: "No looking Back", image: UIImage(named: "27"), timer: nil, exercises: [latPullDown, bentOverDumbbellLatRaise, pullUps, wideGripSeatedCableRow, wideGripPullUps, jumpRope, dumbbellDeadliftShrug], requiresEquipment: true)
var backWorkout3 = Workout(name: "Dont Back Down", image: UIImage(named: "28"), timer: nil, exercises: [superMan, jumpRope, wideGripPullUps, russianTwist, dips, pullUps, latPullDown, dumbbellSquatWalk, bentOverDumbbellLatRaise, deadlift, lungeTwist], requiresEquipment: true)
var backWorkout4 = Workout(name: "Back Burner", image: UIImage(named: "26"), timer: nil, exercises: [boxJump, wideGripPullUps, wideGripSeatedCableRow, mountainClimbers, latPullDown, plank, dips, superMan, jumpingJack, shoulderTapPlanks], requiresEquipment: true)
var legWorkout1 = Workout(name: "Leg Slayer", image: UIImage(named: "29"), timer: nil, exercises: [barbellBenchPress, wideGripPullUps, barbellBicepCurl, dumbbellSquatWalk, dumbbellJumpSquat], requiresEquipment: true)
var legWorkout2 = Workout(name: "Anti chicken leg", image: UIImage(named: "18"), timer: nil, exercises: [squats, boxJump, jumpRope, gobletSquat, seatedCalfRaise, lungeTwist, mountainClimbers, legPress], requiresEquipment: true)
var legWorkout3 = Workout(name: "Break a leg", image: UIImage(named: "11"), timer: nil, exercises: [boxJump, jumpRope, dumbbellJumpSquat, legPress, seatedCalfRaise, stepUps, jumpingJack, lungeTwist, gobletSquat, squats], requiresEquipment: true)
var legWorkout4 = Workout(name: "Third Leg", image: UIImage(named: "10"), timer: nil, exercises: [boxJump, plank, deadlift, legPress, gobletSquat, barbellDeadLift, seatedCalfRaise, superMan, jumpingJack, dumbbellSquatWalk, dumbbellJumpSquat, mountainClimbers, dips], requiresEquipment: true)
var armWorkout1 = Workout(name: "Arm Destroyer", image: UIImage(named: "1"), timer: nil, exercises: [inclineBenchPress, singleArmDumbbellRow, cableTricepPushDown, bentOverDumbbellLatRaise, deadlift], requiresEquipment: true)
var armWorkout2 = Workout(name: "No Pain No Gain", image: UIImage(named: "14"), timer: nil, exercises: [barbellBicepCurl, wideGripPullUps, cableBicepCurl, singleArmDumbbellRow], requiresEquipment: true)
var armWorkout3 = Workout(name: "Curls for Gurls", image: UIImage(named: "15"), timer: nil, exercises: [frontRaise, jumpRope, pullUps, pushUps], requiresEquipment: true)
var armWorkout4 = Workout(name: "Arm of steel", image: UIImage(named: "16"), timer: nil, exercises: [cableBicepCurl, barbellBicepCurl], requiresEquipment: true)
var chestWorkout4 = Workout(name: "Chest Day", image: UIImage(named: "17"), timer: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, jumpRope, pullUps, dips, latPullDown, boxJump], requiresEquipment: true)
var chestWorkout1 = Workout(name: "Lower Chest Killer", image: UIImage(named: "22"), timer: nil, exercises: [dips, cableTricepPushDown, pushUps, inclineDumbbellPress, frontRaise, skullCrushers], requiresEquipment: true)
var chestWorkout2 = Workout(name: "Chest shred", image: UIImage(named: "19"), timer: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, singleArmDumbbellTricepsExtension, pullUps], requiresEquipment: true)
var chestWorkout3 = Workout(name: "Best Chest", image: UIImage(named: "23"), timer: nil, exercises: [inclineDumbbellPress, skullCrushers, barbellBenchPress, singleArmDumbbellTricepsExtension, cableTricepPushDown, pushUps, jumpRope], requiresEquipment: true)
var coreWorkout1 = Workout(name: "abStract", image: UIImage(named: "30"), timer: nil, exercises: [shoulderTapPlanks], requiresEquipment: false)
    
var shoulderWorkout1 = Workout(name: "Boulders day", image: UIImage(named: "24"), timer: nil, exercises: [], requiresEquipment: true)
var shoulderWorkout2 = Workout(name: "Cold Shoulder", image: UIImage(named: "6"), timer: nil, exercises: [seatedDumbbellShouldersPress, shoulderTapPlanks, frontRaise, jumpRope, ], requiresEquipment: true)
var shoulderWorkout3 = Workout(name: "Dirt of your Shoulder", image: UIImage(named: "4"), timer: nil, exercises: [frontRaise, bentOverDumbbellLatRaise, shoulderPress, shoulderTapPlanks, seatedDumbbellShouldersPress, jumpingJack, dumbbellJumpSquat], requiresEquipment: true)
var shoulderWorkout4 = Workout(name: "A Shoulder to Cry On", image: UIImage(named: "2"), timer: nil, exercises: [jumpRope, shoulderPress, jumpingJack, seatedDumbbellShouldersPress, boxJump, frontRaise, shoulderTapPlanks, inclineBenchPress, mountainClimbers], requiresEquipment: true)
var coreWorkout2 = Workout(name: "6 Pack Snack", image: UIImage(named: "31"), timer: nil, exercises: [situp, jumpRope, russianTwist, boxJump, plank, pullUps, shoulderTapPlanks, lungeTwist], requiresEquipment: false)
var coreWorkout3 = Workout(name: "Abs of Steel", image: UIImage(named: "5"), timer: nil, exercises: [situp, plank, shoulderTapPlanks, jumpingJack, superMan], requiresEquipment: false)
var coreWorkout4 = Workout(name: "Abs no flab", image: UIImage(named: "8"), timer: nil, exercises: [russianTwist, jumpRope, superMan, jumpingJack, plank, dumbbellJumpSquat, situp, squats], requiresEquipment: true)
