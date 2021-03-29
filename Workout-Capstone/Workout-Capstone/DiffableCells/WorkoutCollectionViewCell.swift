//
//  WorkoutCollectionViewCell.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/11/21.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    
    func update(workout: Workout, section: Section) {
        
        if section == .custom {
            workoutNameLabel.text = "New Workout"
            cellImageView.image = UIImage(systemName: "plus")
        } else {
            workoutNameLabel.text = workout.name
            cellImageView.image = workout.image
        }
        cellImageView.layer.cornerRadius = 20
        cellImageView.clipsToBounds = true
        cellImageView.layer.shadowColor = UIColor.darkGray.cgColor
        cellImageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        cellImageView.layer.shadowRadius = 25.0
        cellImageView.layer.shadowOpacity = 0.9
    }
}
