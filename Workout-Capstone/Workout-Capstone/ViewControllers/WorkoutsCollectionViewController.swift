//
//  WorkoutsCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/11/21.
//

import UIKit

enum Section {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
}

enum SupplementaryViewKind {
    static let header = "header"
    static let topLine = "topLine"
    static let buttomLine = "buttomLine"
}

class WorkoutsCollectionViewController: UICollectionViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section,Workout>!
    var builtInWorkouts = BuiltInWorkouts()
    
    
    
    var workoutsOne = [Workout]()
    var workoutsTwo = [Workout]()
    var workoutsThree = [Workout]()
    var workoutsFour = [Workout]()
    var workoutsFive = [Workout]()
    var workoutsSix = [Workout]()
    var workoutsSeven = [Workout]()
 
    var sections = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutsThree.append(builtInWorkouts.workout1)
        workoutsFour.append(builtInWorkouts.workout2)
        workoutsTwo.append(builtInWorkouts.workout3)
        workoutsSix.append(builtInWorkouts.workout4)

        collectionView.collectionViewLayout = configureCollectionViewLayout()
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.topLine, withReuseIdentifier: LineView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.buttomLine, withReuseIdentifier: LineView.reuseIdentifier)
        
        configureDataSource()
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sharedItemContentInset = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(44))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: SupplementaryViewKind.header, alignment: .top)
            headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            
            let lineItemHeight = 1 / layoutEnvironment.traitCollection.displayScale
            let lineItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(lineItemHeight))
            let topLineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: SupplementaryViewKind.topLine, alignment: .top)
            let buttonLineItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: lineItemSize, elementKind: SupplementaryViewKind.buttomLine, alignment: .bottom)
            
            topLineItem.contentInsets = sharedItemContentInset
            buttonLineItem.contentInsets = sharedItemContentInset
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 8, leading: 5, bottom: 8, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(166))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = [headerItem]
            
            return section
        }
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, workout) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workoutCell", for: indexPath) as! WorkoutCollectionViewCell
            cell.update(workout: workout)
            return cell
        })
        dataSource.supplementaryViewProvider =  { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            switch kind {
            case SupplementaryViewKind.header:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
                
                let section = self.sections[indexPath.section]
                let sectionName: String
                
                switch section {
                case .one:
                    sectionName = "My Workouts"
                case .two:
                    sectionName = "Arms"
                case .three:
                    sectionName = "Back"
                case .four:
                    sectionName = "Legs"
                case .five:
                    sectionName = "Shoulders"
                case .six:
                    sectionName = "Chest"
                case .seven:
                    sectionName = "Core"
                }
                
                headerView.setTitle(sectionName)
                return headerView
                
            case SupplementaryViewKind.topLine, SupplementaryViewKind.buttomLine:
                let lineView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LineView.reuseIdentifier, for: indexPath) as! LineView
                return lineView
                
            default:
                return nil
            }
        }
        updateDataSource()
    }
    
    func updateDataSource() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Workout>()
        snapshot.appendSections([.one])
        snapshot.appendItems(workoutsOne)
        
        snapshot.appendSections([.two])
        snapshot.appendItems(workoutsTwo)
        
        snapshot.appendSections([.three])
        snapshot.appendItems(workoutsThree)
        
        snapshot.appendSections([.four])
        snapshot.appendItems(workoutsFour)
        
        snapshot.appendSections([.five])
        snapshot.appendItems(workoutsFive)
        
        snapshot.appendSections([.six])
        snapshot.appendItems(workoutsSix)
        
        snapshot.appendSections([.seven])
        snapshot.appendItems(workoutsSeven)
    
        sections = snapshot.sectionIdentifiers

        dataSource.apply(snapshot, animatingDifferences: true, completion: nil )
    }
}
