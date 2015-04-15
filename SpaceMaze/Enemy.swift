//
//  Enemy.swift
//  SpaceMaze
//
//  Created by Joshua Bennett on 4/1/15.
//  Copyright (c) 2015 Joshua Bennett. All rights reserved.
//

import Foundation
import SpriteKit

var allEnemys = [Enemy]()

class Enemy:SKSpriteNode {
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
        allEnemys.append(self)
    }
    
    func moveEnemy(direction:TouchCommand) {
        // Lesson 2a: Add the code here to check whether you can move in a certain direction in a tunnel before making the move
        // Hint: use Tunnel canMoveInDirection method
        let (canMove:Bool,tunnel:Tunnel,position:Int) = currentTunnel.canMoveInDirection(direction,position:tunnelPosition,checkConnections: true)
        if  canMove == false {
            return
        }
        tunnelPosition = position
        currentTunnel = tunnel
        // Here is the code from Lesson 1 moved over from GameScene to the Character method
        // to move in the x direction (left / right) or the y direction (up / down).
        // You'll need to modify this once you update use the Tunnel canMoveInDirection method
        var newPosition = currentTunnel.pointAtTunnelPosition(position)
        // Move to new position
        if newPosition != self.position {
            let action:SKAction = SKAction.moveTo(newPosition, duration:0.25)
            self.runAction(action)
        }
    }
}