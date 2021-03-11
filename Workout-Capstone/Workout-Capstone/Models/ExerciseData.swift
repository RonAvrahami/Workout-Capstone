//
//  ExerciseData.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/11/21.
//

import Foundation
import UIKit

enum MuscleGroup {
    case legs
    case shoulders
    case core
    case biceps
    case back
    case cardio
    
}

struct Exercise: Hashable{
    var name: String?
    var image: UIImage?
    var timer: Timer?
    var reps: Int?
    var requiresEquipment: Bool?
    var muscle: MuscleGroup?
    
}


