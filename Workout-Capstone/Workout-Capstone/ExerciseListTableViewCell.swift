//
//  ExerciseListTableViewCell.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/16/21.
//

import UIKit

class ExerciseListTableViewCell: UITableViewCell {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var addToWorkoutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(exercise: Exercise) {
        exerciseNameLabel.text = exercise.name
    }
    @IBAction func addToWorkoutButtonTapped(_ sender: Any) {
        
    }
    
}
