//
//  CharactersCollection.swift
//  SpaceMaze
//
//  Created by John Canfield on 4/7/15.
//  Copyright (c) 2015 John Canfield. All rights reserved.
//
//  This class keeps track of all the characters in the game

import Foundation
import SpriteKit

var allCharacters:CharacterCollection = CharacterCollection()

class CharacterCollection {

    var characters:NSMutableSet
    
    init() {
        characters = NSMutableSet()
    }
    
    func add(newCharacter:Character) {
        self.characters.addObject(newCharacter)
    }
    
    func remove(aCharacter:Character) {
        self.characters.removeObject(aCharacter)
    }
    
    // Returns an array of all other characters that are in the same location as aCharacter
    // Will not return aCharacter in the return array
    // If no other characters are in the same position, returns an empty array
    func samePositionAs(aCharacter:Character) -> [Character] {
        var returnedArray:[Character] = [Character]()
        let aPoint:CGPoint = aCharacter.currentTunnel.pointAtTunnelPosition(aCharacter.tunnelPosition)
        for otherCharacter in self.characters.allObjects as [Character] {
            if otherCharacter != aCharacter {
                let bPoint:CGPoint = otherCharacter.currentTunnel.pointAtTunnelPosition(otherCharacter.tunnelPosition)
                if bPoint.x == aPoint.x && bPoint.y == aPoint.y {
                    returnedArray.append(otherCharacter)
                }
            }
        }
        return returnedArray
    }

}