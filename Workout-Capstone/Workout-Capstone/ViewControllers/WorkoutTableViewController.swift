//
//  WorkoutTableViewController.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/12/21.
//

import UIKit



class WorkoutTableViewController: UITableViewController {
    
    var exercises = [Exercise]()
    var dataSource: ExerciseDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for num in 1...10 {
            var exercise = Exercise()
            exercise.image = UIImage(systemName: "person.fill")
            exercise.name = "Exercise \(num)"
            exercise.reps = 420
            exercises.append(exercise)
        }
                
        configureDataSource()
    }
    
    
    func configureDataSource() {
        dataSource = ExerciseDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, exercise) -> UITableViewCell? in
            tableView.allowsSelection = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! WorkoutExercisesTableViewCell
            
            cell.exerciseNameLabel.text = exercise.name
            cell.exerciseTimeLabel.text = "\(exercise.timer)"
            cell.exerciseImageView.image = exercise.image
            cell.repCountLabel.text = "\(exercise.reps)"
            
            return cell
            
        })
        updateDataSource()
    }
    
    func deleteExercise(exercise: Exercise) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([exercise])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
        let section = Section.main
        snapshot.appendSections([section])
        snapshot.appendItems(exercises, toSection: section)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    //MARK: - TableView Func
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            guard let exercise = self.dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            self.deleteExercise(exercise: exercise)
            
        }
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
}


class ExerciseDataSource: UITableViewDiffableDataSource<WorkoutTableViewController.Section, Exercise> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension WorkoutTableViewController {
     enum Section {
        case main
    }
}

