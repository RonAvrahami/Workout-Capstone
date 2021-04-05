//
//  WorkoutCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 4/2/21.
//

import UIKit

enum CollectionViewSection {
    case main
}

class WorkoutCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var workout: Workout!
    lazy var exercises = self.workout.exercises?.compactMap { Exercise(exerciseData: $0, id: UUID())} ?? []
    var dataSource: ExerciseDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        
        configureDataSource()
        collectionView.dataSource = dataSource
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonAction(_:)))
        
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        
        
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
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, Exercise>()
        snapshot.appendSections([.main])
        snapshot.appendItems(exercises)
        
        dataSource.apply(snapshot, animatingDifferences: true)
        
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
    
}
class ExerciseDataSource: UICollectionViewDiffableDataSource<CollectionViewSection, Exercise> {
    
}


