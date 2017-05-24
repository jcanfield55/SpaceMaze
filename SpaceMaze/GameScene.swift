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
    var powerUpTreasure:TreasureCharacter?
    
    // Variables for ball repositioning
    var canRepositionBall:Bool = false  // This is set true when mainCharacter eats powerUp Treasure.  When true, ball gets repositioned via touches
    var repositionBallUnderway:Bool = false
    var repositionTouch:UITouch?
    let pickUpBallVicinity:CGFloat = 20  // Distance horizontally or vertically you can touch away from the ball and still pick it up

    
    override func didMove(to view: SKView) {        
        
        /* Setup your scene here */
        self.backgroundColor = color
        
        // Set up timer that will call function moveOpponent every opponentMoveTiming
        opponentTimer = Timer.scheduledTimer(timeInterval: self.opponentMoveTiming, target:self, selector:#selector(GameScene.moveOpponent(_:)), userInfo: nil, repeats: true)

        // Create tunnels
        // Lesson 1 - create tunnels for the maze pattern you want
        let tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode)
        let tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel2.tunnelSpriteNode)
        let tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode)
        let tunnel4 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 4, gridX: 3, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel4.tunnelSpriteNode)
        let tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 6, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel5.tunnelSpriteNode)
        let tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 6, gridX: 1, gridY: 13, colorAlpha: 1.0)
        self.addChild(tunnel6.tunnelSpriteNode)
        let tunnel7 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 5, gridX: 4, gridY: 9, colorAlpha: 1.0)
        self.addChild(tunnel7.tunnelSpriteNode)
        let tunnel8 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 1, gridY: 9, colorAlpha: 1.0)
        self.addChild(tunnel8.tunnelSpriteNode)
        let tunnel9 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel9.tunnelSpriteNode)
        let tunnel10 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 1, gridX: 3, gridY: 4, colorAlpha: 0.0)
        self.addChild(tunnel10.tunnelSpriteNode)
        let tunnel11 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 7, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel11.tunnelSpriteNode)
        let tunnel12 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 5, gridY: 9, colorAlpha: 1.0)
        self.addChild(tunnel12.tunnelSpriteNode)

        
        // Create dots to pick up in tunnels
        for aTunnel in allTunnels {
            for i:Int in 0 ..< aTunnel.length {
                
                if (aTunnel === tunnel10) {
                    let dotCharacter = TreasureCharacter(imageNamed: "hippo", currentTunnel: aTunnel, tunnelPosition: i)
                    self.addChild(dotCharacter)
                }
                else if (aTunnel === tunnel6) && (i == 2) {
                    let tennisBall = TreasureCharacter(imageNamed:"hi my name is tennis ball clip art.png", currentTunnel: aTunnel, tunnelPosition: i)
                    self.addChild(tennisBall)
                    tennisBall.isPowerUp = true
                    powerUpTreasure = tennisBall
                }
                else{
                    let dotCharacter = TreasureCharacter(imageNamed: "grayDot", currentTunnel: aTunnel, tunnelPosition: i)
                    self.addChild(dotCharacter)
                    maxScore += 1   // Keep track of the total number of treasure dots
                }
            }
        }
        
        // Create character
        // Place the sprite in a tunnel
        let newCharacter = MainCharacter(imageNamed:"Spaceship", currentTunnel:tunnel1, tunnelPosition:3)
        newCharacter.rotateWithMovement = true
        self.mainCharacter = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        
        let hippoCharacter = Character(imageNamed:"hippo.png", currentTunnel:tunnel10, tunnelPosition:0)
        self.addChild(hippoCharacter)
        
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
                if self.canRepositionBall {   // If in repositionBall mode, do not move spaceship and keep track of reposition touches
                    if let pt = self.powerUpTreasure {
                        if abs(pt.frame.midX - touch.location(in:self).x) < pickUpBallVicinity && abs(pt.frame.midY - touch.location(in:self).y) < pickUpBallVicinity {
                            repositionBallUnderway = true
                            print("Reposition Underway")
                            repositionTouch = touch
                        }
                    }
                }
                else {
                    let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
                    _ = mainCharacter.moveCharacter(command)
                    
                    // Check if you are on top of a treasure dot, and if so, remove it from the screen and increment your count
                    let samePositionCharacters:[Character] = allCharacters.samePositionAs(mainCharacter)
                    for otherCharacter in samePositionCharacters {
                        if let dotCharacter = otherCharacter as? TreasureCharacter {  // Only remove Treasure characters
                            if (dotCharacter.isPowerUp) {  // If powerUp treasure, do not remove from board.  Turn opponent to dog and go into reposition mode
                                mainCharacter.powerMeUp()
                                let newTexture:SKTexture = SKTexture(imageNamed:"spacedog")
                                for anOpponent in opponents {
                                    anOpponent.texture = newTexture
                                }
                                canRepositionBall = true  // Now go to ball repositioning mode
                            }
                            else {
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
                            }

                        }
                        else if let anOpponent = otherCharacter as? OpponentCharacter { // If it is an opponent
                            if (mainCharacter.powerUp) {   // TODO instead of “false” check if mainCharacter powered up variable you created is true.  Use . format


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
    }
    
    // Responds to movement of touches if repositionBallUnderway is true
    override func touchesMoved(_ touches:Set<UITouch>, with event: UIEvent?) {
        if (repositionBallUnderway) {
            if let powerUpTreasure = self.powerUpTreasure {
                for touch in touches {
                    if touch === repositionTouch { // only move ball if this is the same touch that picked up the ball
                        var closestTunnel:Tunnel?
                        var closestTunnelPosition:Int?
                        var closestDistance:CGFloat = 1000000000
                        for aTunnel in allTunnels {
                            for i:Int in 0 ..< aTunnel.length {
                                let distance:CGFloat = sqrt(pow((touch.location(in:self).x - aTunnel.pointAtTunnelPosition(i).x),2) +
                                pow((touch.location(in:self).y - aTunnel.pointAtTunnelPosition(i).y),2))
                                if (distance < closestDistance) {
                                    closestTunnel = aTunnel
                                    closestTunnelPosition = i
                                    closestDistance = distance
                                }
                            }
                        }
                        if let ct:Tunnel = closestTunnel {
                            powerUpTreasure.currentTunnel = ct
                            if let ctp:Int = closestTunnelPosition {
                                powerUpTreasure.tunnelPosition = ctp
                                print("Reposition move to position \(ctp)")
                                // Move to new position
                                let action:SKAction = SKAction.move(to: powerUpTreasure.currentTunnel.pointAtTunnelPosition(powerUpTreasure.tunnelPosition), duration:0.0)
                                powerUpTreasure.run(action)

                            }
                        }
                    }
                }
            }
        }
    }
    
    // Responds to movement of touches if repositionBallUnderway is true
    override func touchesEnded(_ touches:Set<UITouch>, with event: UIEvent?) {
        if (repositionBallUnderway) {
            if let powerUpTreasure = self.powerUpTreasure {
                for touch in touches {
                    if touch === repositionTouch {
                        repositionBallUnderway = false  // if the repositionTouch is ended, then end repositioning
                        canRepositionBall = false
                        print("Reposition completed")
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
                if (c.powerUp == false) {
                       let newTexture:SKTexture = SKTexture(imageNamed:"AlienSpaceship1.png")
                    for anOpponent in opponents {
                        anOpponent.texture = newTexture
                    }
                }
                if (c.powerUp) {
                    if let pt = self.powerUpTreasure {
                        anOpponent.chaseCharacter(pt)
                    }
                    else {
                        anOpponent.chaseCharacter(c)
                    }
                }
                else {
                    anOpponent.chaseCharacter(c)

                }
                                let samePositionCharacters:[Character] = allCharacters.samePositionAs(anOpponent)
                for otherCharacter in samePositionCharacters {
                    if let theMainCharacter = otherCharacter as? MainCharacter { // If it is the main Character
                        if (theMainCharacter.powerUp) { // TODO instead of “false” check if mainCharacter powered up variable you created is true.  Use . format

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
