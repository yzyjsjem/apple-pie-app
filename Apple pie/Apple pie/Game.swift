//
//  Game.swift
//  Apple pie
//
//  Created by 杨振誉 on 2021/10/24.
//

import Foundation

struct Game {
    var word : String   //correct answer
    var incorrectmovesremaining : Int         //how many moves left
    var guessedletters : [Character]        //the player guessedletter
    var formatword : String {
        var guessedword = "" //guessedword stores all the word guessed correctly
        for letter in word {
            if guessedletters.contains(letter) {   //if the guessedletters has some words guessed right, add them to gussedword
                guessedword += "\(letter)"
            }
            else{
                guessedword += "_"  //if guessed wrong, show as a "_"
            }
        }
        return guessedword //for example, the correct answer is one, you tapped word is anmle(guessedletters) the guessedword will be -n- ( the number of "_" the original length of word
    }
    
    
    mutating func playerguessed(letter: Character) {
        guessedletters.append(letter)  //add the new tapped letter to the guessedletters
        if !word.contains(letter){    //if the letter is wrong then delete one move left
            incorrectmovesremaining -= 1
            
        }
    }
    
    
}
