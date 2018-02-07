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
    var scoreLabel:SKLabelNode = SKLabelNode(text: "WOW U SUCK")
    var tryAgainButton:SKSpriteNode = SKSpriteNode(imageNamed: "Unknown123")
    var tryAgainButtonWin:SKSpriteNode = SKSpriteNode(imageNamed: "Unknown123")


    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        
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
        self.addChild(self.gameResultLabel)
        
        // Add tryAgainButton
        self.tryAgainButton.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.25)
        self.tryAgainButton.name = "tryAgainButton"
        self.addChild(self.tryAgainButton)

    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let touchLocation:CGPoint = touch.location(in: self)
            let node:SKNode = self.atPoint(touchLocation)
            if node.name == "tryAgainButton" {
                // User pressed the tryAgainButton
                
                // Remove all the previous characters
                allCharacters.removeAllCharacters()
                allTunnels.removeAll()
                
                // Show a fresh GameScene
                let reveal:SKTransition = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene:GameScene = GameScene(size:self.frame.size)
                scene.scaleMode = SKSceneScaleMode.aspectFill
                if let theView:SKView = self.view {
                    theView.presentScene(scene, transition:reveal)
                }
            }
        }
    }

}
