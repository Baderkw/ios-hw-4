//
//  ViewController.swift
//  TicTacToe
//
//  Created by Bader Alawadh on 6/19/20.
//  Copyright © 2020 Bader Alawadh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var playerX = Player(team: "X")
    var playerO = Player(team: "O")
    var playerTurn = ""
    var waitingTimer = Timer()
    var winner: Player? = nil
    var computerTimer = Timer()
    var computer = Computer()
    var backgroundMusic: AVAudioPlayer?
    var victorySound: AVAudioPlayer?
    var roosterSound: AVAudioPlayer?
    var clownSound: AVAudioPlayer?
    let backgroundColors = [UIColor.green, UIColor.blue, UIColor.systemTeal, UIColor.magenta, UIColor.systemGray3]
    
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    @IBOutlet weak var playerXLabel: UILabel!
    @IBOutlet weak var winningX: UILabel!
    
    @IBOutlet weak var playerOLabel: UILabel!
    @IBOutlet weak var winningO: UILabel!
    
    
    //Lines.
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    
    
    
    //Buttons.
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        changeTurn()
        playerXLabel.text = playerX.name
        playerOLabel.text = playerO.name
        playBackgroundMusic()
        view.backgroundColor = backgroundColors.randomElement()
        
    }
    
    func configureView() {
        let lines = [line1, line2, line3, line4]
        for line in lines {
            line?.layer.cornerRadius = 7
        }
        
        playerXLabel.layer.cornerRadius = 7
        playerXLabel.layer.masksToBounds = true
        
        winningX.layer.cornerRadius = 7
        winningX.layer.masksToBounds = true
        
        playerOLabel.layer.cornerRadius = 7
        playerOLabel.layer.masksToBounds = true
        
        winningO.layer.cornerRadius = 7
        winningO.layer.masksToBounds = true
    }
    
    @IBAction func playerTapped(_ sender: UIButton) {
        if sender.currentBackgroundImage == nil {
            let buttons = [b0!, b1!, b2!, b3!, b4!, b5!, b6!, b7!, b8!]
            if playerO.isComputer {
                computerPlays(sender: sender, buttons: buttons)
            }else {
                playersPlay(sender: sender)
            }
            
        }
       
    }
    
    func playersPlay(sender: UIButton){
        if playerTurn == playerX.name {
            sender.setBackgroundImage(UIImage(named: "X"), for: .normal)
            playRoosterSound()
        }else {
            sender.setBackgroundImage(UIImage(named: "O"), for: .normal)
            playClownSound()
        }
        vibrate()
        changeTurn()
        checkingWinner(player: playerX)
        
        if winner != nil {
            return
        }
        checkingWinner(player: playerO)
        
        if winner == nil {
            checkingDraw()
        }
        
    }
    
    func computerPlays(sender: UIButton, buttons: [UIButton]) {
        
        sender.setBackgroundImage(UIImage(named: "X"), for: .normal)
        playRoosterSound()
        vibrate()
        checkingWinner(player: playerX)
        if winner != nil {
            return
        }
        computerTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.computer.computerPlays(buttons: buttons)
            self.checkingWinner(player: self.playerO)
        })
        
        
        if winner == nil {
            checkingDraw()
        }
    }
    
    
    func checkingWinner(player: Player) {
        
        if (b0.currentBackgroundImage == UIImage(named: player.team) &&
            b1.currentBackgroundImage == UIImage(named: player.team) &&
            b2.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b3.currentBackgroundImage == UIImage(named: player.team) &&
            b4.currentBackgroundImage == UIImage(named: player.team) &&
            b5.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b6.currentBackgroundImage == UIImage(named: player.team) &&
            b7.currentBackgroundImage == UIImage(named: player.team) &&
            b8.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b0.currentBackgroundImage == UIImage(named: player.team) &&
            b3.currentBackgroundImage == UIImage(named: player.team) &&
            b6.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b1.currentBackgroundImage == UIImage(named: player.team) &&
            b4.currentBackgroundImage == UIImage(named: player.team) &&
            b7.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b2.currentBackgroundImage == UIImage(named: player.team) &&
            b5.currentBackgroundImage == UIImage(named: player.team) &&
            b8.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b0.currentBackgroundImage == UIImage(named: player.team) &&
            b4.currentBackgroundImage == UIImage(named: player.team) &&
            b8.currentBackgroundImage == UIImage(named: player.team)) ||
            
            (b2.currentBackgroundImage == UIImage(named: player.team) &&
            b4.currentBackgroundImage == UIImage(named: player.team) &&
            b6.currentBackgroundImage == UIImage(named: player.team)) {
            
            addWinningTime(to: player)
            winner = player
            showWinnerAlert(player: player)
            view.backgroundColor = backgroundColors.randomElement()
            
        }
        
    }
    func vibrate() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    func showWinnerAlert(player: Player) {
        let alert = UIAlertController(title: "Winner", message: "🔥 \(player.name) is the winner 🔥", preferredStyle: .alert)
        let resetButton = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.reset()
        }
        
        alert.addAction(resetButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDrawAlert() {
        let alert = UIAlertController(title: "Draw", message: "There is no winner.", preferredStyle: .alert)
        let resetButton = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.reset()
        }
        
        alert.addAction(resetButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkingDraw() {
        let buttons = [b0, b1, b2, b3, b4, b5, b6, b7, b8]
        var numberOfTappedButtons = 0
        
        for button in buttons {
            if button?.currentBackgroundImage != nil {
                numberOfTappedButtons += 1
            }
        }
        
        if numberOfTappedButtons == 9 {
            showDrawAlert()
        }
        
    }
    
    func addWinningTime(to player: Player) {
        
        player.winningTimes += 1
        if player.team == "X" {
            winningX.text =  "Won : \(player.winningTimes)"
        }else {
            winningO.text =  "Won : \(player.winningTimes)"
        }
        
        if player.winningTimes == 3 {
            
            winningX.text = "Won: 0"
            winningO.text = "Won: 0"
            
            playerO.winningTimes = 0
            playerX.winningTimes = 0
            playVictorySound()
        }
        
    }
    
    func reset() {
        
        enableButtons(false)
        waitingTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
            
            let buttons = [self.b0, self.b1, self.b2, self.b3, self.b4, self.b5, self.b6, self.b7, self.b8]
            
            for button in buttons {
                button?.setBackgroundImage(nil, for: .normal)
            }
            self.winner = nil
            self.winnerLabel.text = ""
            self.enableButtons(true)
        })
        
    }
    
    func enableButtons(_ bool: Bool) {
        let buttons = [b0, b1, b2, b3, b4, b5, b6, b7, b8]
        for button in buttons {
            button?.isEnabled = bool
        }
    }
    

    func changeTurn() {
        if !playerO.isComputer {
            twoPlayersTurn()
        }else{
            playerTurn = "\(playerX.name)"
        }
        
        playerTurnLabel.text = "Turn: \(playerTurn)"
    }
    
    func twoPlayersTurn() {
        if playerTurn == playerX.name {
            playerTurn = playerO.name
            
        }else if playerTurn == playerO.name {
            playerTurn = playerX.name
            
        }else {
            let turn = [playerX.name, playerO.name]
            playerTurn = turn.randomElement()!
            
        }
    }
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "pinkPantherMusic", withExtension: "m4a") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            backgroundMusic = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = backgroundMusic else { return }

            backgroundMusic?.volume = 0.2
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    func playVictorySound() {
        guard let url = Bundle.main.url(forResource: "victorySound", withExtension: "m4a") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            victorySound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = victorySound else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playRoosterSound() {
        guard let url = Bundle.main.url(forResource: "Rooster", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            roosterSound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = roosterSound else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playClownSound() {
        guard let url = Bundle.main.url(forResource: "Clown", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            clownSound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = clownSound else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}
