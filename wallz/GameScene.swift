//
//  GameScene.swift
//  wallz
//
//  Created by Garrett Wesley on 8/28/17.
//  Copyright © 2017 Garrett Wesley. All rights reserved.
//

import SpriteKit
import GameplayKit
//import GoogleMobileAds


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var player:SKSpriteNode!
    var player2:SKSpriteNode!
    var initalPlayerPosition:CGPoint!
    private var scoreLabel = SKLabelNode()
    var score = 0
    private var starfield:SKEmitterNode!
    //private var interstitial: GADInterstitial!
    private var w: CGFloat = 0.0
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    var together: Bool = true
    
    
    
    override func didMove(to view: SKView) {
        
        scoreLabel.fontColor = SKColor.white
        scoreLabel.fontSize = 140
        scoreLabel.text = String(score)
        scoreLabel.position = CGPoint(x: 225, y: 500)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 700)
        starfield.advanceSimulationTime(8)
        self.addChild(starfield)
        starfield.zPosition = -1
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        addPlayer()
        //createAndLoadInterstitial()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if together {
            movePlayerPosition()
            together = false
        }
        else {
            resetPlayerPosition()
            together = true
        }
    }
    
    func movePlayerPosition() {
        let moveUp = SKAction.move(to: CGPoint(x: 0, y: self.size.height / 2), duration: 0.6)
        let moveDown = SKAction.move(to: CGPoint(x: 0, y: -self.size.height / 2), duration: 0.6)
        player.run(moveUp)
        player2.run(moveDown)
    }
    
    
    func resetPlayerPosition() {
        let moveCenter = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.6)
        player.run(moveCenter)
        player2.run(moveCenter)
    }
    
    
    /* Commented out section for ads
     
     fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.load(request)
        print("loaded")
    }
    
    
    
    func showInterstitial(){
        let currentViewController:UIViewController=UIApplication.shared.keyWindow!.rootViewController!
        if interstitial.isReady {
            interstitial.present(fromRootViewController: currentViewController)
        } else {
            print("Ad wasn't ready")
        }
        createAndLoadInterstitial()
    }
 
 */
    
    func addRandomRow () {
        let randomNumber = Int(arc4random_uniform(6))
        
        addRow(type: RowType(rawValue: randomNumber)!)
    }
     
     
 
    
    func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "PLAYER" {
            showGameOver()
        }
    }
    
    
    
    func showGameOver () {
        
        UserDefaults().set(score, forKey: "lastScore")
        let highScore = UserDefaults().integer(forKey: "highscore")
        
        if score > highScore {
            UserDefaults().set(score, forKey: "highscore")
        }
        
        //showInterstitial()
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = EnddScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
        
    }
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate:CFTimeInterval) {
        
        lastYieldTimeInterval += timeSinceLastUpdate
        
        if lastYieldTimeInterval > 1.0 {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if timeSinceLastUpdate > 1 {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        
        scoreLabel.text = String(score)
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
        
    }
}
