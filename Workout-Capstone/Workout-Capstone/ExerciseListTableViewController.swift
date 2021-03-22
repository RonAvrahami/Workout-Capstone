//
//  ExerciseListTableViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/15/21.
//

import UIKit

enum section {
    case one
}
class ExerciseListTableViewController: UITableViewController, AddExerciseProtocal {
    
    var exercises = [Exercise]()
    var dataSource: DataSource!
    var editingExercise: Exercise?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.delegate = self
        
        
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, exercise) -> UITableViewCell? in
            tableView.allowsSelection = false
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath ) as? ExerciseListTableViewCell
            cell?.update(exercise: exercise)
            return cell
        })
        updateDataSource()
    }
    func addExercise(exercise: Exercise) {
        exercises.append(exercise)
        updateDataSource()
    }
    
    func updateExercise(exercise: Exercise) {
      
        let exerciseIndex = exercises.firstIndex { (index) -> Bool in
            index == editingExercise
        }
        guard exerciseIndex != nil else {
            return
        }
        exercises[exerciseIndex!] = exercise
    }
    
    func updateDataSource() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
        snapshot.appendSections([.one])
        snapshot.appendItems(exercises)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil )
    }
    
    func deleteExercise(exercise: Exercise) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([exercise])
        exercises.removeAll { (exerciseIndex) -> Bool in
            exerciseIndex == exercise
        }
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    @IBAction func addExerciseButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addExercise", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddExerciseViewController else { return }
        destination.delegate = self
            
        if segue.identifier == "editExercise" {
            guard let exerciseData = self.dataSource.itemIdentifier(for: sender as! IndexPath) else { return }
            
            editingExercise = exerciseData
            
            destination.exerciseNameTextFieldPlaceHolder = exerciseData.name
            destination.repsTextFieldPlaceHolder = exerciseData.reps
            destination.timeGoalTextFieldPlaceHolder = exerciseData.reps
            destination.requiresEquiptmentPlaceHolder = exerciseData.requiresEquipment == true ? 0 : 1
            destination.descriptionTextViewPlaceHolder = exerciseData.description
            destination.muscleGroupPickerStatePlaceHolder = exerciseData.muscle
            destination.isEdit = true
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            guard let exercise = self.dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            self.deleteExercise(exercise: exercise)
            completion(true)
        }
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editExercise", sender: indexPath)
    }
}

class DataSource: UITableViewDiffableDataSource<Section, Exercise> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
