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
    
    var tableViewController: WorkoutTableViewController?
    var navigationController: UINavigationController?
    var exercise: Exercise!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(exercise: Exercise, isModal: Bool, tableViewController: WorkoutTableViewController?, navigationController: UINavigationController?) {
        exerciseNameLabel.text = exercise.name
        self.exercise = exercise
        self.tableViewController = tableViewController
        self.navigationController = navigationController
        guard isModal == true else {
            addToWorkoutButton.isHidden = true
            return
        }
        addToWorkoutButton.isHidden = false
    }
    @IBAction func addToWorkoutButtonTapped(_ sender: Any) {
        tableViewController?.exercises.append(exercise)
        tableViewController?.updateDataSource()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
