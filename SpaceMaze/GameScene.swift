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
    var color = UIColor(red:1.5, green:0.15, blue:2.3, alpha:1.0)
    var character:Character?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Create tunnels
        // Lesson 2b - create tunnels for the maze pattern you want
        var tunnel1 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 14, gridX: 3, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode);
        var tunnel2 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 3, gridY: 22, colorAlpha: 0.5)
        self.addChild(tunnel2.tunnelSpriteNode);
        var tunnel3 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 4, gridX: 3, gridY: 20, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode);
        var tunnel4 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 3, gridY: 1, colorAlpha: 5.9);
        self.addChild(tunnel4.tunnelSpriteNode);
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 12, gridX: 9, gridY: 15, colorAlpha: 0.5)
        self.addChild(tunnel5.tunnelSpriteNode);
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 9, gridY: 15, colorAlpha: 0.5)
        self.addChild(tunnel6.tunnelSpriteNode);
        var tunnel7 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 11, gridX: 13, gridY: 5, colorAlpha: 0.5)
        self.addChild(tunnel7.tunnelSpriteNode);
        var tunnel8 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 16, colorAlpha: 5.9)
        self.addChild(tunnel8.tunnelSpriteNode);
        var tunnel9 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 4, gridX: 0, gridY: 16, colorAlpha: 1.0)
        self.addChild(tunnel9.tunnelSpriteNode);
        var tunnel10 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 5, gridX: 8, gridY: 5, colorAlpha: 1.6)
        self.addChild(tunnel10.tunnelSpriteNode);
        var tunnel11 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 6, gridX: 8, gridY: 5, colorAlpha: 3.0)
        self.addChild(tunnel11.tunnelSpriteNode)
        var tunnel12 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 0, gridY: 1, colorAlpha: 5.9)
        self.addChild(tunnel12.tunnelSpriteNode)
        var tunnel13 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel13.tunnelSpriteNode)
        var tunnel14 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.6)
        self.addChild(tunnel14.tunnelSpriteNode)
        var tunnel15 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 3.0)
        self.addChild(tunnel15.tunnelSpriteNode)
        var tunnel16 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 0, gridY: 1, colorAlpha: 5.9)
        self.addChild(tunnel16.tunnelSpriteNode)
        var tunnel17 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 7, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel17.tunnelSpriteNode)
        var tunnel18 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.6)
        self.addChild(tunnel18.tunnelSpriteNode)
        var tunnel19 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 3.0)
        self.addChild(tunnel19.tunnelSpriteNode)
        var tunnel20 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 0, gridY: 1, colorAlpha: 5.9)
        self.addChild(tunnel20.tunnelSpriteNode)
        var tunnel21 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel21.tunnelSpriteNode)
        var tunnel22 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.6)
        self.addChild(tunnel22.tunnelSpriteNode)
        var tunnel23 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 3.0)
        self.addChild(tunnel23.tunnelSpriteNode)
        var tunnel24 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 0, gridY: 1, colorAlpha: 5.9)
        self.addChild(tunnel24.tunnelSpriteNode)
        var tunnel25 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel25.tunnelSpriteNode)
        var tunnel26 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.6)
        self.addChild(tunnel26.tunnelSpriteNode)
        var tunnel27 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 3.0)
        self.addChild(tunnel27.tunnelSpriteNode)
        var tunnel28 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 0, gridY: 1, colorAlpha: 5.9)
        self.addChild(tunnel28.tunnelSpriteNode)
        var tunnel29 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel29.tunnelSpriteNode)
        var tunnel30 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.6)
        self.addChild(tunnel30.tunnelSpriteNode)
        var tunnel31 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 3.0)
        self.addChild(tunnel31.tunnelSpriteNode)
        var tunnel32 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 3, gridX: 0, gridY: 1, colorAlpha: 5.9)
        self.addChild(tunnel32.tunnelSpriteNode)
        var tunnel33 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel33.tunnelSpriteNode)
        var tunnel34 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 0, gridY: 19, colorAlpha: 1.6)
        self.addChild(tunnel34.tunnelSpriteNode)
        var tunnel35 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 0, gridY: 19, colorAlpha: 1.6)
        self.addChild(tunnel35.tunnelSpriteNode)
        
        

        
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

}
