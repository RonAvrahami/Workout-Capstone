//
//  WorkoutsDisplayViewController.swift
//  Workout-Capstone
//
//  Created by Kayden Henry on 3/19/21.
//

import UIKit
import AVFoundation

class WorkoutsDisplayViewController: UIViewController {
    
    
    @IBOutlet weak var repsView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var timeGoalLabel: UILabel!
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var timerLabel: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startStop: UIButton!
    
    
    var workout: Workout!
    var exercise: ExerciseData!
    var timer: Timer = Timer()
    var count = 0
    var timerCounting: Bool = false
    var index = 0
    var timerCount: Double = 0
    var workoutDescriptionText: String?
    var timerText: String?
    var exerciseText: String?
    var repsText: String?
    var isPaused: Bool = true
    let systemSoundID: SystemSoundID = 1005
    var seconds = 0
    var workoutTimer = Timer()
    var timeStarted = Bool()
    
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 90)
    override func viewDidLoad() {
        super.viewDidLoad()
        createWorkoutTimer()
        
        repsView.layer.cornerRadius = 13
        repsView.layer.shadowRadius = 5
        repsView.layer.shadowOffset = .zero
        repsView.layer.shadowOpacity = 1
        topView.layer.cornerRadius = 13
        bottomView.layer.cornerRadius = 13
        topView.layer.shadowRadius = 5
        bottomView.layer.shadowRadius = 5
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = .zero
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = .zero
        navigationController?.navigationBar.tintColor = UIColor(named: "customOragne")
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(myLeftBarButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton

        updateExercise()
        indexCheck()
        updateTextColor()
        
        startStop.setImage(UIImage(systemName: "play.rectangle.fill", withConfiguration: largeConfig), for: .normal)
        startStop.setImage(UIImage(systemName: "pause.rectangle.fill", withConfiguration: largeConfig), for: .selected)
    }
    
    
    @objc func myLeftBarButtonTapped() {
        startStop.isSelected = false
        timerCounting = false
        timer.invalidate()
        let returnAlert = UIAlertController(title: "Leaving Workout!", message: "Are you sure you want to leave the workout?", preferredStyle: .alert)
        returnAlert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { (UIAlertAction) in
        
            self.performSegue(withIdentifier: "unwindWorkout", sender: nil)
                }
            )
        )
        
        let closeAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: { [self] (_) in
            timer.fire()
        })
        returnAlert.addAction(closeAlert)
        present(returnAlert, animated: true, completion: nil)
        returnAlert.view.tintColor = UIColor(named: "customOragne")
    }

    @objc func timerSet() -> Void {
        count += 1
        timerLabel.text = timeString(time: TimeInterval(count))
        timerCount = TimeInterval(count)
        updateTextColor()
    }
    
    func updateExercise() {
         exercise = workout.workoutObject.exercises![index]
        
        DispatchQueue.main.async { [self] in
            timerText = "00:00"
            exerciseText = workout.workoutObject.exercises![index].name
            repsText = "Reps: \(workout.workoutObject.exercises![index].reps)"
            workoutDescriptionText = workout.workoutObject.exercises![index].description
            
            timerLabel.text = timerText
            exerciseLabel.text = exerciseText
            repsLabel.text = repsText
            timeGoalLabel.text = formatMinuteToSeconds(totalSeconds: exercise.timeGoal)
        }
    }
    
    func formatMinuteToSeconds(totalSeconds: Int) -> String {
        let minutes = Int(totalSeconds) / 60 % 60;
        let seconds = totalSeconds % 60;
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func updateTextColor() {
        if timerCount >= Double(exercise.timeGoal) {
            timerLabel.textColor = UIColor(named: "customRed")
            AudioServicesPlayAlertSound(systemSoundID)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
                AudioServicesDisposeSystemSoundID(self.systemSoundID)
                timer.invalidate()
            }
        }
        else {
            timerLabel.textColor = UIColor(named: "darkGreen")
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func endWorkoutAlert() {
        let actionsheet = UIAlertController(title: "Workout finished", message: "Workout length \(timeString(time: TimeInterval(seconds)))", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "End", style: .destructive, handler: { (action) in
            self.performSegue(withIdentifier: "unwindToHome", sender: self)
            print("Tapped end workout")
        }))
        present(actionsheet, animated: true)
    }
     
    func displayAlert() {
        let alert = UIAlertController(title: String(exerciseText!), message: String(workoutDescriptionText!), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action  in
            print("tapped Dismiss")
        }))
        present(alert, animated: true)
    }

    func indexCheck() {
        if index == 0 {
            backButton.isEnabled = false
        } else if index == workout.workoutObject.exercises!.count - 1 {
            //nextButton.isEnabled = false
            nextButton.setImage(UIImage(systemName: "clear.fill"), for: .normal)
        } else {
            nextButton.setImage(UIImage(systemName: "arrow.forward.square.fill"), for: .normal)
            backButton.isEnabled = true
            nextButton.isEnabled = true
        }
    }
    

    
    @IBAction func playPauseButton(_ sender: UIButton) {
      
        startStop.isSelected.toggle()
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
        }
        else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSet), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func workoutDescription(_ sender: Any) {
        displayAlert()
    }
    
    @IBAction func previousWorkout(_ sender: Any) {
        index -= 1
        updateExercise()
        timer.invalidate()
        count = 0
        timerCounting = false
        startStop.isSelected = false
        timerLabel.textColor = UIColor(named: "darkGreen")
        indexCheck()
    }
    
    func createWorkoutTimer() {
        workoutTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutCollectionViewController.updateTimer), userInfo: nil, repeats: true)
        timeStarted = true
        
    }
    @objc func updateTimer() {
        seconds += 1
    }
    @IBAction func nextWorkout(_ sender: Any) {
        if index == workout.workoutObject.exercises!.count - 1 {
            endWorkoutAlert()
        } else {
        index += 1
        updateExercise()
        timer.invalidate()
        count = 0
        timerCounting = false
        startStop.isSelected = false
        timerLabel.textColor = UIColor(named: "darkGreen")
        indexCheck()
        }
        
    }
}

