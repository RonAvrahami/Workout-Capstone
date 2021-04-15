//
//  WatchConnectivityHelper.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 4/14/21.
//

import Foundation
import WatchConnectivity

class WatchConnectivityHelper: NSObject, WCSessionDelegate {
    static let sharedInstance = WatchConnectivityHelper()
    var wcSession: WCSession! = nil
    
    override init() {
        super.init()
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
    }
    
    func sendToWatch(workout: Workout) {
        let message = ["workout" : workout]
        wcSession.sendMessage(message, replyHandler: nil) { (error) in
            print(error)
        }
        
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    

}
