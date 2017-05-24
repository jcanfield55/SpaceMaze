//
//  MainCharacter.swift//  SpaceMaze
//
//  Created by John Canfield on 4/7/15.
//  Copyright (c) 2015 John Canfield. All rights reserved.
//

import Foundation
import SpriteKit

class MainCharacter:Character {
    
    var treasureScore:Int = 0
    var powerUpTimer:Timer?
    var amIPoweredUp:Bool = false
    
    // function to call when you catch a PowerTreasure
    func powerMeUp() {amIPoweredUp = true
        // TODO set the powered up variable to true
        powerUpTimer = Timer.scheduledTimer(timeInterval:7.5, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: true)
    }
    
    // function to call when you time is up on the PowerTreasure power
    func powerMeDown(_ timer: Timer) {
        amIPoweredUp = false
        // TODO set the powered up variable to false
    }
}
