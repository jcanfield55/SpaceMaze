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

    func addTreasure(amount:Int) {
        treasureScore += amount
        println("Treasure score is \(String(treasureScore))")
    }

}