//
//  Game.swift
//  Apple pie
//
//  Created by 杨振誉 on 2021/10/24.
//

import Foundation

struct Game {
    var word : String
    var incorrectmovesremaining : Int
    var guessedletters : [Character]
    var formatword : String {
        var guessedword = ""
        for letter in word {
            if guessedletters.contains(letter) {
                guessedword += "\(letter)"
            }
            else{
                guessedword += "_"
            }
        }
        return guessedword
    }
    
    
    mutating func playerguessed(letter: Character) {
        guessedletters.append(letter)
        if !word.contains(letter){
            incorrectmovesremaining -= 1
            
        }
    }
    
    
}
