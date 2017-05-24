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
    var powerUp:Bool = false
    
            
    // function to call when you catch a PowerTreasure
    func powerMeUp() {
        powerUp = true
        // TODO set the powered up variable to true
        if let put:Timer = powerUpTimer {  // If a timer is already going, invalidate it before creating a new one
            put.invalidate()
        }
        powerUpTimer = Timer.scheduledTimer(timeInterval:15.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: true)
        let newTexture:SKTexture = SKTexture(imageNamed:"Rufus.png")
        self.texture = newTexture
        
    }
    
    // function to call when you time is up on the PowerTreasure power
    func powerMeDown(_ timer: Timer) {
        powerUp = false
        // TODO set the powered up variable to false
        let newTexture:SKTexture = SKTexture(imageNamed:"Spaceship.png")
        self.texture = newTexture
    }
}
