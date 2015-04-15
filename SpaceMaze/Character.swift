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
            size: CGSizeMake(gridSize-tunnelBoundaryDistance, gridSize - tunnelBoundaryDistance))
        self.position = currentTunnel.pointAtTunnelPosition(tunnelPosition)
        allCharacters.add(self)
    }
    
    // Moves the character in the specified direction if possible
    // Returns true if character is able to move, false if the character is not able to move
    func moveCharacter(direction:TouchCommand) -> Bool {
        // Lesson 2a: Add the code here to check whether you can move in a certain direction in a tunnel before making the move
        // Hint: use Tunnel canMoveInDirection method
        
        let (canMove:Bool, newTunnel:Tunnel, newPosition:Int) = self.currentTunnel.canMoveInDirection(direction, position: tunnelPosition, checkConnections: true)
        if (canMove) {
            if newTunnel !== currentTunnel {
                self.currentTunnel = newTunnel
            }
            self.tunnelPosition = newPosition
            
            if rotateWithMovement {    // only rotate those characters with the property set to true
                if (direction == TouchCommand.MOVE_UP) {
                    self.zRotation = 0
                }
                if (direction == TouchCommand.MOVE_DOWN) {
                    self.zRotation = PI
                }
                if (direction == TouchCommand.MOVE_LEFT) {
                    self.zRotation = PI * 0.5
                }
                if (direction == TouchCommand.MOVE_RIGHT) {
                    self.zRotation = PI * 1.5
                }
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
}