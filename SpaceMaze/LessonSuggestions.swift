//
//  LessonSuggestions.swift
//  SpaceMaze
//
//  Created by John Canfield on 4/28/15.
//  Copyright (c) 2015 John Canfield. All rights reserved.
//

// This file just has suggestions for things to add to your Swift project

// In Character.swift, uncomment and add the line below after if(canMove) if you want sound along with every movement of a character
// You will also need to get a wav file you can play (use a short one)
// runAction(SKAction.playSoundFileNamed("pac.wav", waitForCompletion: true))



// You can add labels in GameScene.swift as follows:
// Right under the GameScene class definition, add:
//   var gameResultLabel:SKLabelNode = SKLabelNode(text:"Outcome")
//   var scoreLabel:SKLabelNode = SKLabelNode(text: "Score: 0")
//
// At the end of the didMoveToView method:
/*
self.scoreLab/Users/fablearner/Desktop/FAB Swift Programming/SpaceMaze/SpaceMaze/squirrel.pngel.position = CGPointMake(CGRectGetMidX(self.frame), 20)
self.scoreLabel.fontSize = 16
self.scoreLabel.fontName = "Helvetica-Bold"
self.addChild(self.scoreLabel)
self.gameResultLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
self.gameResultLabel.fontSize = 20
self.gameResultLabel.fontName = "Helvetica-BoldOblique"
self.gameResultLabel.fontColor = UIColor.redColor()
self.gameResultLabel.hidden = true
self.addChild(self.gameResultLabel)
*/
// In the touchesBegan function:
/*
if let dotCharacter = otherCharacter as? TreasureCharacter {  // Only remove Treasure characters
    dotCharacter.hidden = true
    allCharacters.remove(dotCharacter)
    mainCharacter.treasureScore++
    println("Treasure score is " + String(mainCharacter.treasureScore))
    self.scoreLabel.text = "Score: \(mainCharacter.treasureScore)"
    if (mainCharacter.treasureScore >= maxScore) {
        gameResultLabel.text = "You Win!"
        gameResultLabel.hidden = false
    }
}
else if let opponent = otherCharacter as? OpponentCharacter { // If it is an opponent
    gameResultLabel.text = "You Lose!"
    gameResultLabel.hidden = false
    
}
*/
// In moveOpponents function
/*
if let c = self.mainCharacter {
    anOpponent.chaseCharacter(c)
    let samePositionCharacters:[Character] = allCharacters.samePositionAs(anOpponent)
    for otherCharacter in samePositionCharacters {
        if let mainCharacter = otherCharacter as? MainCharacter { // If it is the main Character
            gameResultLabel.text = "You Lose!"
            gameResultLabel.hidden = false
        }
    }
}
*/

