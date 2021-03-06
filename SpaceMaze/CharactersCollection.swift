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

    var characters:[Character] = []
    
    
    func add(_ newCharacter:Character) {
        for aCharacter in characters {
            if aCharacter === newCharacter {
                return  // no need to add a character if it is already there
            }
        }
        // Otherwise newCharacter really is new, so add it
        self.characters.append(newCharacter)
    }
    
    func removeAllCharacters() {
        characters = []
    }
    
    func remove(_ aCharacter:Character) {
        for i in 0..<characters.count {
            let oneCharacter:Character = characters[i]
            if oneCharacter === aCharacter {
                characters.remove(at: i)
                return
            }
        }
        print("Error: could not find the character to remove")
    }
    
    // Returns an array of all other characters that are in the same location as aCharacter
    // Will not return aCharacter in the return array
    // If no other characters are in the same position, returns an empty array
    func samePositionAs(_ aCharacter:Character) -> [Character] {
        var returnedArray:[Character] = []
        let aPoint:CGPoint = aCharacter.currentTunnel.pointAtTunnelPosition(aCharacter.tunnelPosition)
        for otherCharacter in characters {
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
