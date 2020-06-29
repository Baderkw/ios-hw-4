//
//  IntroductionVC.swift
//  TicTacToe
//
//  Created by Bader Alawadh on 6/19/20.
//  Copyright © 2020 Bader Alawadh. All rights reserved.
//

import UIKit

class IntroductionVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playerXTextField: UITextField!
    
    @IBOutlet weak var playerOTextField: UITextField!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var computerSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        playerXTextField.delegate = self
        playerOTextField.delegate = self
        playButton.layer.cornerRadius = 25
    }
    
    @IBAction func endedEditing(_ sender: UITextField) {
        hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func computerPlayer(_ sender: UISwitch) {
        if sender.isOn {
            playerOTextField.isEnabled = false
            playerOTextField.text = ""
        }else {
            playerOTextField.isEnabled = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewController else {
            fatalError()
            
        }
        
        if playerXTextField.text == "" || playerXTextField.text == nil {
            destination.playerX.name = "Player X"
        }else {
            destination.playerX.name = playerXTextField.text!
        }
        
        if playerOTextField.text == "" || playerOTextField.text == nil {
            
            if computerSwitch.isOn {
                destination.playerO.name = "Computer"
                destination.playerO.isComputer = true
            }else {
                destination.playerO.name = "Player O"
            }
        }else {
            destination.playerO.name = playerOTextField.text!
        }
        
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
