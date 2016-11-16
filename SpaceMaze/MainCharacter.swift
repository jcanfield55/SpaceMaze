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
    var Eatenemy:Bool = false
    
    // function to call when you catch a PowerTreasure
    func powerMeUp() {
        //TODO - set the powered up variable to true
        Eatenemy = true
        powerUpTimer = NSTimer.scheduledTimerWithTimeInterval(20.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: false)
    }
    
    // function called when the time is up on the PowerTreasure power
    func powerMeDown(timer: NSTimer) {
        Eatenemy = false
        //TODO - set the powered up variable to false
    }

}