//
//  JSONManager.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 4/19/21.
//

import Foundation

class JSONManager {
    
    func writeWorkoutsToDisk(workout: JSONWorkouts) {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("workouts").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        
        let encodedWorkouts = try? propertyListEncoder.encode(workout)
        
        try? encodedWorkouts?.write(to: archiveURL, options: .noFileProtection)
        
    }
    
    func readWorkoutsFromDisk() -> JSONWorkouts? {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("workouts").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedWorkoutsData = try? Data(contentsOf: archiveURL), let decodedWorkouts = try? propertyListDecoder.decode(JSONWorkouts.self, from: retrievedWorkoutsData) {
            return decodedWorkouts
        }
        return nil
    }
    
    func writeExercisesToDisk(exercises: [Exercise]) {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("exercises").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        
        let encodedExercises = try? propertyListEncoder.encode(exercises)
        
        try? encodedExercises?.write(to: archiveURL, options: .noFileProtection)
        
    }
    
    func readExercisesFromDisk() -> [Exercise]? {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("exercises").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedExerciseDatas = try? Data(contentsOf: archiveURL), let decodedExercises = try? propertyListDecoder.decode([Exercise].self, from: retrievedExerciseDatas) {
            return decodedExercises
        }
        return nil
    }
}
