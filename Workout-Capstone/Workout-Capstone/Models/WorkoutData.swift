//
//  WorkoutData.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/11/21.
//

import Foundation
import UIKit

struct Workout: Hashable {
    var name: String?
    var image: UIImage?
    var timer: Timer?
    var exercises: [Exercise]?
    var requiresEquipment: Bool?
    
    
}
