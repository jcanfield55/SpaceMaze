//
//  GameOverScene.swift
//  SpaceMaze
//
//  Created by John Canfield on 5/5/15.
//  Copyright (c) 2015 John Canfield. All rights reserved.
//

import SpriteKit


class GameOverScene: SKScene {
    var gameResultLabel:SKLabelNode = SKLabelNode(text:"Outcome")
    var scoreLabel:SKLabelNode = SKLabelNode(text: "Score: 0")
    var tryAgainButton:SKSpriteNode = SKSpriteNode(imageNamed: "TryAgainButton")

    override func didMoveToView(view: SKView) {
                if self.gameResultLabel.text == "You Win!" {
            let background = SKSpriteNode(imageNamed: "Slime Family.png")
            background.position = CGPointMake(self.size.width/2, self.size.height/2)
            background.size = CGSize(width: self.size.width, height: self.size.height)
            self.addChild(background)

            // Add gameResultLabel
            self.gameResultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            self.gameResultLabel.fontSize = 25
            self.gameResultLabel.fontName = "Helvetica-BoldOblique"
            self.gameResultLabel.fontColor = UIColor.greenColor()
            self.addChild(self.gameResultLabel)

        }
        else {
            self.backgroundColor = UIColor(red:0.7, green:0, blue:0, alpha:1.0)
            // Add gameResultLabel
            self.gameResultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            self.gameResultLabel.fontSize = 25
            self.gameResultLabel.fontName = "Helvetica-BoldOblique"
            self.gameResultLabel.fontColor = UIColor.blackColor()
            self.addChild(self.gameResultLabel)

        }
        
        // Add score label
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), 20)
        self.scoreLabel.fontSize = 16
        self.scoreLabel.fontName = "Helvetica-Bold"
        self.addChild(self.scoreLabel)
        
        
        // Add tryAgainButton
        self.tryAgainButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.25)
        self.tryAgainButton.name = "tryAgainButton"
        self.addChild(self.tryAgainButton)

    }
    
    override func touchesBegan(touches:Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let touchLocation:CGPoint = touch.locationInNode(self)
            let node:SKNode = self.nodeAtPoint(touchLocation)
            if node.name == "tryAgainButton" {
                // User pressed the tryAgainButton
                
                // Remove all the previous characters
                allCharacters.removeAllCharacters()
                allTunnels.removeAll()
                
                // Show a fresh GameScene
                let reveal:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                let scene:GameScene = GameScene(size:self.frame.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                if let theView:SKView = self.view {
                    theView.presentScene(scene, transition:reveal)
                }
            }
        }
    }

}