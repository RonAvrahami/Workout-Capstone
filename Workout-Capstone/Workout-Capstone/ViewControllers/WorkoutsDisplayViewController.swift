//
//  WorkoutsDisplayViewController.swift
//  Workout-Capstone
//
//  Created by Kayden Henry on 3/19/21.
//

import UIKit

class WorkoutsDisplayViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timeGoalLabel: UILabel!
    @IBOutlet weak var remainingReps: UILabel!
    @IBOutlet weak var exerciseName: UILabel!
    
    
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        timerLabel.text = String(count)
        
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
        timerLabel.text = String(count)
    }
    
    @IBAction func workoutDescription(_ sender: Any) {
    }
    
    
    @IBAction func previousWorkout(_ sender: Any) {
    }
    
    
    @IBAction func nextWorkout(_ sender: Any) {
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
