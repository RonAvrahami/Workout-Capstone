//
//  StringLength.swift
//  Workout-Capstone
//
//  Created by Noble Beazel on 4/30/21.
//

import Foundation
import UIKit
extension String {
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  str
   }
}
extension UILabel {
    func maxLabelLength(length: Int) {
        
    }
}
