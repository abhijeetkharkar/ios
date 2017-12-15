	//
//  GameScene.swift
//  GamePractice
//
//  Created by macbook_user on 10/10/17.
//  Copyright © 2017 macbook_user. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    weak var gameViewController : GameViewController!
    
    let noneCategory: UInt32 = 0x1 << 0
    let asteroidCategory: UInt32 = 0x1 << 1
    let fighterCategory: UInt32 = 0x1 << 2
    let projectileCategory: UInt32 = 0x1 << 3
    
    let playerDatabase:UserDefaults = UserDefaults.standard
    
    private var lastUpdateTime : TimeInterval = 0
    private var spinnyNode : SKShapeNode?
    private var shapeRepo = Array<Array<Array<Any>>>()
    private var spaceFighter : SKSpriteNode!
    private var asteroid : SKSpriteNode!
    private var projectile : SKSpriteNode!
    private var score : Int!
    private var lives : Int!
    private var level : Int!
    private var spawnDuration : Double!
    private var speedDuration : Double!
    private var fighterSpeed : Double!
    
    var levelCrossed:Bool = false
    var levelCounter:Int = 1
    var isTouchEnabled:Bool = true
    
    var playerName:String = ""
    
    override func didMove(to view: SKView) {
        print("didMove")
        
        score = 0
        lives = 3
        level = 1
        speedDuration = 4.0
        spawnDuration = 3.5
        
        physicsWorld.contactDelegate = self
        
        (self.childNode(withName: "gameNameLabel") as! SKLabelNode).run(SKAction.fadeIn(withDuration: 2.0))
        
        loadParticleEmitter()
        
        loadPlayerNode()
        
        let levelLabel = SKLabelNode(text: "Level \(Int(levelCounter))")
        levelCounter = levelCounter + 1
        levelLabel.fontColor = UIColor.red
        levelLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        levelLabel.fontSize = 64
        levelLabel.alpha = 1.0
        levelLabel.fontName = "AvenirNext-Bold"
        self.addChild(levelLabel)
        levelLabel.run(SKAction.fadeOut(withDuration: 2.0))
        //levelLabel.removeFromParent()
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(loadAsteroids),
                SKAction.wait(forDuration: spawnDuration)
                ])
        ))
    }
    
    func loadParticleEmitter() {
        self.backgroundColor = UIColor.black
        
        let path = Bundle.main.path(forResource: "Galaxy", ofType: "sks")
        let celestialBody = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        
        celestialBody.position = CGPoint(x : self.size.width/2, y : self.size.height/2)
        celestialBody.particlePositionRange = CGVector.init(dx: self.size.width, dy: self.size.height)
        celestialBody.name = "galaxy"
        celestialBody.targetNode = self.scene
        
        self.addChild(celestialBody)
    }
    
    /*
     
     */
    func loadPlayerNode() {
        spaceFighter = SKSpriteNode(imageNamed: "Spaceship")
        spaceFighter.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spaceFighter.scale(to: CGSize(width: 160, height: 120))
        spaceFighter.position = CGPoint(x: self.size.width/2, y: 80)
        spaceFighter.name = "spaceFighter"
        spaceFighter.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        spaceFighter.physicsBody?.isDynamic = false
        spaceFighter.physicsBody?.categoryBitMask = fighterCategory
        spaceFighter.physicsBody?.contactTestBitMask = asteroidCategory
        spaceFighter.physicsBody?.collisionBitMask = noneCategory
        spaceFighter.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(spaceFighter)
    }
    
    func loadAsteroids() {
        let randomX = Int(arc4random_uniform(750))
        let randomAsteroid = Int(arc4random_uniform(6))
        var imageName = ""
        
        switch randomAsteroid {
        case 1:
            imageName = "Asteroid1"
        case 2:
            imageName = "Asteroid2"
        case 3:
            imageName = "Asteroid3"
        case 4:
            imageName = "Asteroid4"
        case 5:
            imageName = "Asteroid5"
        default:
            imageName = "Asteroid5"
        }
        
        asteroid = SKSpriteNode(imageNamed: imageName)
        asteroid.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        asteroid.scale(to: CGSize(width: 100, height: 100))
        asteroid.position = CGPoint(x: CGFloat(randomX), y: self.size.height-10)
        asteroid.name = "asteroid"
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        asteroid.physicsBody?.isDynamic = true
        self.addChild(asteroid)
        
        let showerAsteroids = SKAction.move(to: CGPoint.init(x: randomX, y: 0), duration: speedDuration)
        
        //let asteroidShower = SKAction.repeatForever(showerAsteroids)
        let evadedShower = SKAction.removeFromParent()
        
        asteroid?.run(SKAction.sequence([showerAsteroids,evadedShower]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("It did begin")
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "asteroid" {
            collisionBetween(asteroid: nodeA, object: nodeB)
        } else if nodeB.name == "asteroid" {
            collisionBetween(asteroid: nodeB, object: nodeA)
        }
    }
    
    func collisionBetween(asteroid: SKNode, object: SKNode) {
        var isGodlike : Bool = false
        var levelMessage : String = ""
        var levelFontSize : Int = 64
        if(object.name == "projectile") {
            
            if let explosion = SKEmitterNode(fileNamed: "Explosion") {
                explosion.position = asteroid.position
                addChild(explosion)
                explosion.run(SKAction.fadeOut(withDuration: 1.5))
            }
            
            score = score + 5
            (self.childNode(withName: "scoreLabel") as! SKLabelNode).text = "Score: \(Int(score))"
            print("Score= \(Int(score))")
            
            if(score==20) {
                levelCrossed = true
                speedDuration = 3.0
                spawnDuration = 3.0
                fighterSpeed = 0.95
            }
            
            if(score==50) {
                levelCrossed = true
                speedDuration = 2.5
                spawnDuration = 2.0
                fighterSpeed = 0.9
            }
            
            if(score==100) {
                levelCrossed = true
                speedDuration = 2.0
                spawnDuration = 1.0
                fighterSpeed = 0.85
            }
            
            if(score==200) {
                levelCrossed = true
                speedDuration = 2.0
                spawnDuration = 0.5
                fighterSpeed = 0.75
            }
            
            if(score==500) {
                levelCrossed = true
                speedDuration = 1.5
                spawnDuration = 0.3
                fighterSpeed = 0.7
            }
            
            if(score==1000) {
                levelCrossed = true
                isGodlike = true
                speedDuration = 1.5
                spawnDuration = 0.2
                fighterSpeed = 0.65
            }
            
            if(levelCrossed) {
                levelCrossed = false
                if(isGodlike) {
                    levelMessage = "Asteroids, Destroy Space Fighter!!!"
                    levelFontSize = 64
                } else {
                    levelMessage = "Level \(Int(levelCounter))"
                    levelFontSize = 48
                }
                let levelLabel = SKLabelNode(text: levelMessage)
                levelCounter = levelCounter + 1
                levelLabel.fontColor = UIColor.red
                levelLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                levelLabel.fontSize = 64
                levelLabel.alpha = 1.0
                levelLabel.fontName = "AvenirNext-Bold"
                self.addChild(levelLabel)
                levelLabel.run(SKAction.fadeOut(withDuration: 2.0))
                //levelLabel.removeFromParent()
            }
            
        } else if(object.name == "spaceFighter") {
            lives = lives - 1
            if(lives == -1) {
                object.removeFromParent()
                gameOver()
            } else {
                let iAmHurtLabel = SKLabelNode(text: "Aww..That hurt!!")
                iAmHurtLabel.fontColor = UIColor.red
                iAmHurtLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                iAmHurtLabel.fontSize = CGFloat(levelFontSize)
                iAmHurtLabel.alpha = 1.0
                iAmHurtLabel.fontName = "AvenirNext-Bold"
                self.addChild(iAmHurtLabel)
                iAmHurtLabel.run(SKAction.fadeOut(withDuration: 3.0))
                (self.childNode(withName: "livesLabel") as! SKLabelNode).text = "Lives Left: \(Int(lives))"
                print("Lives = \(lives)")
            }            
        }
        asteroid.removeFromParent()
    }
    
    func gameOver() {
        print("Game Over")
        //self.gameViewController?.performSegue(withIdentifier: "homeScreen", sender: self)
        //self.gameViewController.navigationController?.popViewController(animated: true)
        
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontColor = UIColor.red
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        gameOverLabel.fontSize = CGFloat(96)
        gameOverLabel.alpha = 1.0
        gameOverLabel.fontName = "AvenirNext-Bold"
        self.addChild(gameOverLabel)
        self.isTouchEnabled = false
        //gameOverLabel.run(SKAction.fadeOut(withDuration: 3.0))
        
        var topScores : String = ""
        gameOverLabel.run(SKAction.sequence([SKAction.fadeOut(withDuration: 2.0)]))
        
        topScores = self.saveScore()
        
        print("Top Score in gameOver() = \(topScores)")
        
        let topScoreLabel = SKLabelNode(text: "Top Scores: \(topScores)")
        topScoreLabel.fontColor = UIColor.orange
        topScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        topScoreLabel.fontSize = CGFloat(32)
        topScoreLabel.alpha = 1.0
        topScoreLabel.fontName = "AvenirNext-Bold"
        self.addChild(topScoreLabel)
        
        topScoreLabel.run(SKAction.sequence([SKAction.fadeOut(withDuration: 10.0), SKAction.run {
            self.gameViewController.viewDidLoad()
            }]))
    }
    
    func saveScore() -> String {
        /*
         Changes for storing the tap game records for the active player
         */
        var topScores : String = ""
        
        if(playerDatabase.object(forKey: "activeUserKey") != nil) {
            let activePlayerKey = playerDatabase.object(forKey: "activeUserKey") as! String
            let data = NSKeyedUnarchiver.unarchiveObject(with: playerDatabase.data(forKey: activePlayerKey)!)
            let player = data as! Player
            
            playerName = player.name
            
            //What has to be done in case of an exception while converting a String to Double? How to set the "rpn" value to 0.0 in such a case
            
            let matches = player.matchesPlayed!
            let avgScore = player.averageScore!
            let highScore = player.highScore!
            var scoreList = player.scoreList
            
            print("Score List from User Defaults = \(scoreList)")
            
            player.matchesPlayed = matches + 1
            player.averageScore = ((avgScore * Double(matches))+Double(score))/Double((matches+1))
            player.highScore = score > highScore ? score : highScore
            
            scoreList.append(score)
            scoreList.sort{$0 > $1}
            
            print("Score List after appending = \(scoreList)")
            
            scoreList.removeLast()
            
            print("Score List after removing least = \(scoreList)")
            
            player.scoreList = scoreList
            
            
            topScores = String(scoreList[0]) + ", " + String(scoreList[1]) + ", "
            topScores = topScores + String(scoreList[2])+", "+String(scoreList[3])+", "+String(scoreList[4])
            
            print("Top Score String = \(topScores)")
            
            //topScores.remove(at: topScores.endIndex)
            
            print("HMatches=\(matches), HAvgScore=\(avgScore), HHighScore=\(highScore), CMatches=\(player.matchesPlayed), CAvgScore=\(player.averageScore), CHighScore=\(player.highScore)")
            
            /*
             NSKeyedArchiver.archivedData(withRootObject: player) is used to encode data before inserting in UserDefaults
             */
            let encodedData:Data = NSKeyedArchiver.archivedData(withRootObject: player)
            playerDatabase.set(encodedData, forKey: activePlayerKey)
            playerDatabase.synchronize()
        }
        
        //self.gameViewController.viewDidLoad()
        return topScores
    }
    
    /*
    func loadObjectArray() {
        print ("Called")
        let objHeight = (self.size.height * 0.02)
        let sW = self.size.width
        print("Width=\(self.size.width), New Width=\(sW), Height = \(self.size.height)")
        shapeRepo = [[[sW * 0.3, UIColor.blue, 1],[sW * 0.4, UIColor.orange, 1],[sW * 0.3, UIColor.yellow, 1]],
                        [[sW * 0.2, UIColor.red, 1],[sW * 0.3, UIColor.blue, 1],[sW * 0.5, UIColor.green, 1]],
                        [[sW * 0.5, UIColor.orange, 1],[sW * 0.2, UIColor.red, 1],[sW * 0.3, UIColor.blue, 1]],
                        [[sW * 0.4, UIColor.magenta, 1],[sW * 0.5, UIColor.yellow, 1],[sW * 0.1, UIColor.red, 1]],
                        [[sW * 0.1, UIColor.yellow, 1],[sW * 0.2, UIColor.purple, 1],[sW * 0.7, UIColor.orange, 1]],
                        [[sW * 0.6, UIColor.purple, 1],[sW * 0.1, UIColor.red, 1],[sW * 0.3, UIColor.yellow, 1]]]
        
        //print(shapeRepo)
        
        var heightConstant:Double = Double(self.size.height) - (Double(self.size.height) * 0.02 / 2)
        for i in 0 ..< 10 {
            let randomInt = Int(arc4random_uniform(6))
            let repoRow = shapeRepo[randomInt]
            var widthConstant:Double = 0.0
            print ("Called for \(i)")
            for j in 0 ... repoRow.endIndex - 1 {
                widthConstant = widthConstant + Double(repoRow[j][0] as! CGFloat)/2
                let startPosition = CGPoint(x: widthConstant, y: heightConstant)
                print ("Row = \(randomInt), Column = \(j), Scene Width = \(self.size.width), startPosition = \(startPosition), width = \(repoRow[j][0])")
                let temp:SKShapeNode = createShapeNode(blockHeight : objHeight, attributes : repoRow[j], startPosition: startPosition)
                self.addChild(temp)
                widthConstant = widthConstant + Double(repoRow[j][0] as! CGFloat)/2
            }
            heightConstant = heightConstant - Double(objHeight)
        }
    }
    
    func createShapeNode(blockHeight : CGFloat, attributes : Array<Any>, startPosition : CGPoint) -> SKShapeNode{
        let buildingBlock:SKShapeNode = SKShapeNode.init(rectOf: CGSize.init(width: (attributes[0] as! CGFloat), height: blockHeight))
        if(attributes[2] as! Int == 1) {
            buildingBlock.fillColor = attributes[1] as! UIColor
        } else {
            buildingBlock.fillColor = attributes[1] as! UIColor
        }
        
        buildingBlock.position = startPosition
        
        return buildingBlock
    }
    */
    
    override func sceneDidLoad() {
        print("Scene Called")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            self.childNode(withName: "spaceFighter")?.position = location
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isTouchEnabled) {
            for touch in touches {
                let location = touch.location(in: self)
                let moveStarted = SKAction.move(to: location, duration: 1)
                self.childNode(withName: "spaceFighter")?.run(SKAction.sequence([moveStarted]))
                //print(self.children)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesEnded")
        if(isTouchEnabled) {
            projectile = SKSpriteNode(imageNamed: "projectile")
            projectile.position = (self.childNode(withName: "spaceFighter")?.position)!
            projectile.name = "projectile"
            projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.height/2)
            projectile.physicsBody?.isDynamic = false
            projectile.physicsBody?.categoryBitMask = projectileCategory
            projectile.physicsBody?.contactTestBitMask = asteroidCategory
            projectile.physicsBody?.collisionBitMask = noneCategory
            projectile.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(projectile)
            let shotFired = SKAction.move(to: CGPoint(x: projectile.position.x,y: self.size.height), duration: 2.0)
            let shotEnded = SKAction.removeFromParent()
            projectile.run(SKAction.sequence([shotFired, shotEnded]))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesCancelled")
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
