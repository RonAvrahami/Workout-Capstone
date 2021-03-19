//
//  WorkoutsDisplayViewController.swift
//  Workout-Capstone
//
//  Created by Kayden Henry on 3/19/21.
//

import UIKit

class WorkoutsDisplayViewController: UIViewController {
    @IBOutlet weak var timerAmount: UILabel!
    @IBOutlet weak var timeGoalAmount: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var workoutDescription: UIImageView!
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
