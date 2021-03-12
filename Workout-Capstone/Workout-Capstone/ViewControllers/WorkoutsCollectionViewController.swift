//
//  WorkoutsCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/11/21.
//

import UIKit

enum Section {
    case one
}
class WorkoutsCollectionViewController: UICollectionViewController {
    var dataSource: UICollectionViewDiffableDataSource<Section,Workout>!
    var workouts = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workouts.append(Workout(name: "Name", image: nil, timer: nil, exercises: nil, requiresEquipment: nil))
        workouts.append(Workout(name: "Name 2", image: nil, timer: nil, exercises: nil, requiresEquipment: nil))
        workouts.append(Workout(name: "Name 3", image: nil, timer: nil, exercises: nil, requiresEquipment: nil))
        workouts.append(Workout(name: "Name 4", image: nil, timer: nil, exercises: nil, requiresEquipment: nil))

        collectionView.collectionViewLayout = configureCollectionViewLayout()
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, workout) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workoutCell", for: indexPath) as! WorkoutCollectionViewCell
            cell.update(workout: workout)
            return cell
        })
        updateDataSource()
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 5, bottom: 8, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(166))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
                
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func updateDataSource() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Workout>()
        snapshot.appendSections([.one])
        snapshot.appendItems(workouts)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil )
    }
}
