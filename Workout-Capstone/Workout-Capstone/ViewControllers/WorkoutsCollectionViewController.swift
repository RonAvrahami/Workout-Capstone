//
//  WorkoutsCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/11/21.
//

import UIKit

enum Section {
    case custom
    case arms
    case back
    case legs
    case shoulders
    case chest
    case core
}

enum SupplementaryViewKind {
    
    static let header = "header"
    static let topLine = "topLine"
    static let buttomLine = "buttomLine"
}

class WorkoutsCollectionViewController: UICollectionViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section,Workout>!
    var builtInWorkouts = BuiltInWorkouts()
    var jsonManager = JSONManager()
    
    var customWorkoutArray = [Workout]()
    var customWorkouts = [Workout]()
    var armWorkouts = [Workout]()
    var backWorkouts = [Workout]()
    var legWorkouts = [Workout]()
    var shoulderWorkouts = [Workout]()
    var chestWorkouts = [Workout]()
    var coreWorkouts = [Workout]()
    
    var customWorkoutObjects = [WorkoutObject]()
    var armWorkoutObjects = [WorkoutObject]()
    var backWorkoutObjects = [WorkoutObject]()
    var legWorkoutObjects = [WorkoutObject]()
    var shoulderWorkoutObjects = [WorkoutObject]()
    var chestWorkoutObjects = [WorkoutObject]()
    var coreWorkoutObjects = [WorkoutObject]()
    
    var sections = [Section]()
    var newWorkoutName: String?
    var workoutsArray = [[Workout]]()
    var workoutObjectsArray = [[WorkoutObject]]()
    let customWorkoutPlaceholder: Workout = Workout(workoutObject: WorkoutObject(name: "New Workout", imageData: Data(), time: nil, exercises: nil, requiresEquipment: nil, id: UUID()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [self] in
                        
            guard let workoutObjects = jsonManager.readWorkoutsFromDisk()?.workouts else {
                loadBuiltInWorkouts()
                
                writeToDisk()
                
                return
            }
            
            parseFromDisk(workoutObjects: workoutObjects)
        }
        
        collectionView.backgroundColor = UIColor(named: "customLightCream")
        navigationController?.navigationBar.barTintColor = UIColor(named: "customLightGray")
        tabBarController?.tabBar.barTintColor = UIColor(named: "customLightGray")
        
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.topLine, withReuseIdentifier: LineView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.buttomLine, withReuseIdentifier: LineView.reuseIdentifier)
        
        configureDataSource()
    }
    
    func writeToDisk() {
        
        for workouts in workoutsArray {
            
            var workoutObjects = [WorkoutObject]()
            for workout in workouts {
                let workoutObject = workout.workoutObject
                workoutObjects.append(WorkoutObject(name: workoutObject.name, imageData: workoutObject.imageData, time: workoutObject.time, exercises: workoutObject.exercises, requiresEquipment: workoutObject.requiresEquipment, id: workoutObject.id))
            }
            workoutObjectsArray.append(workoutObjects)
        }
        var customWorkoutsJson = workoutObjectsArray[6]
        customWorkoutsJson.removeAll { (workout) -> Bool in
            workout == customWorkoutPlaceholder.workoutObject
        }
        let writtenWorkouts = JSONWorkouts(armArray: workoutObjectsArray[0], backArray: workoutObjectsArray[1], legArray: workoutObjectsArray[2], chestArray: workoutObjectsArray[3], coreArray: workoutObjectsArray[4], shoulderArray: workoutObjectsArray[5], customWorkout: customWorkoutsJson)
       
        jsonManager.writeWorkoutsToDisk(workout: writtenWorkouts)

        parseFromDisk(workoutObjects: workoutObjectsArray)
    }
    
    func parseFromDisk(workoutObjects: [[WorkoutObject]]) {
        
        workoutsArray.removeAll()
        
        for workoutObjects in workoutObjects {
            var workoutArray = [Workout]()
            for workoutObject in workoutObjects {
                workoutArray.append(Workout(workoutObject: workoutObject))
            }
            workoutsArray.append(workoutArray)
        }
        
        guard workoutsArray.count == 7 else {
            return
        }
        
        armWorkouts = (workoutsArray[0])
        backWorkouts = (workoutsArray[1])
        legWorkouts = (workoutsArray[2])
        chestWorkouts = (workoutsArray[3])
        coreWorkouts = (workoutsArray[4])
        shoulderWorkouts = (workoutsArray[5])
        customWorkouts = [customWorkoutPlaceholder]
        customWorkouts.append(contentsOf: workoutsArray[6])
        
        updateDataSource()
    }
    
    func loadBuiltInWorkouts() {
        
        workoutsArray.removeAll()
        
        customWorkoutArray.removeAll()
        armWorkouts.append(contentsOf: builtInWorkouts.armArray)
        backWorkouts.append(contentsOf: builtInWorkouts.backArray)
        legWorkouts.append(contentsOf: builtInWorkouts.legArray)
        chestWorkouts.append(contentsOf: builtInWorkouts.chestArray)
        coreWorkouts.append(contentsOf: builtInWorkouts.coreArray)
        shoulderWorkouts.append(contentsOf: builtInWorkouts.shoulderArray)
        customWorkouts.append(contentsOf: customWorkoutArray)
        
        workoutsArray = [armWorkouts, backWorkouts, legWorkouts, chestWorkouts, coreWorkouts, shoulderWorkouts, customWorkouts]
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
            cell.update(workout: workout, section: self.sections[indexPath.section], indexPath: indexPath)
            return cell
        })
        dataSource.supplementaryViewProvider =  { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            switch kind {
            case SupplementaryViewKind.header:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
                
                let section = self.sections[indexPath.section]
                let sectionName: String
                
                switch section {
                case .custom:
                    sectionName = "My Workouts"
                case .arms:
                    sectionName = "Arms"
                case .back:
                    sectionName = "Back"
                case .legs:
                    sectionName = "Legs"
                case .shoulders:
                    sectionName = "Shoulders"
                case .chest:
                    sectionName = "Chest"
                case .core:
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
        
        snapshot.appendSections([.custom])
        snapshot.appendItems(customWorkouts)
        
        snapshot.appendSections([.arms])
        snapshot.appendItems(armWorkouts)
        
        snapshot.appendSections([.back])
        snapshot.appendItems(backWorkouts)
        
        snapshot.appendSections([.legs])
        snapshot.appendItems(legWorkouts)
        
        snapshot.appendSections([.shoulders])
        snapshot.appendItems(shoulderWorkouts)
        
        snapshot.appendSections([.chest])
        snapshot.appendItems(chestWorkouts)
        
        snapshot.appendSections([.core])
        snapshot.appendItems(coreWorkouts)
        
        sections = snapshot.sectionIdentifiers
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func newWorkoutAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "New Workout", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        let repsTextField = alert.textFields![0]
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [self] (_) in
            newWorkoutName = repsTextField.text!
            performSegue(withIdentifier: "newWorkoutSegue", sender: indexPath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        self.present(alert, animated: true, completion: nil)    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            newWorkoutAlert(indexPath: indexPath)
        } else {
            performSegue(withIdentifier: "workoutSegue", sender: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            
            guard let workout = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
            
            let startOnWatch = UIAction(title: "Start on Watch") { (_) in
                
                DispatchQueue.main.async {
                    MemoryLayout.size(ofValue: self.backWorkouts.first!)
                    WatchConnectivityHelper.sharedInstance.sendToWatch(workout: self.backWorkouts.first!)
                }
                print(workout.workoutObject.name)
            }
            
            let startOnIphone = UIAction(title: "Start on iPhone") { (_) in
                
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [startOnWatch, startOnIphone])
        }
        
        return config
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? WorkoutCollectionViewController else {
            return
        }
        if let workout = dataSource.itemIdentifier(for: sender as! IndexPath) {
            var newWorkout = workout
            
            if segue.identifier == "newWorkoutSegue" {
                
                newWorkout.workoutObject.name = newWorkoutName ?? "Error"
                newWorkout.workoutObject.imageData = UIImage(named: "customWorkoutImage")?.pngData() ?? Data()
                newWorkout.workoutObject.id = UUID()
                
                customWorkouts.append(newWorkout)
                workoutsArray[6].append(newWorkout)
                
                DispatchQueue.main.async { [self] in
                    if workoutsArray.count != 7 {
                        loadBuiltInWorkouts()
                    }
                    writeToDisk()
                }
            }
            destination.workout = newWorkout
        }
    }
}
