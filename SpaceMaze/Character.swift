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
        
        let (canMove:Bool, newTunnel:Tunnel, newPosition:Int) = self.currentTunnel.canMoveInDirection(direction, position: tunnelPosition, checkConnections: true)
        if (canMove) {
            if newTunnel !== currentTunnel {
                self.currentTunnel = newTunnel
            }
            self.tunnelPosition = newPosition
            println("Current tunnel \(self.currentTunnel.tunnelCenter) position \(self.tunnelPosition)")

            // Here is the code from Lesson 1 moved over from GameScene to the Character method
            // to move in the x direction (left / right) or the y direction (up / down)
            if (direction == TouchCommand.MOVE_UP) {
                self.zRotation = PI * 0.5
            }
            if (direction == TouchCommand.MOVE_DOWN) {
                self.zRotation = PI * 1.5
            }
            if (direction == TouchCommand.MOVE_LEFT) {
                self.zRotation = PI * 1
            }
            if (direction == TouchCommand.MOVE_RIGHT) {
                self.zRotation = 0
            }
            
            // Move to new position
            let action:SKAction = SKAction.moveTo(self.currentTunnel.pointAtTunnelPosition(self.tunnelPosition), duration:0.25)
            self.runAction(action)
            
            // Check for wraparound -- will need more work to make compatible with tunnels
            if let parent = self.parent {
                let width = CGRectGetWidth(parent.frame)
                let height = CGRectGetHeight(parent.frame)
                var position:CGPoint = self.position
                if (position.x >= width) {
                    position.x = position.x - width
                }
                if position.x < 0 {
                    position.x = width - position.x
                }
                if position.y >= height {
                    position.y = position.y - height
                }
                if position.y < 0 {
                    position.y = height - position.y
                }
                self.position = position
            }
        }
    }
}