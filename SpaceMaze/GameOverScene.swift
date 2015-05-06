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
        self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        
        // Add score label
        self.scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), 20)
        self.scoreLabel.fontSize = 16
        self.scoreLabel.fontName = "Helvetica-Bold"
        self.addChild(self.scoreLabel)
        
        // Add gameResultLabel
        self.gameResultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.gameResultLabel.fontSize = 20
        self.gameResultLabel.fontName = "Helvetica-BoldOblique"
        self.gameResultLabel.fontColor = UIColor.redColor()
        self.addChild(self.gameResultLabel)
        
        // Add tryAgainButton
        self.tryAgainButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.25)
        self.tryAgainButton.name = "tryAgainButton"
        self.addChild(self.tryAgainButton)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in touches {
            let touchAsTouch:UITouch = touch as! UITouch;
            let touchLocation:CGPoint = touchAsTouch.locationInNode(self)
            let node:SKNode = self.nodeAtPoint(touchLocation)
            if node.name == "tryAgainButton" {
                // User pressed the tryAgainButton
                
                // Remove all the previous characters
                allCharacters.removeAllCharacters()
                
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
