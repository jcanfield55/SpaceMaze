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
    var mainCharacter:MainCharacter?
    let opponentMoveTiming:NSTimeInterval = 1.0  // number of seconds between opponent movement
    var opponentTimer:NSTimer?
    var opponents:[OpponentCharacter] = []
    var gameResultLabel:SKLabelNode = SKLabelNode(text:"Outcome")
    var scoreLabel:SKLabelNode = SKLabelNode(text: "Score: 0")
    var openXKCD:String = "Not yet"
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Set up timer that will call function moveOpponent every opponentMoveTiming
        opponentTimer = NSTimer.scheduledTimerWithTimeInterval(self.opponentMoveTiming, target:self, selector:Selector("moveOpponent:"), userInfo: nil, repeats: true)

        // Create tunnels
        // Lesson 2b - create tunnels for the maze pattern you want
        var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 8, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 10, gridX: 1, gridY: 9, colorAlpha: 1.0)
        self.addChild(tunnel4.tunnelSpriteNode)
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 5, gridX: 7, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 4, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel6.tunnelSpriteNode)
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), 20)
        self.scoreLabel.fontSize = 16
        self.scoreLabel.fontName = "Helvetica-Bold"
        self.addChild(self.scoreLabel)
        self.gameResultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.gameResultLabel.fontSize = 20
        self.gameResultLabel.fontName = "Helvetica-BoldOblique"
        self.gameResultLabel.fontColor = UIColor.redColor()
        self.gameResultLabel.hidden = true
        self.addChild(self.gameResultLabel)
        // Create dots to pick up in tunnels
        for aTunnel in allTunnels {
            for var i:Int = 0; i < aTunnel.length; i++ {
                let dotCharacter = TreasureCharacter(imageNamed: "grayDot", currentTunnel: aTunnel, tunnelPosition: i)
                self.addChild(dotCharacter)
            }
        }
        
        // Create character
        // Place the sprite in a tunnel
        var newCharacter = MainCharacter(imageNamed:"Spaceship", currentTunnel:tunnel1, tunnelPosition:3)
        newCharacter.rotateWithMovement = true
        self.mainCharacter = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        
        // Create opponents
        opponents.append(OpponentCharacter(imageNamed: "AlienSpaceship1", currentTunnel: tunnel3, tunnelPosition: 3))
        
        for anOpponent in opponents {
            self.addChild(anOpponent)   // Make sprite visible
        }
    }
    func reset() {
        for aTunnel in allTunnels {
            for var i:Int = 0; i < aTunnel.length; i++ {
                let dotCharacter = TreasureCharacter(imageNamed: "grayDot", currentTunnel: aTunnel, tunnelPosition: i)
                self.addChild(dotCharacter)
            }
        }
        var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 8, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 10, gridX: 1, gridY: 9, colorAlpha: 1.0)
        self.addChild(tunnel4.tunnelSpriteNode)
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 5, gridX: 7, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 4, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel6.tunnelSpriteNode)
        gameResultLabel = SKLabelNode(text:"Outcome")
        scoreLabel = SKLabelNode(text: "Score: 0")
        var newCharacter = MainCharacter(imageNamed:"Spaceship", currentTunnel:tunnel1, tunnelPosition:3)
        newCharacter.rotateWithMovement = true
        self.mainCharacter = newCharacter
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
                    if let dotCharacter = otherCharacter as? TreasureCharacter {  // Only remove Treasure characters
                        dotCharacter.hidden = true
                        allCharacters.remove(dotCharacter)
                        mainCharacter.treasureScore++
                        println("Treasure score is " + String(mainCharacter.treasureScore))
                        self.scoreLabel.text = "Score: \(mainCharacter.treasureScore)"
                        if (mainCharacter.treasureScore >= 76) {
                            gameResultLabel.text = "You Win!"
                            gameResultLabel.hidden = false
                        }
                    }
                    else if let opponent = otherCharacter as? OpponentCharacter { // If it is an opponent
                        gameResultLabel.text = "You Lose!"
                        gameResultLabel.hidden = false
                        
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
            if let c = self.mainCharacter {
                anOpponent.chaseCharacter(c)
                let samePositionCharacters:[Character] = allCharacters.samePositionAs(anOpponent)
                for otherCharacter in samePositionCharacters {
                    if let mainCharacter = otherCharacter as? MainCharacter { // If it is the main Character
                        gameResultLabel.text = "You Lose!"
                        gameResultLabel.hidden = false
                        if openXKCD != "Already" {
                            openXKCD = "Now"
                        }
                        reset()
                    }
                    if openXKCD == "Now" {
                        UIApplication.sharedApplication().openURL(NSURL(string: "https://c.xkcd.com/random/comic")!)
                        openXKCD = "Already"
                    }
                }
            }
        }
        
    }

    /*
     Improvements:
      - Try another type of control motion (swipes, dragging a joystick, etc.  Look up the UITouch command documentation
    */
}
