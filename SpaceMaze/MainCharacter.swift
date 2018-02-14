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
    
    var powerUpTimer:Timer?
    var GOAL:Bool=false
    // TODO create a variable to keep track of whether or not you are powered up
    
    // function to call when you catch a PowerTreasure
    func powerMeUp() {
        GOAL=true
        // TODO set the powered up variable to true
        powerUpTimer = Timer.scheduledTimer(timeInterval:15.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: true)
        texture = SKTexture(imageNamed:"liverpool")
    }
    
    // function to call when you time is up on the PowerTreasure power
    @objc func powerMeDown(_ timer: Timer) {
        GOAL=false
        // TODO set the powered up variable to false
        texture = SKTexture(imageNamed:"soccerball")
    }
}
