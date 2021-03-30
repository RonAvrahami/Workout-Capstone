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
    
    var exerciseListTableviewController: ExerciseListTableViewController?

    var exercise: Exercise!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(exercise: Exercise, isModal: Bool, exerciseListTableViewController: ExerciseListTableViewController?) {
        exerciseNameLabel.text = exercise.exerciseData.name
        self.exercise = exercise
        self.exerciseListTableviewController = exerciseListTableViewController
        guard isModal == true else {
            addToWorkoutButton.isHidden = true
            return
        }
        addToWorkoutButton.isHidden = false
    }
    @IBAction func addToWorkoutButtonTapped(_ sender: Any) {
        exerciseListTableviewController?.addAlert(exercise: exercise)
    }
    
}
