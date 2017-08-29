//
//  GameViewController.swift
//  wallz
//
//  Created by Garrett Wesley on 8/28/17.
//  Copyright © 2017 Garrett Wesley. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuScene = MenuScene(size: view.bounds.size)
        
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        menuScene.scaleMode = .resizeFill
        skView.presentScene(menuScene)
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
