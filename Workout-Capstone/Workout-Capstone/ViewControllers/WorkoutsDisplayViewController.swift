//
//  WorkoutsDisplayViewController.swift
//  Workout-Capstone
//
//  Created by Kayden Henry on 3/19/21.
//

import UIKit

class WorkoutsDisplayViewController: UIViewController {
    
    
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
    var timeGoalText: String?
    var isPaused: Bool = true
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 90)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(myLeftBarButtonTapped))
        self.navigationItem.leftBarButtonItem = newBackButton
        startStop.setTitle("START", for: .normal)
        startStop.setTitle("STOP", for: .selected)

        updateExercise()
        indexCheck()
        updateTextColor()
        
        startStop.setImage(UIImage(systemName: "play.rectangle.fill", withConfiguration: largeConfig), for: .normal)
        startStop.setImage(UIImage(systemName: "pause.rectangle.fill", withConfiguration: largeConfig), for: .selected)
    }
    
    
    @objc func myLeftBarButtonTapped() {
        startStop.isSelected = false
        timer.invalidate()
        let returnAlert = UIAlertController(title: "Leaving Workout!", message: "Are you sure you want to leave the workout?", preferredStyle: .alert)
        returnAlert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { (UIAlertAction) in
        
            self.performSegue(withIdentifier: "unwindWorkout", sender: nil)
                }
            )
        )
        
        let closeAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: { [self] (_) in
            startStop.isSelected = true
            timer.fire()
        })
        returnAlert.addAction(closeAlert)
        present(returnAlert, animated: true, completion: nil)
    }

    @objc func timerSet() -> Void {
        count += 1
        timerLabel.text = timeString(time: TimeInterval(count))
        timerCount = TimeInterval(count)
        updateTextColor()
    }
    
    func updateExercise() {
        count = 0
        exercise = workout.workoutObject.exercises![count]
        
        DispatchQueue.main.async { [self] in
            timerText = "00:00"
            exerciseText = workout.workoutObject.exercises![index].name
            repsText = "Reps: \(workout.workoutObject.exercises![index].reps)"
            timeGoalText = "\(workout.workoutObject.exercises![index].timeGoal)"
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
        if timerCount > Double(exercise.timeGoal) {
            timerLabel.textColor = UIColor.red
        }
        else {
            timerLabel.textColor = UIColor.green
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
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
            nextButton.isEnabled = false
        } else {
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
        timer.invalidate()
        updateExercise()
        timerCounting = false
        startStop.isSelected = false
        indexCheck()
    }
    
    @IBAction func nextWorkout(_ sender: Any) {
        index += 1
        updateExercise()
        timer.invalidate()
        timerCounting = false
        startStop.isSelected = false
        indexCheck()
        
    }
}

