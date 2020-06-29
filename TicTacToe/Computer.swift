//
//  Computer.swift
//  TicTacToe
//
//  Created by Bader Alawadh on 6/21/20.
//  Copyright © 2020 Bader Alawadh. All rights reserved.
//

import Foundation
import UIKit

class Computer {
    
    var XImage = UIImage(named: "X")
    var OImage = UIImage(named: "O")
    
    func computerPlays(buttons: [UIButton]) {
        let filteredButtons = self.filteringButtons(buttons: buttons)
        computerChoosing(from: filteredButtons)
    }
    
    func filteringButtons(buttons: [UIButton]) -> [UIButton] {
        
        var unchosenButtons = [UIButton]()
        
        for button in buttons {
            if button.currentBackgroundImage == nil {
                unchosenButtons.append(button)
            }
        }
        return unchosenButtons
    }
    
    func computerChoosing(from buttons: [UIButton]) {
        let randomButton = buttons.randomElement()
        randomButton?.setBackgroundImage(OImage, for: .normal)
    }
    
}
