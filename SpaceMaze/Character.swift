//
//  Character.swift
//  SpaceMaze
//
//  Created by John Canfield on 3/29/15.
//

import Foundation
import SpriteKit

class Character:SKSpriteNode {
    var currentTunnel:Tunnel;
    var tunnelPosition:Int;
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageNamed:String, currentTunnel:Tunnel, tunnelPosition:Int) {
        self.currentTunnel = currentTunnel
        self.tunnelPosition = tunnelPosition
        let texture:SKTexture = SKTexture(imageNamed:imageNamed)
        super.init(texture: texture, color:SKColor(white:1.0, alpha:1.0),
            size: CGSizeMake(gridSize-tunnelBoundaryDistance, gridSize - tunnelBoundaryDistance))
        self.position = currentTunnel.pointAtTunnelPosition(tunnelPosition)
    }
    
    func moveCharacter(direction:TouchCommand) {
        // Lesson 2a: Add the code here to check whether you can move in a certain direction in a tunnel before making the move
        // Hint: use Tunnel canMoveInDirection method
        
            
        // Here is the code from Lesson 1 moved over from GameScene to the Character method
        // to move in the x direction (left / right) or the y direction (up / down).  
        // You'll need to modify this once you update use the Tunnel canMoveInDirection method
        var newPosition = self.position
        if (direction == TouchCommand.MOVE_UP) {
            newPosition.y = newPosition.y + gridSize
            self.zRotation = 0
        }
        if (direction == TouchCommand.MOVE_DOWN) {
            newPosition.y = newPosition.y - gridSize
            self.zRotation = PI
        }
        if (direction == TouchCommand.MOVE_LEFT) {
            newPosition.x = newPosition.x - gridSize
            self.zRotation = PI * 0.5
        }
        if (direction == TouchCommand.MOVE_RIGHT) {
            newPosition.x = newPosition.x + gridSize
            self.zRotation = PI * 1.5
        }
        
        // Move to new position
        if (newPosition != self.position) {
            let action:SKAction = SKAction.moveTo(newPosition, duration:0.25)
            self.runAction(action)
        }
    }
}