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
class ExerciseListTableViewController: UITableViewController, AddExerciseProtocal, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var exercises = [Exercise]()
    var dataSource: DataSource!
    var editingExercise: Exercise?
    var senderIndexPath: IndexPath?
    var isModal = false
    var workoutTableViewController: WorkoutTableViewController?
    var searchExercises = [Exercise]()
    var allExercises = [Exercise]()
    var isRepeat = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.delegate = self
        
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, exercise) -> UITableViewCell? in
            tableView.allowsSelection = false
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath ) as? ExerciseListTableViewCell
            cell?.update(exercise: exercise, isModal: self.isModal, exerciseListTableViewController: self)
            return cell
        })
        setExercises()
        allExercises = exercises
    }
    func addExercise(exercise: Exercise) {
        exercises.append(exercise)
        updateDataSource()
    }
    
    func updateExercise(exercise: Exercise) {
        
        exercises[senderIndexPath!.row] = exercise        
        updateDataSource()
        
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
        snapshot.appendSections([.custom])
        snapshot.appendItems(exercises)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func deleteExercise(exercise: Exercise) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([exercise])
        exercises.removeAll { (exerciseIndex) -> Bool in
            exerciseIndex == exercise
        }
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func setExercises() {
        for exercise in builtInExercises {
            exercises.append(Exercise(exerciseData: exercise, id: UUID()))
        }
        DispatchQueue.main.async {
            self.updateDataSource()
        }
    }
    
    func addToTableview(exercise: Exercise) {
        workoutTableViewController?.exercises.append(exercise)
        
        workoutTableViewController?.workout.exercises?.append(exercise.exerciseData)
        
        workoutTableViewController?.updateDataSource()
        setExercises()
    }
    
    func dismissModal() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addExerciseButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addExercise", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddExerciseViewController else { return }
        destination.delegate = self
        
        if segue.identifier == "editExercise" {
            guard let exercise = self.dataSource.itemIdentifier(for: sender as! IndexPath) else { return }
            
            senderIndexPath = sender as? IndexPath
            editingExercise = exercise
            let exerciseData = exercise.exerciseData
            
            destination.exerciseNameTextFieldPlaceHolder = exerciseData.name
            destination.repsTextFieldPlaceHolder = exerciseData.reps
            destination.timeGoalTextFieldPlaceHolder = exerciseData.reps
            destination.requiresEquiptmentPlaceHolder = exerciseData.requiresEquipment == true ? 0 : 1
            destination.descriptionTextViewPlaceHolder = exerciseData.description
            destination.muscleGroupPickerStatePlaceHolder = exerciseData.muscle
            
            destination.isEdit = true
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText != "" else {
            exercises = allExercises
            return
        }
        
        searchFilter(searchText: searchText.lowercased()) { (searchedExercises) in
            
            self.exercises.removeAll()
            self.exercises.append(contentsOf: searchedExercises)
            DispatchQueue.main.async {
                self.updateDataSource()
            }
        }
    }


func searchFilter(searchText: String, completion: @escaping ([Exercise])->()) {
    exercises = allExercises
    searchExercises.removeAll()
    for exercise in exercises {
        
        if exercise.exerciseData.name!.lowercased().contains(searchText) {
            
            self.searchExercises.append(exercise)
            
        }
    }
    for exercise in exercises {
        if exercise.exerciseData.description!.lowercased().contains(searchText) {
            
            self.isRepeat = false
            for searchExercise in self.searchExercises {
                if exercise == searchExercise {
                    self.isRepeat = true
                }
            }
            if self.isRepeat == false {
                self.searchExercises.append(exercise)
            }
        }
    }
    completion(self.searchExercises)
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
