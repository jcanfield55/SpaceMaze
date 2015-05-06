//
//  OpponentCharacter.swift
//  SpaceMaze
//
//  Created by John Canfield on 4/7/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//

import Foundation
import SpriteKit

class OpponentCharacter:Character {
    
    // Function for opponents to chase you
    // Can you make it more sophisticated?
    
    func chaseCharacter(targetCharacter:Character) {
        let selfPoint:CGPoint = self.currentTunnel.pointAtTunnelPosition(self.tunnelPosition)
        let targetPoint:CGPoint = targetCharacter.currentTunnel.pointAtTunnelPosition(targetCharacter.tunnelPosition)
        
        let xDiff:CGFloat = targetPoint.x - selfPoint.x
        let yDiff:CGFloat = targetPoint.y - selfPoint.y
        let xCommand:TouchCommand = (xDiff > 0 ? TouchCommand.MOVE_RIGHT : (xDiff == 0 ? TouchCommand.NO_COMMAND :TouchCommand.MOVE_LEFT))
        let yCommand:TouchCommand = (yDiff > 0 ? TouchCommand.MOVE_UP : (yDiff == 0 ? TouchCommand.NO_COMMAND : TouchCommand.MOVE_DOWN))
        
        if fabs(Double(xDiff)) > fabs(Double(yDiff)) {
            // Bigger xDiff so try moving horizontally first
            let success:Bool = self.moveCharacter(xCommand)
            if !success {
                self.moveCharacter(yCommand)  // If not successful moving horizontally, try moving vertically
            }
        }
        else {
            // Bigger yDiff so try moving vertically first
            let success:Bool = self.moveCharacter(yCommand)
            if !success {
                self.moveCharacter(xCommand)  // If not succesfull moving vertically, try moving horizontally
            }
            
        }
    }
    
    // What if the opponent catches you?  What happens then??
}