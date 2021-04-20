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
    
var myWorkouts: [Workout] = []
}

var backWorkout1 = Workout(workoutObject: WorkoutObject(name: "Back Crusher", imageData: (UIImage(named: "25")?.pngData()) ?? Data(), time: nil, exercises: [inclineDumbbellPress, latPullDown, skullCrushers, frontRaise, boxJump], requiresEquipment: nil, id: UUID()))

var backWorkout2 = Workout(workoutObject: WorkoutObject(name: "No looking Back", imageData: UIImage(named: "27")?.pngData() ?? Data(), time: nil, exercises: [latPullDown, bentOverDumbbellLatRaise, pullUps, wideGripSeatedCableRow, wideGripPullUps, jumpRope, dumbbellDeadliftShrug], requiresEquipment: nil, id: UUID()))
var backWorkout3 = Workout(workoutObject: WorkoutObject(name: "Dont Back Down", imageData: UIImage(named: "28")?.pngData() ?? Data(), time: nil, exercises: [superMan, jumpRope, wideGripPullUps, russianTwist, dips, pullUps, latPullDown, dumbbellSquatWalk, bentOverDumbbellLatRaise, deadlift, lungeTwist], requiresEquipment: nil, id: UUID()))

var backWorkout4 = Workout(workoutObject: WorkoutObject(name: "Back Burner", imageData: UIImage(named: "26")?.pngData() ?? Data(), time: nil, exercises: [boxJump, wideGripPullUps, wideGripSeatedCableRow, mountainClimbers, latPullDown, plank, dips, superMan, jumpingJack, shoulderTapPlanks], requiresEquipment: nil, id: UUID()))

var legWorkout1 = Workout(workoutObject: WorkoutObject(name: "Leg Slayer", imageData: UIImage(named: "29")?.pngData() ?? Data(), time: nil, exercises: [barbellBenchPress, wideGripPullUps, barbellBicepCurl, dumbbellSquatWalk, dumbbellJumpSquat], requiresEquipment: nil, id: UUID()))
    
var legWorkout2 = Workout(workoutObject: WorkoutObject(name: "Anti chicken leg", imageData: UIImage(named: "18")?.pngData() ?? Data(), time: nil, exercises: [squats, boxJump, jumpRope, gobletSquat, seatedCalfRaise, lungeTwist, mountainClimbers, legPress], requiresEquipment: nil, id: UUID()))
    
var legWorkout3 = Workout(workoutObject: WorkoutObject(name: "Break a leg", imageData: UIImage(named: "11")?.pngData() ?? Data(), time: nil, exercises:  [boxJump, jumpRope, dumbbellJumpSquat, legPress, seatedCalfRaise, stepUps, jumpingJack, lungeTwist, gobletSquat, squats], requiresEquipment: nil, id: UUID()))
    
var legWorkout4 = Workout(workoutObject: WorkoutObject(name: "Third Leg", imageData: UIImage(named: "10")?.pngData() ?? Data(), time: nil, exercises: [boxJump, plank, deadlift, legPress, gobletSquat, barbellDeadLift, seatedCalfRaise, superMan, jumpingJack, dumbbellSquatWalk, dumbbellJumpSquat, mountainClimbers, dips], requiresEquipment: nil, id: UUID()))
    
var armWorkout1 = Workout(workoutObject: WorkoutObject(name: "Arm Destroyer", imageData: UIImage(named: "1")?.pngData() ?? Data(), time: nil, exercises: [inclineBenchPress, singleArmDumbbellRow, cableTricepPushDown, bentOverDumbbellLatRaise, deadlift], requiresEquipment: nil, id: UUID()))

var armWorkout2 = Workout(workoutObject: WorkoutObject(name: "No Pain No Gain", imageData: UIImage(named: "14")?.pngData() ?? Data(), time: nil, exercises: [barbellBicepCurl, wideGripPullUps, cableBicepCurl, singleArmDumbbellRow], requiresEquipment: nil, id: UUID()))
  
var armWorkout3 = Workout(workoutObject: WorkoutObject(name: "Curls for Gurls", imageData: UIImage(named: "15")?.pngData() ?? Data(), time: nil, exercises: [frontRaise, jumpRope, pullUps, pushUps], requiresEquipment: nil, id: UUID()))

