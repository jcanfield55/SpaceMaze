//
//  OpponentCharacter.swift
//  SpaceMaze
//
//  Created by John Canfield on 4/7/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//

import Foundation
import SpriteKit

import Foundation
import SpriteKit

class OpponentCharacter:Character {
    
    var blockedMoveRandomly:Bool = false
    
    // Function for opponents to chase you
    // Now has two modes: moves toward you in one mode
    // If that mode gets blocked, then goes into random movement mode until it enters a new tunnel
    
    func chaseCharacter(targetCharacter:Character) {
        let selfPoint:CGPoint = self.currentTunnel.pointAtTunnelPosition(self.tunnelPosition)
        let targetPoint:CGPoint = targetCharacter.currentTunnel.pointAtTunnelPosition(targetCharacter.tunnelPosition)
        
        let xDiff:CGFloat = targetPoint.x - selfPoint.x
        let yDiff:CGFloat = targetPoint.y - selfPoint.y
        let xCommand:TouchCommand = (xDiff > 0 ? TouchCommand.MOVE_RIGHT : (xDiff == 0 ? TouchCommand.NO_COMMAND :TouchCommand.MOVE_LEFT))
        let yCommand:TouchCommand = (yDiff > 0 ? TouchCommand.MOVE_UP : (yDiff == 0 ? TouchCommand.NO_COMMAND : TouchCommand.MOVE_DOWN))
        
        if !blockedMoveRandomly {  // Normal movement if not blocked
            if (xDiff == 0 && yDiff == 0) {
                return    // No need to move if already on top of targetCharacter
            }
            else if fabs(Double(xDiff)) > fabs(Double(yDiff)) {
                // Bigger xDiff so try moving horizontally first
                var success:Bool = self.moveCharacter(xCommand)
                if !success {
                    success = self.moveCharacter(yCommand)  // If not successful moving horizontally, try moving vertically
                }
                if !success {
                    blockedMoveRandomly = true  // Cannot move either direction, so we are blocked
                    println("blockedMoveRandomly = true")
                }
            }
            else {
                // Bigger yDiff so try moving vertically first
                var success:Bool = self.moveCharacter(yCommand)
                if !success {
                    success = self.moveCharacter(xCommand)  // If not succesfull moving vertically, try moving horizontally
                }
                if !success {
                    blockedMoveRandomly = true  // Cannot move either direction, so we are blocked
                    println("blockedMoveRandomly = true")
                }
            }
        }
        else {  // blockedMoveRandomly = true, do a random movement until into another tunnel
            let myTunnel:Tunnel = self.currentTunnel
            var r:UInt32 = arc4random_uniform(4)
            var direction:TouchCommand = TouchCommand.NO_COMMAND
            if r == 0 {
                direction = TouchCommand.MOVE_DOWN
            } else if r == 1 {
                direction = TouchCommand.MOVE_LEFT
            } else if r == 2 {
                direction = TouchCommand.MOVE_RIGHT
            } else if r == 3 {
                direction = TouchCommand.MOVE_UP
            }
            var success:Bool = self.moveCharacter(direction)
            println("Move \(r)")
            if (!success) {
                self.chaseCharacter(targetCharacter)  // if not successful, recursively try again to get another random direction that allows movement
                return
            }
            if (myTunnel !== self.currentTunnel) {
                blockedMoveRandomly = false  // We are now unblocked because we have moved into a new tunnel
                println("blockedMoveRandomly = false")
            }
        }
    }
    
}