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
    // TODO create a variable to keep track of whether or not you are powered up
    var rammer=false
    // function to call when you catch a PowerTreasure
    func powerMeUp() {
        // TODO set the powered up variable to true
        rammer=true
        powerUpTimer = Timer.scheduledTimer(timeInterval:6.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: true)
    }
    
    // function to call when you time is up on the PowerTreasure power
    func powerMeDown(_ timer: Timer) {
        // TODO set the powered up variable to false
        rammer=false
        let texture:SKTexture = SKTexture(imageNamed:"lockheed harrier1")
        self.texture = texture

    }
}
