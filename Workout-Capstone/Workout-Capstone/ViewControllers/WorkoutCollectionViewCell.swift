//
//  WorkoutCollectionViewCell.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/11/21.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    func update(workout: Workout) {
        workoutNameLabel.text = workout.name
    }
}
