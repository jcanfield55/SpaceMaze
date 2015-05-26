//
//  GameScene.swift
//  SpaceMaze
//
//  Created by Diana Smetters on 3/24/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//  Updated by Lorenzo and Aidan

import SpriteKit
var treasureCount = 0;
// Enumeration -- defines a variable class with five different values
enum TouchCommand {
    case MOVE_UP,
    MOVE_DOWN,
    MOVE_LEFT,
    MOVE_RIGHT,
    NO_COMMAND
}
var treasureLabel:SKLabelNode?
var gameResultLabel:SKLabelNode?
class GameScene: SKScene {
    var gameResultLabel:SKLabelNode = SKLabelNode(text:"Outcome")
    var scoreLabel:SKLabelNode = SKLabelNode(text: "Score: 0")
    /* Properties */
    let color = UIColor(red:0.5, green:0, blue:0.5, alpha:1.0)
    var mainCharacter:MainCharacter?
    let opponentMoveTiming:NSTimeInterval = 1.0  // number of seconds between opponent movement
    var opponentTimer:NSTimer?
    var opponents:[OpponentCharacter] = []
    var treasureLabel:SKLabelNode = SKLabelNode(text: "default")
    
    
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
        var tunnel4 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 8, gridX: 1, gridY: 4, visibility:1)
        self.addChild(tunnel4.tunnelSpriteNode)
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 12, gridX: 5, gridY: 1, visibility:1)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 3, gridY: 1, visibility:1)
        self.addChild(tunnel6.tunnelSpriteNode)
        var tunnel8 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX: 3, gridY: 10, visibility:1)
        self.addChild(tunnel8.tunnelSpriteNode)
        var tunnel9 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 5, gridY: 8, visibility:1)
        self.addChild(tunnel9.tunnelSpriteNode)
        var tunnel10 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 5, gridY: 12, visibility:1)
        self.addChild(tunnel10.tunnelSpriteNode)
        var tunnel11 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 8, gridY: 4, visibility:1)
        self.addChild(tunnel11.tunnelSpriteNode)
        var tunnel12 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 12, gridX: 3, gridY: 1, visibility:1)
        self.addChild(tunnel12.tunnelSpriteNode)
        treasureLabel = SKLabelNode(fontNamed: "Arial")
        treasureLabel.text = "You WIN"
        treasureLabel.fontSize = 20
        treasureLabel.hidden = true
        treasureLabel.position = CGPointMake(self.frame.size.width * 4/5, self.frame.size.height * 11/12)
        self.addChild(treasureLabel)

        // Create dots to pick up in tunnels
        for aTunnel in allTunnels {
            for var i:Int = 0; i < aTunnel.length; i++ {
                let dotCharacter = TreasureCharacter(imageNamed: "grayDot", currentTunnel: aTunnel, tunnelPosition: i)
                self.addChild(dotCharacter)
                treasureCount++;
            }
        }
        println("Treasure count is: \(treasureCount)")

        let newCharacter = MainCharacter(imageNamed:"Spaceship", currentTunnel:tunnel1, tunnelPosition:3)
        self.mainCharacter = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        newCharacter.rotateWithMovement = true

        // Create opponents
        opponents.append(OpponentCharacter(imageNamed: "AlienSpaceship1", currentTunnel: tunnel5, tunnelPosition: 6))
        opponents.append(OpponentCharacter(imageNamed: "AlienSpaceship1", currentTunnel: tunnel11, tunnelPosition: 5))
        for anOpponent in opponents {
            self.addChild(anOpponent)   // Make sprite visible
        }
        self.scoreLabel.position = CGPointMake(self.frame.size.width/5, self.frame.size.height * 11/12)
        self.scoreLabel.fontSize = 16
        self.scoreLabel.fontName = "Helvetica-Bold"
        self.addChild(self.scoreLabel)
        self.gameResultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.gameResultLabel.fontSize = 20
        self.gameResultLabel.fontName = "Helvetica-BoldOblique"
        self.gameResultLabel.fontColor = UIColor.redColor()
        self.gameResultLabel.hidden = true
        self.addChild(self.gameResultLabel)
    }
    // Responds to touches by the user on the screen & moves mainCharacter as needed
    override func touchesBegan(touches:Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if let mainCharacter:MainCharacter = self.mainCharacter {
            for touchObject in touches {
                if let touch = touchObject as? UITouch {
                    let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
                    mainCharacter.moveCharacter(command)
                    
                    // Check if you are on top of a treasure dot, and if so, remove it from the screen and increment your count
                    let samePositionCharacters:[Character] = allCharacters.samePositionAs(mainCharacter)
                    for otherCharacter in samePositionCharacters {
                        if let dotCharacter = otherCharacter as? TreasureCharacter {  // Only remove Treasure characters
                            dotCharacter.hidden = true
                            allCharacters.remove(dotCharacter)
                            mainCharacter.addTreasure(1)
                            self.scoreLabel.text = "Score: \(mainCharacter.treasureScore)"
                            if mainCharacter.treasureScore == treasureCount {
                                treasureLabel.text = "YOU WON!"
                                endTheGame()
                            }
                        }
                        else if let opponent = otherCharacter as? OpponentCharacter { // If it is an opponent
                            treasureLabel.text = "You Lose!"
                            treasureLabel.hidden = false
                            self.endTheGame()
                        }
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
                let samePositionCharacters:[Character] = allCharacters.samePositionAs(anOpponent)
                for otherCharacter in samePositionCharacters {
                    if let mainCharacter = otherCharacter as? MainCharacter { // If it is the main Character
                        gameResultLabel.text = "You Lose!"
                        gameResultLabel.hidden = false
                        self.endTheGame()
                    }
                }
            }
        }
    }
    
    func endTheGame() {
        let endTheGameTimer:NSTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:Selector("showPlayAgainScreen:"), userInfo: nil, repeats: false)
    }
    
    @objc func showPlayAgainScreen(timer: NSTimer) {
                // Show the GameOverScene
                let reveal:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                let scene:GameOverScene = GameOverScene(size:self.frame.size)
                scene.treasureLabel.text = self.treasureLabel.text
                scene.gameResultLabel.text = self.scoreLabel.text
                scene.scaleMode = SKSceneScaleMode.AspectFill
                if let theView:SKView = self.view {
                    theView.presentScene(scene, transition:reveal)
                }
        }

    /*
     Improvements:
      - Try another type of control motion (swipes, dragging a joystick, etc.  Look up the UITouch command documentation
    */
}
