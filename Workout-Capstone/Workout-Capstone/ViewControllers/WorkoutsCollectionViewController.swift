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
    var workoutObjectsArray = [[WorkoutObject]]()
    var customPlaceHolder = Workout(workoutObject: WorkoutObject(name: "New Workout", imageData: Data(), time: nil, exercises: nil, requiresEquipment: nil, id: UUID()))
    
    static var workoutPlaceholderSection: Int?
    static var workoutPlaceholderRow: Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WorkoutCollectionViewController.delegate = self
        
        DispatchQueue.main.async { [self] in

            guard let workoutObjects = jsonManager.readWorkoutsFromDisk()?.workouts else {
                loadBuiltInWorkouts()
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
    
    func setWorkout(workout: Workout) {
        guard let row = WorkoutsCollectionViewController.workoutPlaceholderRow, let section = WorkoutsCollectionViewController.workoutPlaceholderSection else {
            return
        }
        
        if workoutsArray[section].count == 0 {
            workoutsArray[section].append(workout)
        } else {
            workoutsArray[section][row] = workout
        }
            
        updateDataSource()
        writeToDisk()
        
        WorkoutsCollectionViewController.workoutPlaceholderRow = nil
        WorkoutsCollectionViewController.workoutPlaceholderSection = nil
    }
    
    func updateDataSource() {
        
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
        
        snapshot.appendSections([.shoulders])
        snapshot.appendItems(shoulderWorkouts)
        
        snapshot.appendSections([.chest])
        snapshot.appendItems(chestWorkouts)
        
        snapshot.appendSections([.core])
        snapshot.appendItems(coreWorkouts)
        
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
    
    func writeToDisk() {
        workoutObjectsArray.removeAll()
    
        for workouts in workoutsArray {
            
            var workoutObjects = [WorkoutObject]()
            for workout in workouts {
                
                let workoutObject = workout.workoutObject
                workoutObjects.append(WorkoutObject(name: workoutObject.name, imageData: workoutObject.imageData, time: workoutObject.time, exercises: workoutObject.exercises, requiresEquipment: workoutObject.requiresEquipment, id: workoutObject.id))
            }
            workoutObjectsArray.append(workoutObjects)
        }
        
        let writtenWorkouts = JSONWorkouts(customWorkout: workoutObjectsArray[0],  armArray: workoutObjectsArray[1], backArray: workoutObjectsArray[2], legArray: workoutObjectsArray[3], chestArray: workoutObjectsArray[4], coreArray: workoutObjectsArray[5], shoulderArray: workoutObjectsArray[6])
        
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
        
        customWorkouts = (workoutsArray[0])
        armWorkouts = (workoutsArray[1])
        backWorkouts = (workoutsArray[2])
        legWorkouts = (workoutsArray[3])
        chestWorkouts = (workoutsArray[4])
        coreWorkouts = (workoutsArray[5])
        shoulderWorkouts = (workoutsArray[6])
        
        updateDataSource()
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
            let text = textFieldName.text?.replacingOccurrences(of: " ", with: "")
            if (text == "") {
                addAction.isEnabled = false
            } else {
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
            self.updateDataSource()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteWorkout(deleteWorkout: Workout) {
        
        customWorkouts.removeAll { (workout) -> Bool in
            workout == deleteWorkout
        }
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
    
    func switchOnSections(section: Section) -> [Workout] {
 
        switch section {
        case .custom: return customWorkouts
        case .arms: return armWorkouts
        case .back: return backWorkouts
        case .chest: return chestWorkouts
        case .core: return coreWorkouts
        case .legs: return legWorkouts
        case .shoulders: return shoulderWorkouts
        }
    }
    
    @IBAction func exerciseListButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "exerciseListSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? WorkoutCollectionViewController else {
            return
        }
        
        if segue.identifier == "newWorkoutSegue" {
            let newWorkout = Workout(workoutObject: WorkoutObject(name: newWorkoutName ?? "Error", imageData: UIImage(named: "customWorkoutImage")?.pngData() ?? Data(), time: nil, exercises: nil, requiresEquipment: nil, id: UUID()))
            
            destination.workout = newWorkout            
            customWorkouts.append(newWorkout)
            
            writeToDisk()
            
            updateDataSource()
        } else {
            destination.workout = dataSource.itemIdentifier(for: sender as! IndexPath)
        }
        let indexPath = sender as! IndexPath
        
        WorkoutsCollectionViewController.workoutPlaceholderSection = indexPath.section

        if indexPath.section == 0 && indexPath.row != 0 {
            WorkoutsCollectionViewController.workoutPlaceholderRow = indexPath.row - 1
            
        } else {
            WorkoutsCollectionViewController.workoutPlaceholderRow = indexPath.row
            
        }
        //destination.workoutsArray = switchOnSections(section: sections[indexPath.section])
        //destination.workoutsCollectionViewController = self
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
                    return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [startOnWatch, startOnIphone, deleteAction])
                } else {
                    return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [startOnWatch, startOnIphone])
                }
            }
            return config
        }
    }
}
