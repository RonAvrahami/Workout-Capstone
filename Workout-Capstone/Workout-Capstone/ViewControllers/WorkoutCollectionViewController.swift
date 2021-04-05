//
//  WorkoutCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 4/2/21.
//

import UIKit

class WorkoutCollectionViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    
    var workout: Workout!
    var exercises = [Exercise]()
    var dataSource: ExerciseDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonAction(_:)))
        
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
       
       configureDataSource()
        

       
    }
    
    @objc func addButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "addExerciseSegue", sender: nil)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
//    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
//        <#code#>
//    }
//    func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
//        <#code#>
//    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        setEditing(true, animated: true)
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
            
            return cell
            
        })
        updateDataSource()
    }
    
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Exercise>()
        let section = Section.main
        snapshot.appendSections([section])
        snapshot.appendItems(exercises, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    class ExerciseDataSource: UICollectionViewDiffableDataSource<WorkoutCollectionViewController.Section, Exercise> {
        
    }
   
}


