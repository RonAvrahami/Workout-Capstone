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
    
    var jsonManager = JSONManager()

    var exercises = [Exercise]()
    var dataSource: DataSource!
    var editingExercise: Exercise?
    var senderIndexPath: IndexPath?
    var workoutCollectionViewController: WorkoutCollectionViewController?
    var searchExercises = [Exercise]()
    var allExercises = [Exercise]()
    var isModal = false
    static var isNotModal = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExerciseListTableViewController.isNotModal = !isModal
        searchBar.delegate = self
        navigationItem.rightBarButtonItems!.append(editButtonItem)
        tableView.delegate = self
        
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, exercise) -> UITableViewCell? in
            tableView.allowsSelection = false

            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath ) as? ExerciseListTableViewCell
            cell?.update(exercise: exercise, isModal: self.isModal, exerciseListTableViewController: self)
            if self.isModal == true {
                cell?.accessoryType = .none
            }
            return cell
        })
        readFromDisk()
    }
    
    func writeToDisk() {
        jsonManager.writeExercisesToDisk(exercises: exercises)
        readFromDisk()
    }
    func readFromDisk() {
        exercises = jsonManager.readExercisesFromDisk() ?? setExercises()
        allExercises = exercises
        updateDataSource()
    }
    
    
    
    func addExercise(exercise: Exercise) {
        exercises.append(exercise)
        writeToDisk()
        updateDataSource()
    }
    
    func updateExercise(exercise: Exercise) {
        
        exercises[senderIndexPath!.row] = exercise
        writeToDisk()
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
        
        writeToDisk()
    }
    
    func setExercises() -> [Exercise] {
        var exercisesArray = [Exercise]()
        for exercise in builtInExercises {
            exercisesArray.append(Exercise(exerciseData: exercise, id: UUID()))
        }
        return exercisesArray
    }
    
    func addToTableview(exercise: Exercise) {
        
        workoutCollectionViewController?.updateDataSource(newExercise: exercise.exerciseData)
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
            destination.timeGoalTextFieldPlaceHolder = exerciseData.timeGoal
            destination.requiresEquiptmentPlaceHolder = exerciseData.requiresEquipment == true ? 0 : 1
            destination.descriptionTextViewPlaceHolder = exerciseData.description
            destination.muscleGroupPickerStatePlaceHolder = exerciseData.muscle
            
            destination.isEdit = true
            
        }
    }
    
    func addAlert(exercise: Exercise) {
        let alert = UIAlertController(title: exercise.exerciseData.name, message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Add Custom", style: .default) { (_) in
            self.addCustomAlert(exercise: exercise)
        }
        let addDefualtAction = UIAlertAction(title: "Add defualt", style: .default) { (_) in
            self.addToTableview(exercise: exercise)
            self.dismissModal()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(cancelAction)
        alert.addAction(addDefualtAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addCustomAlert(exercise: Exercise) {
        let alert = UIAlertController(title: exercise.exerciseData.name, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Enter reps"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter time goal"
        }
        let repsTextField = alert.textFields![0]
        let timeGoalTextField = alert.textFields![1]
        repsTextField.keyboardType = .numberPad
        timeGoalTextField.keyboardType = .numberPad
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            var editedExercise = exercise
            editedExercise.exerciseData.reps = Int(repsTextField.text!) ?? 0
            editedExercise.exerciseData.timeGoal = Int(timeGoalTextField.text!) ?? 0
            self.addToTableview(exercise: editedExercise)
            self.dismissModal()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText != "" else {
            exercises = allExercises
            updateDataSource()
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
        
        let splitText = searchText.split(separator: " ")
        
        
        for exercise in exercises {
            let formatName = exercise.exerciseData.name.replacingOccurrences(of: "-", with: " ")
            var matchCount = 0
            for searchWord in splitText {
                if exercise.exerciseData.name.lowercased().contains(searchWord) || formatName.lowercased().contains(searchWord) {
                    matchCount += 1
                    guard !searchExercises.contains(exercise) else {
                        return
                    }
                    if matchCount == splitText.count {
                        self.searchExercises.append(exercise)
                    }
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
        return ExerciseListTableViewController.isNotModal
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
