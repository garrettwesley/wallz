//
//  MenuScene.swift
//  wallz
//
//  Created by Garrett Wesley on 8/28/17.
//  Copyright © 2017 Garrett Wesley. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    //private var starfield:SKEmitterNode!
    private var playButton = SKLabelNode()
    
    
    override func didMove(to view: SKView) {
        playButton.fontColor = SKColor.white
        playButton.fontName = "HelveticaNeue"
        playButton.fontSize = 48
        playButton.text = "play"
        playButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        addChild(playButton)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //touchesBegan() is called whenever the user touches down on the screen
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if playButton.contains(touchLocation) {
            if let view = self.view {
                
                if let scene = SKScene(fileNamed: "GameScene") {
                    
                    scene.scaleMode = .aspectFill
                    let reveal = SKTransition.doorsOpenVertical(withDuration: 1.5)
                    view.presentScene(scene, transition: reveal)
                    
                }
                
                view.ignoresSiblingOrder = true
                
            }
            
            
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
