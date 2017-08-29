//
//  EnddScene.swift
//  wallz
//
//  Created by Garrett Wesley on 8/28/17.
//  Copyright © 2017 Garrett Wesley. All rights reserved.
//


import SpriteKit
import GameplayKit

class EnddScene: SKScene {
    
    private var gameOver = SKLabelNode()
    private var Score = SKLabelNode()
    private var Best = SKLabelNode()
    private var playButton = SKLabelNode()
    var lastScore: Int!
    var highScore: Int!
    
    override func didMove(to view: SKView) {
        
        let lastScore = UserDefaults().integer(forKey: "lastScore")
        let highScore = UserDefaults().integer(forKey: "highscore")
        
        playButton.fontName = "HelveticaNeue"
        playButton.fontColor = SKColor.white
        playButton.fontSize = 90
        playButton.text = "play"
        playButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.35)
        
        
        
        
        Score.fontName = "HelveticaNeue-Light"
        Score.fontColor = SKColor.white
        Score.fontSize = 200
        Score.text = "\(lastScore)"
        Score.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.68)
        
        Best.fontName = "HelveticaNeue"
        Best.fontColor = SKColor.cyan
        Best.fontSize = 110
        Best.text = "Best \(highScore)"
        Best.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.52)
        
        
        let enlarge = SKAction.scale(to: 1.2, duration: 1)
        let delarge = SKAction.scale(to: 1, duration: 1)
        let forev = SKAction.repeatForever(SKAction.sequence([enlarge, delarge]))
        playButton.run(forev)
        
        addChild(gameOver)
        addChild(Score)
        addChild(playButton)
        addChild(Best)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if playButton.contains(touchLocation) {
            if let view = self.view {
                
                if let scene = SKScene(fileNamed: "GameScene") {
                    
                    scene.scaleMode = .aspectFill
                    let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
                    view.presentScene(scene, transition: reveal)
                    
                }
                
                view.ignoresSiblingOrder = true
                
            }
            
            
        }
        
    }
}
