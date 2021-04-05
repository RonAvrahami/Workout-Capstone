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
    var timerGoal = 0
    var timerCount: Double = 0
    var workoutDescriptionText: String?
    var timerText: String?
    var exerciseText: String?
    var repsText: String?
    var timeGoalText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateExercise()
        indexCheck()
        updateTextColor()
    }
    
    
    
    func updateExercise() {
        count = 0
        exercise = workout.exercises![count]
        DispatchQueue.main.async { [self] in
            timerText = String(count)
            exerciseText = workout.exercises![index].name
            repsText = "Reps: \(workout.exercises![index].reps ?? 1)"
            timeGoalText = "\(workout.exercises![index].timeGoal ?? 1)"
            workoutDescriptionText = workout.exercises![index].description
            
            timerLabel.text = timerText
            exerciseLabel.text = exerciseText
            repsLabel.text = repsText
            timeGoalLabel.text = timeGoalText
        }
    }
    
    
    
    
    func updateTextColor() {
        if timerCount > Double(exercise.timeGoal!) {
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
    
    @IBAction func startStopButton(_ sender: UIButton) {
      
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            sender.setTitle("START", for: .normal)
        }
        else {
            timerCounting = true
            timer.invalidate()
            sender.setTitle("STOP", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSet), userInfo: nil, repeats: true)
            
        }
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
        } else if index == workout.exercises!.count - 1 {
            nextButton.isEnabled = false
        } else {
            backButton.isEnabled = true
            nextButton.isEnabled = true
        }
    }
    
    @objc func timerSet() -> Void {
        count += 1
        timerLabel.text = timeString(time: TimeInterval(count))
        timerCount = TimeInterval(count)
        updateTextColor()
    }
    
    @IBAction func workoutDescription(_ sender: Any) {
        displayAlert()
        
    }
    
    
    @IBAction func previousWorkout(_ sender: Any) {
        index -= 1
        timer.invalidate()
        updateExercise()
        timerCounting = false
        startStop.setTitle("START", for: .normal)
        indexCheck()
    }
    
    
    @IBAction func nextWorkout(_ sender: Any) {
        index += 1
        updateExercise()
        timer.invalidate()
        timerCounting = false
        startStop.setTitle("START", for: .normal)
        indexCheck()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller. 6614059850
    }
    */

}

