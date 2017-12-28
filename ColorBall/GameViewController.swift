//
//  GameViewController.swift
//  ColorBall
//
//  Created by Emily Kolar on 6/18/17.
//  Copyright © 2017 Laurens-Art Ramsenthaler. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, StartGameDelegate, GameScoreDelegate {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var menuBtn: UIButton!
    @IBOutlet var moneyLabel: UILabel!
    
    var scene: GameScene!
    var skView: SKView!
    
    var game: Game!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    func setupGame() {
        createGame()
        setupScene()
        setupUI()
        addPlayedGame()
    }
    
    func createGame() {
        game = Game()
    }
    
    func setupScene() {
        scene = GameScene(size: view.frame.size)
        scene.gameOverDelegate = self
        scene.scoreKeeper = self
        skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    func setupUI() {
        menuBtn.isEnabled = true
        moneyLabel.text = scoreFormatter(score: DataManager.main.money)
    }
    
    func addPlayedGame() {
         DataManager.main.addPlayed()
    }
    
    func increaseScore(byValue: Int) {
        game.increaseScore(byValue: byValue)
        scoreLabel.text = scoreFormatter(score: game.score)
    }
    
    func scoreFormatter(score: Int) -> String {
        if score < 10 {
            return "0\(score)"
        }
        return String(score)
    }
    
    func restartGame() {
        setupGame()
    }
    
    func pauseGame() {
        scene.isPaused = true
        scene.ballTimer?.invalidate()
        let pauseView = PauseView.instanceFromNib() as! PauseView
        pauseView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        pauseView.delegate = self
        self.view.addSubview(pauseView)
    }
    
    func unpauseGame() {
        scene.isPaused = false
        scene.startTimer()
    }

    func gameover() {
        // save the score and add money
        DataManager.main.saveHighScore(newScore: game.score)
        DataManager.main.addMoney(amount: game.score)
        
        // create and present the game over view controller
        let gameVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOverId") as! GameOver
        gameVC.endingScore = game.score
        present(gameVC, animated: false, completion: nil)
    }
    
    func showaltmenu() {
        restartGame()
        scene.isPaused = true
        // get a reference to storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // create an instance of the alt view controller
        let altVC = storyboard.instantiateViewController(withIdentifier: "menu") as! AlternativStart
        // set the delegate to this object
        altVC.delegate = self
        // present the view controller
        present(altVC, animated: false, completion: nil)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        pauseGame()
    }
}
