//
//  vibrateDevice.swift
//  selfcare
//
//  Created by Michael Brewington on 3/9/21.
//

import Foundation
import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
