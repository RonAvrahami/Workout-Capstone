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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, exercise) -> UITableViewCell? in
            tableView.allowsSelection = false
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath ) as? ExerciseListTableViewCell
            cell?.update(exercise: exercise)
            return cell
        })
        updateDataSource()
    }
    func updateExercises(exercise: Exercise) {
        exercises.append(exercise)
        
        updateDataSource()
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
        guard segue.identifier == "addExercise" else {
            return
        }
        guard let destination = segue.destination as? AddExerciseViewController else {
            return
        }
        destination.delegate = self
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
        
    }
}

class DataSource: UITableViewDiffableDataSource<Section, Exercise> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
