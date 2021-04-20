//
//  InterfaceController.swift
//  Workouts-Capstone-Watch Extension
//
//  Created by Noble Beazel on 4/14/21.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet weak var exerciseNameLabel: WKInterfaceLabel!
    @IBOutlet weak var repCountLabel: WKInterfaceLabel!
    @IBOutlet weak var timeGoalTimer: WKInterfaceTimer!
    @IBOutlet weak var currentTimeTimer: WKInterfaceTimer!
    
    var wcSession: WCSession!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let workout = message["workout"] as! Workout
        exerciseNameLabel.setText(workout.workoutObject.name)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    @IBAction func playPauseButtonTapped() {
        
    }
    @IBAction func nextExerciseButtonTapped() {
        
    }
    
    @IBAction func previousExerciseButtonTapped() {
        
    }
    
}


