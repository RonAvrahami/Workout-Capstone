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

protocol saveExerciseDelegate {
    func setWorkout(workout: Workout)
}

class WorkoutCollectionViewController: UIViewController, UICollectionViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    

    let systemSoundID: SystemSoundID = 1005
    // MARK: Varibles
    var seconds = 0
    var timer = Timer()
    var timeStarted = Bool()
    static var delegate: saveExerciseDelegate!

    var workout: Workout!
    var exerciseDatas = [ExerciseData]()
    
    lazy var exercises = self.workout.workoutObject.exercises?.compactMap { Exercise(exerciseData: $0, id: UUID())} ?? []
    var dataSource: ExerciseDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        exercises = []
        exerciseDatas = workout.workoutObject.exercises ?? []
        
        startButton.layer.cornerRadius = 10
        startButtonState()
        
        // MARK: Long press
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 0.3
        longPressGesture.delegate = self
        longPressGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressGesture)
        
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        collectionView.allowsSelection = false
        collectionView.allowsSelectionDuringEditing = false
        navigationController?.navigationBar.tintColor = UIColor(named: "customOragne")

        configureDataSource()
        collectionView.dataSource = dataSource
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonAction(_:)))
        let editButton = editButtonItem
        editButton.primaryAction = UIAction(title: "Edit") { _ in
            self.setEditing(!self.isEditing, animated: true)
        }
        
        navigationItem.rightBarButtonItems = [addButton]
        titleTextField.text = "\(workout.workoutObject.name)"
        titleTextField.resignFirstResponder()
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        titleTextField.isEnabled = true
        
        updateDataSource(newExercise: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard var passableWorkout = workout else {
            return
        }
        
        passableWorkout.workoutObject.exercises = exerciseDatas
        
        WorkoutCollectionViewController.delegate.setWorkout(workout: passableWorkout)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "displaySegue", sender: nil)
        //AudioServicesPlaySystemSound(systemSoundID)
        if timeStarted == false {
            createWorkoutTimer()
        }
    }
    
    func configureDataSource() {
        
        dataSource = ExerciseDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, exercise) -> UICollectionViewCell? in
            
            collectionView.allowsSelection = false
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as! ExerciseCollectionViewCell
            let exerciseData = exercise.exerciseData
            if indexPath.row == self.exercises.count {
                
            } else {
                cell.exerciseNameLabel.text = exerciseData.name
                cell.exerciseTimeLabel.text = "Timer: \(exerciseData.timeGoal) seconds"
                cell.repCountLabel.text = "Reps: \(exerciseData.reps)"
            }
            // MARK: Accessories
            cell.accessories = [
                .reorder(displayed: .always)
            ]
            self.dataSource.reorderingHandlers.canReorderItem = { indexPath in
                return true
            }
            self.dataSource.reorderingHandlers.didReorder = { [self] transaction in
                workout.workoutObject.exercises = transaction.finalSnapshot.itemIdentifiers.map({ $0.exerciseData })
                exerciseDatas = workout.workoutObject.exercises ?? []
            }
            return cell
        })
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
    
    func updateDataSource(newExercise: ExerciseData?) {
                
        if let addedExercise = newExercise {
            exerciseDatas.append(addedExercise)
        }
        exercises.removeAll()
        for exerciseData in exerciseDatas {
            exercises.append(Exercise(exerciseData: exerciseData, id: UUID()))
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, Exercise>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(exercises)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        startButtonState()
    }
    
    
    func deleteExercise(exercise: Exercise) {
        exerciseDatas.removeAll(where: { (removeExercise) -> Bool in
            removeExercise == exercise.exerciseData
        })
        
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
        startButton.backgroundColor = UIColor(named: "customOragne")
    }
    
    @objc func addButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "addExerciseSegue", sender: nil)
    }
    
    @IBAction func unwindToWorkout(segue: UIStoryboardSegue) {
        
    }
    // MARK: collectionView Funcs
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
            guard var passableWorkout = workout else {
                return
            }
            passableWorkout.workoutObject.exercises = exerciseDatas

            destination.workout = passableWorkout
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateDataSource(newExercise: nil)
    }
    
    @objc func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        switch (gestureRecognizer.state) {
        
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gestureRecognizer.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gestureRecognizer.location(in: gestureRecognizer.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
   
    func createWorkoutTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutCollectionViewController.updateTimer), userInfo: nil, repeats: true)
        timeStarted = true
        
    }
    @objc func updateTimer() {
        seconds += 1
    }
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    @IBAction func titleChanged(_ sender: Any) {
        if titleTextField.text == "" {
            editButtonItem.isEnabled = false
            workout.workoutObject.name = titleTextField.text!
        } else {
            editButtonItem.isEnabled = true
        }
    }
}

class ExerciseDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, Exercise> {

}



