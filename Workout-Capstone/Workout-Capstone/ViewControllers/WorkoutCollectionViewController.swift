//
//  WorkoutCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 4/2/21.
//

import UIKit
import AVFoundation

enum CollectionViewSection {
    case main
}

class WorkoutCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    let systemSoundID: SystemSoundID = 1005
    
    
    var workout: Workout!
    lazy var exercises = self.workout.exercises?.compactMap { Exercise(exerciseData: $0, id: UUID())} ?? []
    var dataSource: ExerciseDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 10
        startButtonState()
        startButton.setTitle("DELETE EXERCISE", for: .highlighted)
        
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        collectionView.allowsSelection = false
        collectionView.allowsSelectionDuringEditing = false
        
        configureDataSource()
        collectionView.dataSource = dataSource
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonAction(_:)))
        let editButton = editButtonItem
        editButton.primaryAction = UIAction(title: "Edit") { _ in
            self.setEditing(!self.isEditing, animated: true)
        }
        
        navigationItem.rightBarButtonItems = [addButton, editButton]
        titleTextField.text = "\(workout.name)"
        titleTextField.isEnabled = false
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "displaySegue", sender: nil)
    }
    
    func configureDataSource() {
        
        dataSource = ExerciseDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, exercise) -> UICollectionViewCell? in
            
            collectionView.allowsSelection = false
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as! ExerciseCollectionViewCell
            let exerciseData = exercise.exerciseData
            if indexPath.row == self.exercises.count {
                
            } else {
                
                cell.exerciseNameLabel.text = exerciseData.name
                cell.exerciseTimeLabel.text = "Timer: \(exerciseData.timeGoal ?? 0) seconds"
                if exerciseData.reps == nil {
                    cell.repCountLabel.text = "Reps: 1"
                } else {
                    cell.repCountLabel.text = "Reps: \(exerciseData.reps!)"
                }
            }
            let reorder = UICellAccessory.reorder()
            cell.accessories = [reorder]
            self.dataSource.reorderingHandlers.canReorderItem = { indexPath in true }
            
            return cell
            
        })
        updateDataSource()
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { [self] (indexPath) in // possible crash
            
            guard let exercise = dataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
                DispatchQueue.main.async {
                    deleteExercise(exercise: exercise)
                    completion(true)
                }
                
            }
            deleteAction.backgroundColor = .systemRed
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, Exercise>()
        snapshot.appendSections([.main])
        snapshot.appendItems(exercises)
        updateWorkoutAdd(isAdd: true, exercise: nil)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        startButtonState()
    }
    
    func updateWorkoutAdd(isAdd: Bool, exercise: Exercise?) {
        guard isAdd == true else {
            workout.exercises?.removeAll(where: { (removeExercise) -> Bool in
                removeExercise == exercise?.exerciseData
            })
            return
        }
        for exercise in exercises {
            workout.exercises?.append(exercise.exerciseData)
        }
    }
    func deleteExercise(exercise: Exercise) {
        exercises.removeAll(where: { (deleteExercise) -> Bool in
            exercise == deleteExercise
        })
        updateWorkoutAdd(isAdd: false, exercise: exercise)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([exercise])
        dataSource.apply(snapshot, animatingDifferences: true)
        startButtonState()
    }
    
    func startButtonState() {
        guard exercises.count != 0 else {
            startButton.isEnabled = false
            startButton.backgroundColor = .gray
            return
        }
        startButton.isEnabled = true
        startButton.backgroundColor = .systemBlue
    }
    
    @objc func addButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "addExerciseSegue", sender: nil)
        //AudioServicesPlaySystemSound(systemSoundID)
        
    }
    
    @IBAction func unwindToWorkout(segue: UIStoryboardSegue) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.collectionView.isEditing = editing
        
        if editing == true {
            titleTextField.isEnabled = true
            titleTextField.becomeFirstResponder()
            startButton.isHighlighted = true
            startButton.backgroundColor = .red        } else {
            titleTextField.isEnabled = false
            titleTextField.resignFirstResponder()
            startButton.isHighlighted = false
            startButton.backgroundColor = .systemBlue
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExerciseListTableViewController  {
            
            destination.isModal = true
            ExerciseListTableViewController.isNotModal = false
            destination.workoutCollectionViewController = self
        } else if let destination = segue.destination as? WorkoutsDisplayViewController {
            destination.workout = workout
        }
        
    }
    
    
    
    @IBAction func titleChanged(_ sender: Any) {
        if titleTextField.text == "" {
            editButtonItem.isEnabled = false
        } else {
            editButtonItem.isEnabled = true
        }
    }
}

class ExerciseDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, Exercise> {
    
}



