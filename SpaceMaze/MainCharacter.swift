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
    var poweredUp:Bool = false
    
    func powerMeUp() {
        powerUpTimer = Timer.scheduledTimer(timeInterval:15.0, target:self, selector:#selector(MainCharacter.powerMeDown(_:)), userInfo: nil, repeats: true)
        poweredUp = true
    }
    
    func powerMeDown(_ timer:Timer) {
        poweredUp = false
    }
}
