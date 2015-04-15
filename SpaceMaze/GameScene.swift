//
//  GameScene.swift
//  SpaceMaze
//
//  Created by Diana Smetters on 3/24/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//  Updated by Lorenzo and Aidan

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
    
    let color = UIColor(red:0.5, green:0, blue:0.5, alpha:1.0)
    var character:Character?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Set up timer that will call function moveOpponent every opponentMoveTiming
        opponentTimer = NSTimer.scheduledTimerWithTimeInterval(self.opponentMoveTiming, target:self, selector:Selector("moveOpponent:"), userInfo: nil, repeats: true)

        // Create tunnels
        // Lesson 2b - create tunnels for the maze pattern you want.  Feel free to delete or modify these example tunnels
        /*var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, visibility:1)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, visibility:1)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, visibility:1)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 2, gridX: 3, gridY: 5, visibility:1)
        self.addChild(tunnel4.tunnelSpriteNode)
        var tunnel5 = Tunnel(orientation: TunnelOrientation.horizontalTunnel, length: 5, gridX: 0, gridY: 3, visibility:1)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation: TunnelOrientation.horizontalTunnel, length: 6, gridX: 1, gridY: 9, visibility: 0.1)
        self.addChild(tunnel6.tunnelSpriteNode)
        var tunnel7 = Tunnel(orientation: TunnelOrientation.verticalTunnel, length: 5, gridX: 5, gridY: 5, visibility:1)
        self.addChild(tunnel7.tunnelSpriteNode)
        var tunnel8 = Tunnel(orientation: TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 8, visibility: 0.2)
        self.addChild(tunnel8.tunnelSpriteNode)
    */
        var tunnel1 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 12, gridX: 1, gridY: 1, visibility:1)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 1, gridY: 12, visibility:1)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 3, gridY: 4, visibility:1)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 8, gridX: 1, gridY: 4, visibility:1)
        self.addChild(tunnel4.tunnelSpriteNode)
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 5, gridX: 5, gridY: 1, visibility:1)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 3, gridY: 1, visibility:1)
        self.addChild(tunnel6.tunnelSpriteNode)
        var tunnel7 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 5, gridY: 4, visibility:1)
        self.addChild(tunnel7.tunnelSpriteNode)
        var tunnel8 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 3, gridY: 10, visibility:1)
        self.addChild(tunnel8.tunnelSpriteNode)
        var tunnel9 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 5, gridY: 8, visibility:1)
        self.addChild(tunnel9.tunnelSpriteNode)
        var tunnel10 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 5, gridY: 12, visibility:1)
        self.addChild(tunnel10.tunnelSpriteNode)
        var tunnel11 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 8, gridY: 4, visibility:1)
        self.addChild(tunnel11.tunnelSpriteNode)
        var tunnel12 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 2, gridX: 3, gridY: 1, visibility:1)
        self.addChild(tunnel12.tunnelSpriteNode)




        // Create character
        // Place the sprite in a tunnel
        let newCharacter = Character(imageNamed:"PacMan", currentTunnel:tunnel1, tunnelPosition:3)
        newCharacter.setScale(0.55)
        self.character = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        
        // Create opponents
        opponents.append(OpponentCharacter(imageNamed: "AlienSpaceship1", currentTunnel: tunnel3, tunnelPosition: 3))
        
        for anOpponent in opponents {
            self.addChild(anOpponent)   // Make sprite visible
        }
    }
    
    // Responds to touches by the user on the screen & moves mainCharacter as needed
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if let mainCharacter:MainCharacter = self.mainCharacter {
            for touch in touches {
                let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
                mainCharacter.moveCharacter(command)
                
                // Check if you are on top of a treasure dot, and if so, remove it from the screen and increment your count
                let samePositionCharacters:[Character] = allCharacters.samePositionAs(mainCharacter)
                for otherCharacter in samePositionCharacters {
                    if let dotCharacter = otherCharacter as? TreasureCharacter {  // Only remove Treasure characters
                        dotCharacter.hidden = true
                        allCharacters.remove(dotCharacter)
                        mainCharacter.treasureScore++
                        println("Treasure score is " + String(mainCharacter.treasureScore))
                    }
                }
            }
        }
    }
    
    // Figures out which way the user wants to move the character based on which
    // edge of the screen the user touched.
    func commandForTouch(touch:UITouch, node:SKNode) -> TouchCommand {
        let location:CGPoint = touch.locationInNode(node)
        let frame:CGRect = node.frame
        let height = CGRectGetHeight(frame)
        let width = CGRectGetWidth(frame)
        //println("Touch position: \(location) x/width: \(location.x/width) y/height: \(location.y/height)")
       
        if (location.y/height < 0.3) {
            return TouchCommand.MOVE_DOWN
        }
        if (location.y/height > 0.7) {
            return TouchCommand.MOVE_UP
        }
        if (location.x/width < 0.4) {
            return TouchCommand.MOVE_LEFT
        }
        if (location.x/width > 0.6) {
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
