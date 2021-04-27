//
//  WatchConnectivityHelper.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 4/14/21.
//

import Foundation
import WatchConnectivity

class WatchConnectivityHelper: NSObject, WCSessionDelegate {
    var wcSession: WCSession! = nil
    
    override init() {
        super.init()
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
    }
    let myString = "This works"
    func sendToWatch(workout: Workout) {
       
        if let validSession = self.wcSession, validSession.isReachable {
            validSession.sendMessage(["iPhone" : myString], replyHandler: nil, errorHandler: nil)
        }
        // let message = ["workout" : workout]
//        let data = try? JSONEncoder().encode(workout.workoutObject)
        
//        wcSession.updateApplicationContext([String : Any])
        
//        wcSession.sendMessageData(data!, replyHandler: nil) { (error) in
//            print(error)
//
//        }
//        wcSession.sendMessage(message, replyHandler: nil) { (error) in
//            print(error)
//        }
        
        
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    

}
