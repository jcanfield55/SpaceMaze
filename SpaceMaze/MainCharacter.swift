//
//  MainCharacter.swift
//  SpaceMaze
//
//  Created by John Canfield on 4/7/15.
//  Copyright (c) 2015 John Canfield. All rights reserved.
//

import Foundation
import SpriteKit

class MainCharacter:Character {

    var treasureScore:Int = 0
    var poweredUp:Bool = false
    var powerUpTimer:NSTimer?
    
    // function to call when you catch a PowerTreasure
    func powerMeUp() {
        powerUpTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: false)
        poweredUp = true
    }

    // function to call when you time is up on the PowerTreasure power
    func powerMeDown(timer: NSTimer) {
        poweredUp = false
    }
}