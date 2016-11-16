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
    var powerUpTimer:NSTimer?
    //TODO - create a variable to keep track of whether or not you are powered up.
    
    
    // function to call when you catch a PowerTreasure
    func powerMeUp() {
        //TODO - set the powered up variable to true
        powerUpTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: false)
    }
    
    // function called when the time is up on the PowerTreasure power
    func powerMeDown(timer: NSTimer) {
        //TODO - set the powered up variable to false
    }
}