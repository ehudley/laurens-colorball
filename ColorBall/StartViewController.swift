
import UIKit
import SpriteKit
import GameplayKit
import GameKit

class StartViewController: UIViewController, GKGameCenterControllerDelegate, StartSceneDelegate {
    

    deinit {
        print("start view controller deinit")
    }

    @IBOutlet var moneyLabel: UILabel!
    
    var scene: MenuScene!
    
    var gameVC: GameViewController?
    
    override func viewDidLoad() {
       // authenticateLocalPlayer()
        super.viewDidLoad()
//        listenForNotifications()
        scene = MenuScene(size: view.bounds.size)
        scene.del = self
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    
    override var prefersStatusBarHidden: Bool {
        return true
    }

//    func listenForNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleGameRestartRequest), name: Notification.Name(rawValue: "gameRestartRequested"), object: nil)
//    }
//
//    @objc func handleGameRestartRequest() {
//        print("restart?")
//        gameVC?.gameOverController?.dismiss(animated: false, completion: {
//            self.gameVC?.scene.removeAllChildren()
//            self.gameVC?.scene.removeAllActions()
//            self.gameVC?.scene.removeFromParent()
//            self.gameVC?.dismiss(animated: false, completion: {
//                self.gameVC = nil
//                self.launchGameViewController()
//            })
//        })
//    }

    func scoreFormatter(score: Int) -> String {
        if score < 10 {
            return "0\(score)"
        }
        return String(score)
    }
    
    
    @IBOutlet var scoreLabel: UILabel!
    
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    var score = 51
    @IBOutlet var volume: UIButton!
    var tonANAUS = 0
    
    // IMPORTANT: replace the red string below with your own Leaderboard ID (the one you've set in iTunes Connect)
    let LEADERBOARD_ID = "identity"

    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: false, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if let err = error { print(err.localizedDescription)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                if let err = error {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func gameCenterPressed() {
        
        // Submit score to GC leaderboard
        let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
        bestScoreInt.value = Int64(score)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
        //open leadboard
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = LEADERBOARD_ID
        present(gcVC, animated: false, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func launchGameViewController() {
        gameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameVC") as? GameViewController
        scene.isPaused = true
//        removeFromParentViewController()
        present(gameVC!, animated: false, completion: nil)
    }
    
    @IBAction func volumeONOFF(_ sender: AnyObject) {
        tonANAUS = tonANAUS + 2
        if(tonANAUS == 2){
            volume.setBackgroundImage(UIImage(named: "Icon-2.png"), for: UIControlState())
        }else{
            tonANAUS = 0
            volume.setBackgroundImage(UIImage(named: "OFF.png"), for: UIControlState())
        }
    }
    
    // start scene delegate protocol methods
    
    func launchGame() {
        launchGameViewController()
    }
    
    func launchShop() {
        // launch the shop
    }
    func ratePressed() {
        print("works")
        rateApp(appId: "idfprStageBallz") { success in
            print("RateApp \(success)")
        }
    }
    
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    func sharePressed() {
        let activityVC = UIActivityViewController(activityItems: ["Playing Stage Ballz is awesome! My best score is 23. Can you beat my score? Get Stage Ballz here https://itunes.apple.com/app/Stage Ballz/id"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }

}
