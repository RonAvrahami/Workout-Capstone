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
    @IBOutlet weak var imageContainerView: UIView!
    
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
        
        imageContainerView.layer.shadowColor = UIColor.black.cgColor
        imageContainerView.layer.shadowRadius = 5
        imageContainerView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        imageContainerView.layer.shadowOpacity = 0.7
    }
}


