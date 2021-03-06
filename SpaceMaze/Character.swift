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
    var rotateWithMovement:Bool = false;  // True if we should rotate based on the direction moved
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageNamed:String, currentTunnel:Tunnel, tunnelPosition:Int) {
        self.currentTunnel = currentTunnel
        self.tunnelPosition = tunnelPosition
        let texture:SKTexture = SKTexture(imageNamed:imageNamed)
        super.init(texture: texture, color:SKColor(white:1.0, alpha:1.0),
            size: CGSize(width: gridSize-tunnelBoundaryDistance, height: gridSize - tunnelBoundaryDistance))
        self.position = currentTunnel.pointAtTunnelPosition(tunnelPosition)
        allCharacters.add(self)
    }
    
    // Moves the character in the specified direction if possible
    // Returns true if character is able to move, false if the character is not able to move
    func moveCharacter(_ direction:TouchCommand) -> Bool {
        // Lesson 2a: Add the code here to check whether you can move in a certain direction in a tunnel before making the move
        // Hint: use Tunnel canMoveInDirection method
        
        let (canMove, newTunnel, newPosition): (Bool, Tunnel, Int) = self.currentTunnel.canMoveInDirection(direction, position: tunnelPosition, checkConnections: true)
        if (canMove) {
            // Uncomment the line below if you want sound along with every movement of a character
            // runAction(SKAction.playSoundFileNamed("pac.wav", waitForCompletion: true))
            
            if newTunnel !== currentTunnel {
                self.currentTunnel = newTunnel
            }
            self.tunnelPosition = newPosition
            
            // Here is the code from Lesson 1 moved over from GameScene to the Character method
            if rotateWithMovement {    // only rotate those characters with the property set to true
                if (direction == TouchCommand.move_UP) {
                    self.zRotation = 0
                }
                if (direction == TouchCommand.move_DOWN) {
                    self.zRotation = PI
                }
                if (direction == TouchCommand.move_LEFT) {
                    self.zRotation = PI * 0.5
                }
                if (direction == TouchCommand.move_RIGHT) {
                    self.zRotation = PI * 1.5
                }
            }
            
            // Move to new position
            let action:SKAction = SKAction.move(to: self.currentTunnel.pointAtTunnelPosition(self.tunnelPosition), duration:0.25)
            self.run(action)
            
            return true   // we were able to move
        }
        return false
    }
}
