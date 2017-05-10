//
//  GameScene.swift
//  SpaceMaze
//
//  Created by John Canfield & Diana Smetters on 3/24/15.
//  Copyright (c) 2015 John Canfield & Diana Smetters. All rights reserved.  Test3
//

import SpriteKit

// Enumeration -- defines a variable class with five different values
enum TouchCommand {
    case move_UP,
    move_DOWN,
    move_LEFT,
    move_RIGHT,
    no_COMMAND
}
class GameScene: SKScene {
    
    /* Properties */
    let color = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
    var mainCharacter:MainCharacter?
    let opponentMoveTiming:TimeInterval = 1.0  // number of seconds between opponent movement
    var opponentTimer:Timer?
    var opponents = Set<OpponentCharacter>()
    var gameResultLabel:SKLabelNode = SKLabelNode(text:"Outcome")
    var scoreLabel:SKLabelNode = SKLabelNode(text: "Score: 0")
    var maxScore:Int = 0
    
    override func didMove(to view: SKView) {        
        
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Set up timer that will call function moveOpponent every opponentMoveTiming
        opponentTimer = Timer.scheduledTimer(timeInterval: self.opponentMoveTiming, target:self, selector:#selector(GameScene.moveOpponent(_:)), userInfo: nil, repeats: true)

        // Create tunnels
        // Lesson 1 - create tunnels for the maze pattern you want
        let tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode)
        let tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 10, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel2.tunnelSpriteNode)
        let tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode)
        let tunnel4 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 11, gridX: 4, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel4.tunnelSpriteNode)
        let tunnel5 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY:4, colorAlpha: 1.0)
        self.addChild(tunnel5.tunnelSpriteNode)
        let tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 1, gridY:1, colorAlpha: 1.0)
        self.addChild(tunnel6.tunnelSpriteNode)
        let tunnel7 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY:8, colorAlpha: 1.0)
        self.addChild(tunnel7.tunnelSpriteNode)
        let tunnel8 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 3, gridX:4, gridY:11, colorAlpha: 1.0)
        self.addChild(tunnel8.tunnelSpriteNode)
        let tunnel9 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 10, gridX:6, gridY:4, colorAlpha: 1.0)
        self.addChild(tunnel9.tunnelSpriteNode)
        let tunnel10 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 1, gridY:10, colorAlpha: 0.1)
        self.addChild(tunnel10.tunnelSpriteNode)

        // Create dots to pick up in tunnels
        for aTunnel in allTunnels {
            for i:Int in 0 ..< aTunnel.length {
            if  (aTunnel===tunnel7)  && (i==3) {
                    let dotCharacter = TreasureCharacter(imageNamed: "oni-mask", currentTunnel: aTunnel, tunnelPosition: i)
                    self.addChild(dotCharacter)
                    maxScore += 1   // Keep track of the total number of treasure dots
                   // TODO set the dotCharacter.isPowerUp variable to true
                  dotCharacter.isPowerUp=true
                
                }
                else {
                    let dotCharacter = TreasureCharacter(imageNamed: "grayDot", currentTunnel: aTunnel, tunnelPosition: i)
                    self.addChild(dotCharacter)
                    maxScore += 1   // Keep track of the total number of treasure dots
                }
            }
        }
        
        // Create character
        // Place the sprite in a tunnel
        //let newCharacter = MainCharacter(imageNamed:"Spaceship", currentTunnel:tunnel1, tunnelPosition:3)
        let newCharacter = MainCharacter(imageNamed:"lockheed harrier1", currentTunnel:tunnel1, tunnelPosition:3)
        newCharacter.rotateWithMovement = true
        self.mainCharacter = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        
        // Create opponents
        opponents.insert(OpponentCharacter(imageNamed: "AlienSpaceship1", currentTunnel: tunnel3, tunnelPosition: 3))
        
        for anOpponent in opponents {
            self.addChild(anOpponent)   // Make sprite visible
        }
        
        // Add score label
        self.scoreLabel.position = CGPoint(x: self.frame.midX, y: 20)
        self.scoreLabel.fontSize = 16
        self.scoreLabel.fontName = "Helvetica-Bold"
        self.addChild(self.scoreLabel)
        
        // Add gameResultLabel
        self.gameResultLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.gameResultLabel.fontSize = 20
        self.gameResultLabel.fontName = "Helvetica-BoldOblique"
        self.gameResultLabel.fontColor = UIColor.red
        self.gameResultLabel.isHidden = true
        self.addChild(self.gameResultLabel)
    }
    
    // Responds to touches by the user on the screen & moves mainCharacter as needed
    override func touchesBegan(_ touches:Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        if let mainCharacter:MainCharacter = self.mainCharacter {
            for touch in touches {
                    let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
                    _ = mainCharacter.moveCharacter(command)
                    
                    // Check if you are on top of a treasure dot, and if so, remove it from the screen and increment your count
                    let samePositionCharacters:[Character] = allCharacters.samePositionAs(mainCharacter)
                    for otherCharacter in samePositionCharacters {
                        if let dotCharacter = otherCharacter as? TreasureCharacter {  // Only remove Treasure characters
                            dotCharacter.isHidden = true
                            allCharacters.remove(dotCharacter)
                            mainCharacter.treasureScore += 1
                            print("Treasure score is " + String(mainCharacter.treasureScore))
                            self.scoreLabel.text = "Score: \(mainCharacter.treasureScore)"
                            if (mainCharacter.treasureScore >= maxScore) {
                                gameResultLabel.text = "You Win!"
                                gameResultLabel.isHidden = false
                                self.endTheGame()
                            }
                            // TODO if dotCharacter is a powerup treasure, make mainCharacter powered up
                            if (dotCharacter.isPowerUp) {
                                mainCharacter.powerMeUp()
                                let texture:SKTexture = SKTexture(imageNamed:"thanatos")
                                mainCharacter.texture = texture
                            }
                        }
                        else if let anOpponent = otherCharacter as? OpponentCharacter { // If it is an opponent
                            if (mainCharacter.rammer) {  // TODO instead of “false” check if mainCharacter powered up variable you created is true.  Use . format
                                anOpponent.isHidden = true
                                opponents.remove(anOpponent)
                                allCharacters.remove(anOpponent)
                            }
                            else {
                                gameResultLabel.text = "You Lose!"
                                gameResultLabel.isHidden = false
                                self.endTheGame()
                            }
                        }
                    }
            }
        }
    }
    
    // Figures out which way the user wants to move the character based on which
    // edge of the screen the user touched.
    func commandForTouch(_ touch:UITouch, node:SKNode) -> TouchCommand {
        let location:CGPoint = touch.location(in: node)
        let frame:CGRect = node.frame
        let height = frame.height
        let width = frame.width
        print("Touch position: \(location) x/width: \(location.x/width) y/height: \(location.y/height)")
       
        if (location.y/height < 0.25) {
            return TouchCommand.move_DOWN
        }
        if (location.y/height > 0.75) {
            return TouchCommand.move_UP
        }
        if (location.x/width < 0.25) {
            return TouchCommand.move_LEFT
        }
        if (location.x/width > 0.75) {
            return TouchCommand.move_RIGHT
        }
        return TouchCommand.no_COMMAND
    }
    
    // Function called whenever it is time for the opponent to move
    @objc func moveOpponent(_ timer: Timer) {
        for anOpponent in opponents {
            if let c = self.mainCharacter {
                anOpponent.chaseCharacter(c)
                let samePositionCharacters:[Character] = allCharacters.samePositionAs(anOpponent)
                for otherCharacter in samePositionCharacters {
                    if let theMainCharacter = otherCharacter as? MainCharacter { // If it is the main Character
                        if (theMainCharacter.rammer) { // TODO instead of “false” check if theMainCharacter powered up variable you created is true.  Use . format
                            anOpponent.isHidden = true
                            opponents.remove(anOpponent)
                            allCharacters.remove(anOpponent)
                        }
                        else {
                            gameResultLabel.text = "You Lose!"
                            gameResultLabel.isHidden = false
                            self.endTheGame()
                        }

                    }
                }
            }
        }
    }
    
    // Functions for ending the game and showing the try again screen

    func endTheGame() {
        Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(GameScene.showPlayAgainScreen(_:)), userInfo: nil, repeats: false)
    }
    
    @objc func showPlayAgainScreen(_ timer: Timer) {
        // Show the GameOverScene
        let reveal:SKTransition = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene:GameOverScene = GameOverScene(size:self.frame.size)
        scene.scoreLabel.text = self.scoreLabel.text
        scene.gameResultLabel.text = self.gameResultLabel.text
        scene.scaleMode = SKSceneScaleMode.aspectFill
        if let theView:SKView = self.view {
            theView.presentScene(scene, transition:reveal)
        }
    }
    /*
     Improvements:
      - Try another type of control motion (swipes, dragging a joystick, etc.  Look up the UITouch command documentation
    */
}
