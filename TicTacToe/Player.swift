//
//  Player.swift
//  TicTacToe
//
//  Created by Bader Alawadh on 6/19/20.
//  Copyright © 2020 Bader Alawadh. All rights reserved.
//

import Foundation

class Player {
    var name: String = "Player"
    let team: String
    var winningTimes = 0
    var isComputer = false
    
    init(team: String) {
        self.team = team
    }
}
