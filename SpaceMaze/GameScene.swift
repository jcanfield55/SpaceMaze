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
    /* A useful constant we'll use later */
    let PI = CGFloat(M_PI)
    
    /* Properties */
    let character = SKSpriteNode(imageNamed: "PacMan")  // use Spaceship.png file for the image of the sprite
    let color = UIColor(red:0.25, green:0.25, blue:0.50, alpha:1.0)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = color
        character.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        character.setScale(0.10)
        self.addChild(character)   // Make sprite visible
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in touches {
            let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
            
            var move_x:CGFloat = 0
            var move_y:CGFloat = 0
            
            // Here is where you need to insert you code to set how much
            // to move in the x direction (left / right) or the y direction (up / down)
            if (command == TouchCommand.MOVE_UP) {
                move_y = 30
                self.character.zRotation = PI * 2
            }
            if (command == TouchCommand.MOVE_DOWN) {
                move_y = -30
                self.character.zRotation = PI * 1
            }
            if (command == TouchCommand.MOVE_LEFT) {
                move_x = -30
                self.character.zRotation = PI * 0.5
            }
            if (command == TouchCommand.MOVE_RIGHT) {
                move_x = 30
                self.character.zRotation = PI * 1.5

            }
            if (move_x != 0 || move_y != 0) {
                let action:SKAction = SKAction.moveByX(move_x, y: move_y, duration: 0.25)
                self.character.runAction(action)
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

    /*
     
        Hey! I finished all that. What do I do now?

        1. Change your spaceship to a PacMan or...
        2. Change the color of your background.
        3. Make your spaceship rotate when you move it. A hint:
                self.character.zRotation = PI * 0.5
        4. Make your game "wrap" -- when the spaceship goes off the right side of the screen,
            have it reappear on the left. A hint:
                location.x = location.x % width
    
    */
}