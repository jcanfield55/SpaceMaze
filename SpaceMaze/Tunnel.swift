//
//  Tunnel.swift
//  SpaceMaze
//
//  Created by John Canfield on 3/28/15.
//

import Foundation
import SpriteKit


enum TunnelOrientation {
    case verticalTunnel,
    horizontalTunnel
}

var allTunnels:[Tunnel] = [Tunnel]()

class Tunnel {
    
    let orientation:TunnelOrientation
    let length:Int
    let tunnelCenter:CGPoint
    var visibility:CGFloat
    var connectingTunnels:[Tunnel?]
    var connectingPositions:[Int?]
    var tunnelSpriteNode:SKSpriteNode
    /* Initializer method */
    // Lesson 2c - add the ability to create "invisible" or mostly invisible tunnels.
    // Add some invisible (secret) tunnels to your maze
    
    init(orientation:TunnelOrientation, length:Int, gridX:Int, gridY:Int, visibility:CGFloat) {
        self.orientation = orientation
        self.length = length
        self.visibility = visibility
        
        // Calculate the height and width
        var height:CGFloat = 0.0
        var width:CGFloat = 0.0
        if (self.orientation == TunnelOrientation.verticalTunnel) {
            width = gridSize;
            height = gridSize * CGFloat(self.length);
        } else {
            height = gridSize ;
            width = gridSize * CGFloat(self.length);
        }
        let tunnelSize:CGSize = CGSizeMake(width - (tunnelBoundaryDistance * 2), height - (tunnelBoundaryDistance * 2));
        
        // Set position
        tunnelCenter =  CGPointMake(CGFloat(gridX) * gridSize + (width/2) + xPadding, CGFloat(gridY) * gridSize + (height/2) + yPadding)
        
        // Initializing connecting tunnel arrays
        connectingTunnels = [Tunnel?](count:length, repeatedValue:nil)
        connectingPositions = [Int?](count:length, repeatedValue:nil)
        
        // Create tunnelSpriteNode
        let tunnelColor = UIColor(white: 1.0, alpha: visibility)
        
        // Hey everyone, Gus & Kevin found out how to put a tile background into their tunnel.
        // Uncomment the below to try it
        // let aTexture = SKTexture(imageNamed: "squirrel.png")
        // tunnelSpriteNode = SKSpriteNode(texture: aTexture,
        //     color:tunnelColor,
        //     size: tunnelSize)
        // (and comment out the tunnelSpriteNode assignment below
        
        tunnelSpriteNode = SKSpriteNode(color: tunnelColor, size: tunnelSize)
        tunnelSpriteNode.position = self.tunnelCenter
        
        // Search for connecting tunnels and update connectingTunnels array
        println("New Tunnel")
        for otherTunnel in allTunnels {
            if otherTunnel.orientation != self.orientation {   // Only connect tunnels of opposite orientation
                for otherPos in 0...otherTunnel.length-1 {
                    for selfPos in 0...self.length-1 {
                        if self.pointAtTunnelPosition(selfPos) == otherTunnel.pointAtTunnelPosition(otherPos) {
                            println("Found Connecting Tunnel \(selfPos) \(otherPos)")
                            // The tunnels overlap, so set the connectingTunnels
                            self.connectingTunnels[selfPos] = otherTunnel
                            self.connectingPositions[selfPos] = otherPos
                            otherTunnel.connectingTunnels[otherPos] = self;
                            otherTunnel.connectingPositions[otherPos] = selfPos
                        }
                    }
                }
            }
        }
        allTunnels.append(self)  // Add this tunnel to allTunnel tracker
    }
    
    func pointAtTunnelPosition(position:Int) -> CGPoint {
        var point:CGPoint = CGPointMake(0.0, 0.0)
        if self.orientation == TunnelOrientation.horizontalTunnel {
            point.x = self.tunnelCenter.x + (CGFloat(position) - (CGFloat(self.length)/2 - 0.5)) * gridSize
            point.y = self.tunnelCenter.y
        } else {
            point.y = self.tunnelCenter.y + (CGFloat(position) - (CGFloat(self.length)/2 - 0.5)) * gridSize
            point.x = self.tunnelCenter.x
        }
        return point
    }
    
    // Checks if a character in the specified position can move in the requested direction
    // If checkConnections == true, then checks not just self, but any tunnels connected to self
    // Returns the following three values:
    //    1) True if a character can move at all, false otherwise
    //    2) The tunnel the character is in after the move (usually self, but could be a new tunnel)
    //    3) The position in the specified the tunnel the character is now in
    //
    func canMoveInDirection(direction:TouchCommand, position:Int, checkConnections:Bool) -> (Bool, Tunnel, Int) {
        if (self.orientation == TunnelOrientation.verticalTunnel) {
            if (direction == TouchCommand.MOVE_UP && position < self.length - 1) {
                return (true, self, position+1); // Can move up except at top of tunnel
            }
            else if (direction == TouchCommand.MOVE_DOWN && position > 0) {
                return (true, self, position-1);  // Can move down except at end of tunnel
            }
        }
        else {  // Horizontal tunnel
            if (direction == TouchCommand.MOVE_LEFT && position > 0) {
                return (true, self, position-1);  // Can move left except at beginning of tunnel
            }
            else if (direction == TouchCommand.MOVE_RIGHT && position < self.length - 1) {
                return (true, self, position+1);  // Can move right except at end of tunnel
            }
        }
        
        // if cannot move in current tunnel, check if a connecting tunnel allows movement
        if (checkConnections && self.connectingTunnels[position] != nil) {
            if let otherTunnel:Tunnel = self.connectingTunnels[position] {
                if let otherPos:Int = self.connectingPositions[position] {
                    return otherTunnel.canMoveInDirection(direction,position:otherPos,checkConnections:false)
                }
            }
        }
        return (false, self, position); // No connecting tunnels
    }
    
}
