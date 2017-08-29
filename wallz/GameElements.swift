//
//  GameElements.swift
//  wallz
//
//  Created by Garrett Wesley on 8/28/17.
//  Copyright © 2017 Garrett Wesley. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
}

enum ObstacleType:Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType:Int {
    case topS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
}


extension GameScene {
    
    func addPlayer() {
        player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: 0, y: 0)
        player.name = "PLAYER"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        player.color = UIColor.cyan
        
        player2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player2.position = CGPoint(x: 0, y: 0)
        player2.name = "PLAYER"
        player2.physicsBody?.isDynamic = false
        player2.physicsBody = SKPhysicsBody(rectangleOf: player2.size)
        player2.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player2.physicsBody?.collisionBitMask = 0
        player2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        player2.color = UIColor.cyan
        
        addChild(player)
        addChild(player2)
        
        initalPlayerPosition = player.position
        
    }
    
    
    func addObstacle (type:ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 50, height: 0))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        
        switch type {
            
        case .Small:
            obstacle.size.height = self.size.height * 0.17
            break
        case .Medium:
            obstacle.size.height = self.size.height * 0.28
            break
        case .Large:
            obstacle.size.height = self.size.height * 0.5
            break
            
        }
        
        obstacle.position = CGPoint(x: self.size.width / 2 + 50, y: 0)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        
        return obstacle
        
    }
    
    
    func addMovement (obstacle:SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: -1 * (self.size.width + 50), y: obstacle.position.y), duration: TimeInterval(2.8)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
    }
    
    
    
    func addRow (type:RowType) {
        switch type {
        case .topS:
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            
            obst1.position = CGPoint(x: obst1.position.x, y: self.size.height / 2 - obst1.size.height/2)
            obst2.position = CGPoint(x: obst2.position.x, y: -1 * (self.size.height / 2 - obst2.size.height/2))
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            score += 1
            break
        case .oneM:
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: obst.position.x, y: 0)
            addMovement(obstacle: obst)
            addChild(obst)
            score += 1
            break
        case .oneL:
            let obst = addObstacle(type: .Large)
            obst.position = CGPoint(x: obst.position.x, y: 0)
            addMovement(obstacle: obst)
            addChild(obst)
            score += 1
            break
        case .twoS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.position.x, y: obst1.size.height + 50)
            obst2.position = CGPoint(x: obst2.position.x, y: -1*(obst2.size.height + 50))
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            score += 1
            break
        case .twoM:
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            
            obst1.position = CGPoint(x: obst1.position.x, y: obst1.size.height / 2 + 150)
            obst2.position = CGPoint(x: obst2.position.x, y: -1*(obst2.size.height / 2 + 150))
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            score += 1
            break
        case .threeS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let obst3 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.position.x, y: self.size.height / 2 - obst1.size.height/2) // Top
            obst2.position = CGPoint(x: obst2.position.x, y:  -1 * (self.size.height / 2 - obst2.size.height/2)) // Bottom
            obst3.position = CGPoint(x: obst3.position.x, y: 0) // Center
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            score += 1
            break
            
        }
    }
}