var armWorkout4 = Workout(workoutObject: WorkoutObject(name: "Arm of steel", imageData: UIImage(named: "16")?.pngData() ?? Data(), time: nil, exercises: [cableBicepCurl, barbellBicepCurl], requiresEquipment: nil, id: UUID()))
    
var chestWorkout4 = Workout(workoutObject: WorkoutObject(name: "Chest Day", imageData: UIImage(named: "17")?.pngData() ?? Data(), time: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, jumpRope, pullUps, dips, latPullDown, boxJump], requiresEquipment: nil, id: UUID()))
    
var chestWorkout1 = Workout(workoutObject: WorkoutObject(name: "Lower Chest Killer", imageData: UIImage(named: "22")?.pngData() ?? Data(), time: nil, exercises: [dips, cableTricepPushDown, pushUps, inclineDumbbellPress, frontRaise, skullCrushers], requiresEquipment: nil, id: UUID()))
    
var chestWorkout2 = Workout(workoutObject: WorkoutObject(name: "Chest shred", imageData: UIImage(named: "19")?.pngData() ?? Data(), time: nil, exercises: [barbellBenchPress, skullCrushers, inclineBenchPress, singleArmDumbbellTricepsExtension, pullUps], requiresEquipment: nil, id: UUID()))
   
var chestWorkout3 = Workout(workoutObject: WorkoutObject(name: "Best Chest", imageData: UIImage(named: "23")?.pngData() ?? Data(), time: nil, exercises: [inclineDumbbellPress, skullCrushers, barbellBenchPress, singleArmDumbbellTricepsExtension, cableTricepPushDown, pushUps, jumpRope], requiresEquipment: nil, id: UUID()))
    
var coreWorkout1 = Workout(workoutObject: WorkoutObject(name: "abStract", imageData: UIImage(named: "30")?.pngData() ?? Data(), time: nil, exercises: [shoulderTapPlanks], requiresEquipment: nil, id: UUID()))
    
var shoulderWorkout1 = Workout(workoutObject: WorkoutObject(name: "Boulders day", imageData: UIImage(named: "24")?.pngData() ?? Data(), time: nil, exercises: [], requiresEquipment: nil, id: UUID()))
    
var shoulderWorkout2 = Workout(workoutObject: WorkoutObject(name: "Cold Shoulder", imageData: UIImage(named: "6")?.pngData() ?? Data(), time: nil, exercises: [seatedDumbbellShouldersPress, shoulderTapPlanks, frontRaise, jumpRope], requiresEquipment: nil, id: UUID()))
    
var shoulderWorkout3 = Workout(workoutObject: WorkoutObject(name: "Dirt of your Shoulder", imageData: UIImage(named: "4")?.pngData() ?? Data(), time: nil, exercises: [frontRaise, bentOverDumbbellLatRaise, shoulderPress, shoulderTapPlanks, seatedDumbbellShouldersPress, jumpingJack, dumbbellJumpSquat], requiresEquipment: nil, id: UUID()))
    
var shoulderWorkout4 = Workout(workoutObject: WorkoutObject(name: "A Shoulder to Cry On", imageData: UIImage(named: "2")?.pngData() ?? Data(), time: nil, exercises: [jumpRope, shoulderPress, jumpingJack, seatedDumbbellShouldersPress, boxJump, frontRaise, shoulderTapPlanks, inclineBenchPress, mountainClimbers], requiresEquipment: nil, id: UUID()))

var coreWorkout2 = Workout(workoutObject: WorkoutObject(name: "6 Pack Snack", imageData: UIImage(named: "31")?.pngData() ?? Data(), time: nil, exercises: [situp, jumpRope, russianTwist, boxJump, plank, pullUps, shoulderTapPlanks, lungeTwist], requiresEquipment: nil, id: UUID()))

var coreWorkout3 = Workout(workoutObject: WorkoutObject(name: "Abs of Steel", imageData: UIImage(named: "5")?.pngData() ?? Data(), time: nil, exercises: [situp, plank, shoulderTapPlanks, jumpingJack, superMan], requiresEquipment: nil, id: UUID()))
    
var coreWorkout4 = Workout(workoutObject: WorkoutObject(name: "Abs no flab", imageData: UIImage(named: "8")?.pngData() ?? Data(), time: nil, exercises: [russianTwist, jumpRope, superMan, jumpingJack, plank, dumbbellJumpSquat, situp, squats], requiresEquipment: nil, id: UUID()))
    
