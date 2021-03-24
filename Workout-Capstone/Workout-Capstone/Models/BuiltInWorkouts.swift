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
var legArray = [legWorkout1, legWorkout2, legWorkout3, legWorkout4]
var coreArray = [coreWorkout1, coreWorkout2, coreWorkout3, coreWorkout4]
var shoulderArray = [shoulderWorkout1, shoulderWorkout2, shoulderWorkout3, shoulderWorkout4]
var backArray = [backWorkout1, backWorkout2, backWorkout3, backWorkout4]
}
var backWorkout1 = Workout(name: "Back Crusher", image: nil, timer: nil, exercises: [inclineDumbbellPress, latPullDown, skullCrushers, frontRaise, boxJump], requiresEquipment: true)
var backWorkout2 = Workout(name: "No looking Back", image: nil, timer: nil, exercises: [latPullDown, bentOverDumbbellLatRaise, pullUps, wideGripSeatedCableRow, wideGripPullUps, jumpRope, dumbbellDeadliftShrug], requiresEquipment: true)
var backWorkout3 = Workout(name: "Dont Back Down", image: nil, timer: nil, exercises: [superMan, jumpRope, wideGripPullUps, russianTwist, dips, pullUps, latPullDown, dumbbellSquatWalk, bentOverDumbbellLatRaise, deadlift, lungeTwist], requiresEquipment: true)
var backWorkout4 = Workout(name: "Back Burner", image: nil, timer: nil, exercises: [boxJump, wideGripPullUps, wideGripSeatedCableRow, mountainClimbers, latPullDown, plank, dips, superMan, jumpingJack, shoulderTapPlanks], requiresEquipment: true)
var legWorkout1 = Workout(name: "Leg Slayer", image: nil, timer: nil, exercises: [barbellBenchPress, wideGripPullUps, barbellBicepCurl, dumbbellSquatWalk, dumbbellJumpSquat], requiresEquipment: true)
var legWorkout2 = Workout(name: "Anti chicken leg", image: nil, timer: nil, exercises: [squats, boxJump, jumpRope, gobletSquat, seatedCalfRaise, lungeTwist, mountainClimbers, legPress], requiresEquipment: true)
var legWorkout3 = Workout(name: "Break a leg", image: nil, timer: nil, exercises: [boxJump, jumpRope, dumbbellJumpSquat, legPress, seatedCalfRaise, stepUps, jumpingJack, lungeTwist, gobletSquat, squats], requiresEquipment: true)
var legWorkout4 = Workout(name: "Third Leg", image: nil, timer: nil, exercises: [boxJump, plank, deadlift, legPress, gobletSquat, barbellDeadLift, seatedCalfRaise, superMan, jumpingJack, dumbbellSquatWalk, dumbbellJumpSquat, mountainClimbers, dips], requiresEquipment: true)
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
var shoulderWorkout2 = Workout(name: "Cold Shoulder", image: nil, timer: nil, exercises: [seatedDumbbellShouldersPress, shoulderTapPlanks, frontRaise, jumpRope, ], requiresEquipment: true)
var shoulderWorkout3 = Workout(name: "Dirt of your Shoulder", image: nil, timer: nil, exercises: [frontRaise, bentOverDumbbellLatRaise, shoulderPress, shoulderTapPlanks, seatedDumbbellShouldersPress, jumpingJack, dumbbellJumpSquat], requiresEquipment: true)
var shoulderWorkout4 = Workout(name: "A Shoulder to Cry On", image: nil, timer: nil, exercises: [jumpRope, shoulderPress, jumpingJack, seatedDumbbellShouldersPress, boxJump, frontRaise, shoulderTapPlanks, inclineBenchPress, mountainClimbers], requiresEquipment: true)
var coreWorkout2 = Workout(name: "6 Pack Snack", image: nil, timer: nil, exercises: [situp, jumpRope, russianTwist, boxJump, plank, pullUps, shoulderTapPlanks, lungeTwist], requiresEquipment: false)
var coreWorkout3 = Workout(name: "Abs of Steel", image: nil, timer: nil, exercises: [situp, plank, shoulderTapPlanks, jumpingJack, superMan], requiresEquipment: false)
var coreWorkout4 = Workout(name: "Abs no flab", image: nil, timer: nil, exercises: [russianTwist, jumpRope, superMan, jumpingJack, plank, dumbbellJumpSquat, situp, squats], requiresEquipment: true)

