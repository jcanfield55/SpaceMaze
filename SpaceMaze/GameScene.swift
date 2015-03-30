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
    let color = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
    var character:Character?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Create tunnels
        // Lesson 2b - create tunnels for the maze pattern you want
        var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 2, gridX: 3, gridY: 5, colorAlpha: 0.2)
        self.addChild(tunnel4.tunnelSpriteNode)
        
        // Create character
        // Place the sprite in a tunnel
        let newCharacter = Character(imageNamed:"Spaceship", currentTunnel:tunnel1, tunnelPosition:3)
        self.character = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
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

    /*
     
        Hey! I finished all that. What do I do now?

        1. Change your spaceship to a PacMan or...
        2. Change the color of your background.
        3. Make your spaceship rotate when you move it. A hint:
                self.character.zRotation = PI * 0.5
        4. Make your game "wrap" -- when the spaceship goes off the right side of the screen,
            have it reappear on the left. A hint:
                location.x = location.x % width
    
    */
}
