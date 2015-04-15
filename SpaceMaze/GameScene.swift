//
//  GameScene.swift
//  SpaceMaze
//
//  Created by Joshua Bennett on 3/24/15.
//  Copyright (c) 2015 Joshua Bennett. All rights reserved.
//

import SpriteKit
import Foundation

// Enumeration -- defines a variable class with five different values
enum TouchCommand {
    case MOVE_UP,
    MOVE_DOWN,
    MOVE_LEFT,
    MOVE_RIGHT,
    NO_COMMAND
}
class GameScene: SKScene {
    
    /* Properties */
    let color = UIColor(red:0.15, green:1.15, blue:1.3, alpha:1.1)
    var character:Character?
    var enemies = [Enemy]()

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Create tunnels
    
        // Lesson 2b - create tunnels for the maze pattern you want.  Feel free to delete or modify these example tunnels
        var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 0, gridY: 6)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 3, gridY: 5)
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 10, gridX: 1, gridY: 7)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 7, gridX: 4, gridY: 0)
        self.addChild(tunnel6.tunnelSpriteNode)
        var tunnel7 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 1, gridY: 2)
        self.addChild(tunnel7.tunnelSpriteNode)
        for(var i = 0; i < 3; i += 1) {
            enemies.append(Enemy(imageNamed:"dog", currentTunnel:tunnel5, tunnelPosition:i ))
            self.addChild(enemies[i] as SKNode)
        }
        // Create character
        // Place the sprite in a tunnel
        let newCharacter = Character(imageNamed:"squirrel", currentTunnel:tunnel1, tunnelPosition:3)
        self.character = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
    }
    //
    //userInfo: nil
    func moveEnemies() {
        for key in enemies {
                let ran = Float(rand())/Float(RAND_MAX)
                //println(ran)
                var dir:TouchCommand
                if ran < 0.25 {
                    dir = TouchCommand.MOVE_UP
                }else if ran < 0.50 {
                    dir = TouchCommand.MOVE_DOWN
                }else if ran < 0.75 {
                    dir = TouchCommand.MOVE_RIGHT
                }else{
                    dir = TouchCommand.MOVE_LEFT
                }
                key.moveEnemy(dir)
        }
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        moveEnemies()
        for touch in touches {
            let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
            
            self.character?.moveCharacter(command)
        }
    }
    
    // Figures out which way the user wants to move the character based on which
    // edge of the screen the user touched.
    func commandForTouch(touch:UITouch, node:SKNode) -> TouchCommand {
        let location:CGPoint = touch.locationInNode(node)
        let frame:CGRect = node.frame
        let height = CGRectGetHeight(frame)
        let width = CGRectGetWidth(frame)
        // println("Touch position: \(location) x/width: \(location.x/width) y/height: \(location.y/height)")
        //wrap(node)
        if (location.y/height < 0.25) {
            return TouchCommand.MOVE_DOWN
        }
        if (location.y/height > 0.75) {
            return TouchCommand.MOVE_UP
        }
        if (location.x/width < 0.25) {
            return TouchCommand.MOVE_LEFT
        }
        if (location.x/width > 0.75) {
            return TouchCommand.MOVE_RIGHT
        }
        return TouchCommand.NO_COMMAND
    }
    func wrap(node:SKNode) {
        let frame:CGRect = node.frame
        let leftEdge = CGRectGetMinX(frame)
        let rightEdge = CGRectGetMaxX(frame)
        let topEdge = CGRectGetMaxY(frame)
        let bottomEdge = CGRectGetMinY(frame)
        let xPos = self.character?.position.x
        let yPos = self.character?.position.y
        //println("Left Edge: \(leftEdge)")
        //println("Right Edge:  \(rightEdge)")
        //println("Top Edge: \(topEdge)")
        //println("Bottom Edge: \(bottomEdge)")
        if (xPos > rightEdge) {
            character?.position.x = leftEdge
        }else if (yPos > topEdge) {
            character?.position.y = bottomEdge
        }else if (xPos < leftEdge) {
            character?.position.x = rightEdge
        }else if (yPos < bottomEdge) {
            character?.position.y = topEdge
        }
    }
    
}
