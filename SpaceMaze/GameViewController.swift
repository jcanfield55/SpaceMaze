//
//  GameViewController.swift
//  SpaceMaze
//
//  Created by Diana Smetters on 3/24/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//

import UIKit
import AVFoundation
var SuperMario = AVAudioPlayer()
func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
    //1
    var path = NSBundle.mainBundle().pathForResource(file, ofType:type)
    var url = NSURL.fileURLWithPath(path!)
    
    //2
    var error: NSError?
    
    //3
    var audioPlayer:AVAudioPlayer?
    audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    
    //4
    return audioPlayer!
}
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
