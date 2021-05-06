//
//  WorkoutsCollectionViewController.swift
//  Workout-Capstone
//
//  Created by Ron Avrahami on 3/11/21.
//

import UIKit

enum Section: Int, CaseIterable {
    case custom = 0
    case arms = 1
    case back = 2
    case legs = 3
    case chest = 4
    case core = 5
    case shoulders = 6
    
}

enum SupplementaryViewKind {
    
    static let header = "header"
    static let topLine = "topLine"
    static let buttomLine = "buttomLine"
}

class WorkoutsCollectionViewController: UICollectionViewController, saveExerciseDelegate {
    
    var dataSource: UICollectionViewDiffableDataSource<Section,Workout>!
    var builtInWorkouts = BuiltInWorkouts()
    var jsonManager = JSONManager()
    var watchHelper = WatchConnectivityHelper()
    
    var customWorkouts = [Workout]()
    var customArray = [Workout]()
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
    var customPlaceHolder = Workout(workoutObject: WorkoutObject(name: "New Workout", imageData: Data(), time: nil, exercises: nil, requiresEquipment: nil, id: UUID()))
    
    static var savedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WorkoutCollectionViewController.delegate = self
        
        DispatchQueue.main.async { [self] in
        
            guard let workoutObjects = jsonManager.readWorkoutsFromDisk()?.workouts else {
                loadBuiltInWorkouts()
                
                return
            }
            var dict = [Section:[WorkoutObject]]()
            for key in workoutObjects.keys {
                dict[Section.init(rawValue: key)!] = workoutObjects[key]
            }
            parseFromDisk(workoutObjectsDict: dict)
            
        }
        navigationController?.navigationBar.tintColor = UIColor(named: "customOragne")
        
//        collectionView.backgroundColor = UIColor(named: "")
        navigationController?.navigationBar.barTintColor = UIColor(named: "customLightGray")
        tabBarController?.tabBar.barTintColor = UIColor(named: "customLightGray")
        
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.topLine, withReuseIdentifier: LineView.reuseIdentifier)
        collectionView.register(LineView.self, forSupplementaryViewOfKind: SupplementaryViewKind.buttomLine, withReuseIdentifier: LineView.reuseIdentifier)
        
        configureDataSource()
    }
    
    func setWorkout(workout: Workout) {
        
        if let index = workoutsArray.firstIndex(where: { (workout) -> Bool in
            workout.contains(dataSource.itemIdentifier(for: WorkoutsCollectionViewController.savedIndexPath!)!)
        }) {
            
            workoutsArray[index][WorkoutsCollectionViewController.savedIndexPath!.row] = workout
        } else {
            if let newIndex = customWorkouts.firstIndex(where: { (workout) -> Bool in
                workout.workoutObject.id == workout.workoutObject.id
            }) {
                
                workoutsArray[0][newIndex] = workout
            }
        }
        DispatchQueue.main.async { [self] in
        updateDataSource()
        writeToDisk()
        }
    }
    
    func setWorkoutsArray(workoutObjectsDict: [Section: [WorkoutObject]]) {
        workoutsArray = [customWorkouts, armWorkouts, backWorkouts, legWorkouts, chestWorkouts, coreWorkouts, shoulderWorkouts]
        for workoutObjects in workoutObjectsDict {
            
            for workoutObject in workoutObjects.value {
                if !workoutsArray[workoutObjects.key.rawValue].contains(Workout(workoutObject: workoutObject)) {
                    workoutsArray[workoutObjects.key.rawValue].append(Workout(workoutObject: workoutObject))
                }
            }
        }
    }
    
    func updateDataSource() {
        
        if workoutsArray.count == 7 {
            customWorkouts = workoutsArray[Section.custom.rawValue]
            armWorkouts = workoutsArray[Section.arms.rawValue]
            backWorkouts = workoutsArray[Section.back.rawValue]
            legWorkouts = workoutsArray[Section.legs.rawValue]
            chestWorkouts = workoutsArray[Section.chest.rawValue]
            coreWorkouts = workoutsArray[Section.core.rawValue]
            shoulderWorkouts = workoutsArray[Section.shoulders.rawValue]
            workoutsArray = [customWorkouts, armWorkouts, backWorkouts, legWorkouts, chestWorkouts, coreWorkouts, shoulderWorkouts]
        }
        
        customArray.removeAll()
        customArray = [customPlaceHolder]
        customArray.append(contentsOf: customWorkouts)
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Workout>()
        
        snapshot.appendSections([.custom])
        snapshot.appendItems(customArray)
        
        snapshot.appendSections([.arms])
        snapshot.appendItems(armWorkouts)
        
        snapshot.appendSections([.back])
        snapshot.appendItems(backWorkouts)
        
        snapshot.appendSections([.legs])
        snapshot.appendItems(legWorkouts)
        
        snapshot.appendSections([.chest])
        snapshot.appendItems(chestWorkouts)
        
        snapshot.appendSections([.core])
        snapshot.appendItems(coreWorkouts)
        
        snapshot.appendSections([.shoulders])
        snapshot.appendItems(shoulderWorkouts)
        
        sections = snapshot.sectionIdentifiers
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
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
                case .chest:
                    sectionName = "Chest"
                case .core:
                    sectionName = "Core"
                case .shoulders:
                    sectionName = "Shoulders"
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
    
    func writeToDisk() {
        
        var workoutObjectsDict = [Section: [WorkoutObject]]()
        
        for index in 0..<workoutsArray.count {
            
            var workoutObjects = [WorkoutObject]()
            for workout in workoutsArray[index] {
                
                workoutObjects.append(workout.workoutObject)
            }
            
            workoutObjectsDict[Section.init(rawValue: index)!] = workoutObjects
            
            if workoutsArray[index] == workoutsArray.last {
                
                let writtenWorkouts = JSONWorkouts(customWorkout: workoutObjectsDict[.custom] ?? [],  armArray: workoutObjectsDict[.arms] ?? [], backArray: workoutObjectsDict[.back] ?? [], legArray: workoutObjectsDict[.legs] ?? [], chestArray: workoutObjectsDict[.chest] ?? [], coreArray: workoutObjectsDict[.core] ?? [], shoulderArray: workoutObjectsDict[.shoulders] ?? [])
                
                jsonManager.writeWorkoutsToDisk(workout: writtenWorkouts)
                parseFromDisk(workoutObjectsDict: workoutObjectsDict)
            }
        }
    }
    
    func parseFromDisk(workoutObjectsDict: [Section: [WorkoutObject]]) {
        
        setWorkoutsArray(workoutObjectsDict: workoutObjectsDict)
        var dict = workoutObjectsDict.count
        for workoutObjects in workoutObjectsDict {
            for workoutObject in workoutObjects.value {
                
                if !workoutsArray[workoutObjects.key.rawValue].contains(Workout(workoutObject: workoutObject)) {
                    workoutsArray[workoutObjects.key.rawValue].append(Workout(workoutObject: workoutObject))
                }
            }
            dict -= 1
            
            if dict == 0 {
                updateDataSource()
            }
        }
    }
    
    func loadBuiltInWorkouts() {
        
        workoutsArray.removeAll()
        customWorkouts.removeAll()
        armWorkouts.append(contentsOf: builtInWorkouts.armArray)
        backWorkouts.append(contentsOf: builtInWorkouts.backArray)
        legWorkouts.append(contentsOf: builtInWorkouts.legArray)
        chestWorkouts.append(contentsOf: builtInWorkouts.chestArray)
        coreWorkouts.append(contentsOf: builtInWorkouts.coreArray)
        shoulderWorkouts.append(contentsOf: builtInWorkouts.shoulderArray)
        workoutsArray = [customWorkouts, armWorkouts, backWorkouts, legWorkouts, chestWorkouts, coreWorkouts, shoulderWorkouts]
        writeToDisk()
    }
    
    func newWorkoutAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "New Workout", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter name"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            self.newWorkoutName = textField.text!
            self.performSegue(withIdentifier: "newWorkoutSegue", sender: indexPath)
        })
        
        addAction.isEnabled = false
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?[0], queue: OperationQueue.main) { (notification) in
            
            let textFieldName = alert.textFields![0]
            if let text = textFieldName.text?.replacingOccurrences(of: " ", with: "") {
                
                guard text.count < 17 && text != "" else {
                    addAction.isEnabled = false
                    return
                }
                addAction.isEnabled = true
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteWorkoutAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Workout?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.deleteWorkout(deleteWorkout: self.dataSource.itemIdentifier(for: indexPath)!)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteWorkout(deleteWorkout: Workout) {
        
        customWorkouts.removeAll { (workout) -> Bool in
            workout == deleteWorkout
        }
        workoutsArray[0] = customWorkouts
        updateDataSource()
        
        var readWorkouts = jsonManager.readWorkoutsFromDisk()
        
        readWorkouts?.customWorkout.removeAll()
        for workout in customWorkouts {
            readWorkouts?.customWorkout.append(workout.workoutObject)
        }
        
        DispatchQueue.main.async { [self] in
            jsonManager.writeWorkoutsToDisk(workout: readWorkouts!)
            
        }
    }
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func exerciseListButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "exerciseListSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? WorkoutCollectionViewController else {
            return
        }
        WorkoutsCollectionViewController.savedIndexPath = nil
        let indexPath = sender as! IndexPath
        
        if segue.identifier == "newWorkoutSegue" {
            let newWorkout = Workout(workoutObject: WorkoutObject(name: newWorkoutName ?? "Error", imageData: UIImage(named: "customWorkoutImage")?.pngData() ?? Data(), time: nil, exercises: nil, requiresEquipment: nil, id: UUID()))
            
            destination.workout = newWorkout
            workoutsArray[Section.custom.rawValue].append(newWorkout)
            updateDataSource()
            writeToDisk()
            
            guard indexPath.section == 0 else {
                WorkoutsCollectionViewController.savedIndexPath = indexPath
                
                return
            }
            let newIndex = IndexPath(row: customWorkouts.count - 1, section: 0)
            WorkoutsCollectionViewController.savedIndexPath = newIndex
            
        } else {
            destination.workout = dataSource.itemIdentifier(for: indexPath)
            guard indexPath.section == 0 else {
                WorkoutsCollectionViewController.savedIndexPath = indexPath
                return
            }
            let newIndex = IndexPath(row: indexPath.row - 1, section: 0)
            WorkoutsCollectionViewController.savedIndexPath = newIndex
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            newWorkoutAlert(indexPath: indexPath)
        } else {
            performSegue(withIdentifier: "workoutSegue", sender: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            return nil
        } else {
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
                
                guard let workout = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
                
                let startOnWatch = UIAction(title: "Start on Watch") { [self] (_) in
                    watchHelper.sendToWatch(workout: dataSource.itemIdentifier(for: indexPath)!)
                    print(workout.workoutObject.name)
                }
                
                let startOnIphone = UIAction(title: "Start on iPhone") { (_) in
                    
                }
                let deleteAction = UIAction(title: "Delete Workout", attributes: .destructive) { (_) in
                    self.deleteWorkoutAlert(indexPath: indexPath)
                }
                
                if indexPath.section == 0 {
                    return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [deleteAction])
                } else {
                    return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [startOnWatch, startOnIphone])
                }
            }
            return config
        }
    }
}
