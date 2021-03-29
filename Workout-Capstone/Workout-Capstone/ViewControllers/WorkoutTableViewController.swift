//
//  WorkoutTableViewController.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 3/12/21.
//

import UIKit



class WorkoutTableViewController: UITableViewController {
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var workout: Workout!
    var exercises = [Exercise]()
    var dataSource: ExerciseDataSource!
    var tableViewIsEditing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
        startButton.setBackgroundColor(color: .systemGray, forState: .disabled)
        startButton.setTitleColor(.lightGray, for: .disabled)
        if let exercises = workout.exercises {
            for exercise in exercises {
                self.exercises.append(Exercise(exerciseData: exercise, id: UUID()))
            }
        }
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonAction(_:)))
        
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        
        //UIBarButtonItem(title: "Quit", style: .plain, target: nil, action: nil)
        
        headerTextField.text = workout.name
        configureDataSource()
    }
    
    
    func configureDataSource() {
        dataSource = ExerciseDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, exercise) -> UITableViewCell? in
            tableView.allowsSelection = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! WorkoutExercisesTableViewCell
            let exerciseData = exercise.exerciseData
            cell.exerciseNameLabel.text = exerciseData.name
            cell.exerciseTimeLabel.text = "Timer: \(exerciseData.timeGoal ?? 0) seconds"
            
            if exerciseData.reps == nil {
                cell.repCountLabel.text = "Reps: 1"
            } else {
                cell.repCountLabel.text = "Reps: \(exerciseData.reps!)"
            }
            
            return cell
            
        })
        updateDataSource()
    }
    
    func deleteExercise(exercise: Exercise) {
        exercises.removeAll(where: { (deleteExercise) -> Bool in
            exercise == deleteExercise
        })
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([exercise])
        dataSource.apply(snapshot, animatingDifferences: true)
        enableStartButton()
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
        let section = Section.main
        snapshot.appendSections([section])
        snapshot.appendItems(exercises, toSection: section)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        enableStartButton()
    }
    func enableStartButton() {
        guard exercises.count != 0 else {
            DispatchQueue.main.async {
                self.startButton.isEnabled = false
            }
            return
        }
        DispatchQueue.main.async {
            self.startButton.isEnabled = true
        }
    }
    
    @IBAction func startWorkoutButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "displaySegue", sender: nil)
        
    }
    
    
    @objc func addButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "addExerciseSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExerciseListTableViewController  {
            
            destination.isModal = true
            destination.workoutTableViewController = self
        } else if let destination = segue.destination as? WorkoutsDisplayViewController {
            destination.workout = workout
        }
        
    }
    //MARK: - TableView Func
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
        if headerTextField.text == "" {
            
        }
        if editing == false {

            headerTextField.isEnabled = false
            headerTextField.resignFirstResponder()
        }
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
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension WorkoutTableViewController {
    enum Section {
        case main
    }
}
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
