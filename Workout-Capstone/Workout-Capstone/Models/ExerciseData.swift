//
//  ExerciseData.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/11/21.
//

import Foundation
import UIKit

enum MuscleGroup: String, CaseIterable, Hashable {
    case defualt
    case arms = "Arms"
    case legs = "Legs"
    case shoulders = "Shoulder"
    case core = "Core"
    case back = "Back"
    case chest = "Chest"
}

struct Exercise: Hashable{
    var name: String?
    var image: UIImage?
    var timeGoal: Int?
    var reps: Int?
    var requiresEquipment: Bool?
    var muscle: MuscleGroup?
    var description: String?
}


