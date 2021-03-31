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
    
    
    var workout: Workout!
    var exercise: ExerciseData!
    var timer: Timer = Timer()
    var count = 0
    var timerCounting: Bool = false
    var index = 0
    var timerGoal = 0
    var timerCount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateExercise()
        updateTextColor()
    }
    
    func updateExercise() {
        count = 0
        exercise = workout.exercises![count]
        DispatchQueue.main.async {
            self.timerLabel.text = String(self.count)
            self.exerciseLabel.text = self.workout.exercises![self.index].name
            self.repsLabel.text = "Reps: \(self.workout.exercises![self.index].reps ?? 1)"
            self.timeGoalLabel.text = "\(self.workout.exercises![self.index].timeGoal ?? 1)"
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
            sender.setTitle("STOP", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSet), userInfo: nil, repeats: true)
            
        }
    }
    

    
    
    @objc func timerSet() -> Void {
        count += 1
        timerLabel.text = timeString(time: TimeInterval(count))
        timerCount = TimeInterval(count)
        updateTextColor()
    }
    
    @IBAction func workoutDescription(_ sender: Any) {
    }
    
    
    @IBAction func previousWorkout(_ sender: Any) {
        index -= 1
        timer.invalidate()
        updateExercise()
    }
    
    
    @IBAction func nextWorkout(_ sender: Any) {
        index += 1
        timer.invalidate()
        updateExercise()
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
