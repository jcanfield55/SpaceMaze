//
//  GameScene.swift
//  SpaceMaze
//
//  Created by Diana Smetters on 3/24/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//


import SpriteKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(
        filename, withExtension: nil)
    if (url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer =
        AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}
// Enumeration -- defines a variable class with five different values
enum TouchCommand {
    case MOVE_UP,
    MOVE_DOWN,
    MOVE_LEFT,
    MOVE_RIGHT,
    NO_COMMAND
}
var TotalDots: Int = 0
class GameScene: SKScene {
     let YayLabel:SKLabelNode = SKLabelNode(text:"Nyan Cat Likes Money!!")
        
    /* Properties */
    let color = UIColor(red:0.0, green:0.50, blue:0.50, alpha:1.0)
    var mainCharacter:MainCharacter?
    let opponentMoveTiming:NSTimeInterval = 1.0  // number of seconds between opponent movement
    var opponentTimer:NSTimer?
    var opponents:[OpponentCharacter] = []
    var timeLimit:Int = 0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        YayLabel.position = CGPointMake(200, 500)
        self.addChild(YayLabel)
        self.YayLabel.hidden = true
        
        // Set up timer that will call function moveOpponent every opponentMoveTiming
        opponentTimer = NSTimer.scheduledTimerWithTimeInterval(self.opponentMoveTiming, target:self, selector:Selector("moveOpponent:"), userInfo: nil, repeats: true)

        // Create tunnels
        // Lesson 2b - create tunnels for the maze pattern you want
        var tunnel1 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 17, gridX: 1, gridY: 12, colorAlpha: 1.0)
        self.addChild(tunnel1.tunnelSpriteNode)
        var tunnel2 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 8, gridX: 12, gridY: 12, colorAlpha: 1.0)
        self.addChild(tunnel2.tunnelSpriteNode)
        var tunnel3 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel3.tunnelSpriteNode)
        var tunnel4 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel4.tunnelSpriteNode)
        var tunnel5 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel5.tunnelSpriteNode)
        var tunnel6 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel6.tunnelSpriteNode)
        var tunnel7 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 13, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel7.tunnelSpriteNode)
        var tunnel8 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel8.tunnelSpriteNode)
        var tunnel9 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        /*self.addChild(tunnel9.tunnelSpriteNode)
        var tunnel10 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel10.tunnelSpriteNode)
        var tunnel11 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel11.tunnelSpriteNode)
        var tunnel12 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 13, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel12.tunnelSpriteNode)
        var tunnel13 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel13.tunnelSpriteNode)
        var tunnel14 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel14.tunnelSpriteNode)
        var tunnel15 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel15.tunnelSpriteNode)
        var tunnel16 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel16.tunnelSpriteNode)
        var tunnel17 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 13, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel17.tunnelSpriteNode)
        var tunnel18 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel18.tunnelSpriteNode)
        var tunnel19 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel19.tunnelSpriteNode)
        var tunnel20 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel20.tunnelSpriteNode)
        var tunnel21 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel21.tunnelSpriteNode)
        var tunnel22 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 13, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel22.tunnelSpriteNode)
        var tunnel23 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel23.tunnelSpriteNode)
        var tunnel24 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel24.tunnelSpriteNode)
        var tunnel25 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel25.tunnelSpriteNode)
        var tunnel26 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel26.tunnelSpriteNode)
        var tunnel27 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 13, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel27.tunnelSpriteNode)
        var tunnel28 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel28.tunnelSpriteNode)
        var tunnel29 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel29.tunnelSpriteNode)
        var tunnel30 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel30.tunnelSpriteNode)
        var tunnel31 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 7, gridX: 0, gridY: 5, colorAlpha: 1.0)
        self.addChild(tunnel31.tunnelSpriteNode)
        var tunnel32 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 13, gridX: 1, gridY: 1, colorAlpha: 1.0)
        self.addChild(tunnel32.tunnelSpriteNode)
        var tunnel33 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 4, gridX: 0, gridY: 6, colorAlpha: 1.0)
        self.addChild(tunnel33.tunnelSpriteNode)
        var tunnel34 = Tunnel(orientation:TunnelOrientation.horizontalTunnel, length: 5, gridX: 1, gridY: 2, colorAlpha: 1.0)
        self.addChild(tunnel34.tunnelSpriteNode)
        var tunnel35 = Tunnel(orientation:TunnelOrientation.verticalTunnel, length: 9, gridX: 4, gridY: 4, colorAlpha: 1.0)
        self.addChild(tunnel35.tunnelSpriteNode)
*/

        
        // Create dots to pick up in tunnels
        for aTunnel in allTunnels {
            for var i:Int = 0; i < aTunnel.length; i++ {
                let dotCharacter = TreasureCharacter(imageNamed: "candy", currentTunnel: aTunnel, tunnelPosition: i)
                self.addChild(dotCharacter)
                TotalDots++
                
            }
        }
        
        // Create character
        // Place the sprite in a tunnel
        let newCharacter = MainCharacter(imageNamed:"cat", currentTunnel:tunnel1, tunnelPosition:3)
        self.mainCharacter = newCharacter
        self.addChild(newCharacter)   // Make sprite visible
        newCharacter.rotateWithMovement = true
        
        // Create opponents
        opponents.append(OpponentCharacter(imageNamed: "Tac_nayn", currentTunnel: tunnel3, tunnelPosition: 3))
        
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
                        if mainCharacter.treasureScore >= TotalDots {
                           YayLabel.text = "You Win Dumbass!"
                            println("You Win Dumbass!")
                            self.YayLabel.hidden = false
                            resetGame()
                        } else {
                            println("Treasure score is " + String(mainCharacter.treasureScore))
                        }
                    }
                }
            }
        }
        playBackgroundMusic("SuperMario.mp3")
    }
    
    func resetGame() {
        println("Reset!")
    }
    
    // Figures out which way the user wants to move the character based on which
    // edge of the screen the user touched.
    func commandForTouch(touch:UITouch, node:SKNode) -> TouchCommand {
        let location:CGPoint = touch.locationInNode(node)
        let frame:CGRect = node.frame
        let height = CGRectGetHeight(frame)
        let width = CGRectGetWidth(frame)
       
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
        timeLimit++
        if timeLimit > 120 {
           YayLabel.text = "You Lose Sucker!"
            YayLabel.hidden = false
            println ("You Lose Sucker!")}
        for anOpponent in opponents {
            if let c = self.mainCharacter {
                anOpponent.chaseCharacter(c)
                let samePositionCharacters:[Character] = allCharacters.samePositionAs(anOpponent)
                for otherCharacter in samePositionCharacters {
                    if let mainCharacter = otherCharacter as? MainCharacter { // If it is the main Character
                        YayLabel.text = "You Lose Sucker!"
                        YayLabel.hidden = false
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
                scene.gameResultLabel.text = self.YayLabel.text
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