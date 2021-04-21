//
//  WorkoutData.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/11/21.
//

import Foundation
import UIKit

struct Workout: Hashable {
    
    var workoutObject: WorkoutObject
    
    var image: UIImage? {
        if let image = UIImage(data: workoutObject.imageData) {
        return image
        }
        return nil
    }
}

struct WorkoutObject: Hashable, Codable {
    
    var name: String
    var imageData: Data
    var time: Int?
    var exercises: [ExerciseData]?
    var requiresEquipment: Bool?
    var id = UUID()
}

struct JSONWorkouts: Hashable, Codable {

    var armArray: [WorkoutObject]
    var backArray: [WorkoutObject]
    var legArray: [WorkoutObject]
    var chestArray: [WorkoutObject]
    var coreArray: [WorkoutObject]
    var shoulderArray: [WorkoutObject]
    var customWorkout: [WorkoutObject]
    
    var workouts: [[WorkoutObject]] {
        return [armArray, backArray, legArray, chestArray, coreArray, shoulderArray, customWorkout]
    }
}
