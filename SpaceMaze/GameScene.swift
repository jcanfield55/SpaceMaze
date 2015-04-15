//
//  GameScene.swift
//  SpaceMaze
//
//  Created by Diana Smetters on 3/24/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//

import SpriteKit

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
    let color = UIColor(white:0.0, alpha: 1.0)
    let aTexture = SKTexture(imageNamed: "lava.png")
    var character:Character?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // self.imageNamed = aTexture

        // Create tunnels
        // Lesson 2b - create tunnels for the maze pattern you want.  Feel free to delete or modify these example tunnels
        var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 0)
        self.addChild(tunnel6.tunnelSpriteNode)
        var tunnel7 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 11, gridX: 0, gridY: 0)
        self.addChild(tunnel7.tunnelSpriteNode)
        var tunnel8 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 11, gridX: 6, gridY: 0)
        self.addChild(tunnel8.tunnelSpriteNode)
        var tunnel9 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 10)
        self.addChild(tunnel9.tunnelSpriteNode)
        var tunnel10 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 11, gridX: 3, gridY: 0)
        self.addChild(tunnel10.tunnelSpriteNode)
        
        // Create character
        // Place the sprite in a tunnel
        let newCharacter = Character(imageNamed:"ArrowGD.png", currentTunnel:tunnel1, tunnelPosition:3)
        self.character = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        
        // Create opponents
        opponents.append(OpponentCharacter(imageNamed: "AlienSpaceship1", currentTunnel: tunnel3, tunnelPosition: 3))
        
        for anOpponent in opponents {
            self.addChild(anOpponent)   // Make sprite visible
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in touches {
            let command: TouchCommand = commandForTouch(touch as! UITouch, node:self)
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
        println("Touch position: \(location) x/width: \(location.x/width) y/height: \(location.y/height)")
       
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
    
    // Function called whenever it is time for the opponent to move
    @objc func moveOpponent(timer: NSTimer) {
        for anOpponent in opponents {
            if let c = self.mainCharacter {
                anOpponent.chaseCharacter(c)
            }
        }
    }

}
