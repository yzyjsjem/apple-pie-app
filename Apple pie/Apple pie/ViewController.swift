//
//  ViewController.swift
//  Apple pie
//
//  Created by 杨振誉 on 2021/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeimageview: UIImageView! //the tree's image
    @IBOutlet weak var correctwordlabel: UILabel!  //the label shows the correctword
    @IBOutlet weak var scorelabel: UILabel! //the label shows how many times win or lose
    
    @IBOutlet var letterbuttons: [UIButton]! //connect with all the buttons
    
    var listofwords = ["one", "eleven", "twentytwo", "thirtythree", "fiftyfive", "sixtysix"]   //an array store all words for the game
    let incorrectmovesallowed = 7 //How many times to lose.
    var totalwins = 0 {
        didSet {
            newround()
        }
    }
    var totallosses = 0 {
        didSet {
            newround()
        }
    }
    var currentgame : Game! // currentgame could have no value at first until videwdidload()
    
    
    @IBAction func buttonpressed(_ sender: UIButton) {
        sender.isEnabled = false //once pressed, the button can't be pressed until next round
        let letterstring = sender.title(for: .normal)! //get sender's title
        let letter = Character(letterstring.lowercased())  // turn the title to lowercase
        currentgame.playerguessed(letter: letter) //use the letter(tapped button) in palyerguessed to check if right
        updategamestate()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newround()   //after the view loaded, start a new round
    }
    
    func newround() {
        if !listofwords.isEmpty {   //if there is still words haven't been used in the list
            let newword = listofwords.removeFirst() //get the frist word from the list can use that start a new game
            currentgame = Game(word: newword, incorrectmovesremaining: incorrectmovesallowed, guessedletters: [])
            enableletterbuttons(true)     //turn all buttons to work
            updateui()
        }
        else{
            enableletterbuttons(false)  // there will be no newround and the buttons still don't work
        }
    }
    
    func enableletterbuttons(_ enable: Bool){     //let buttons work again
        for button in letterbuttons{
            button.isEnabled = enable
        }
    }
    
    func updateui() {
        var letters = [String]() // set a blank array named letters
        for letter in currentgame.formatword { //add formatword from currentgame to the array
            letters.append(String(letter))
        }
        let wordwithspacing = letters.joined(separator: " ") //put letters together but have a space between them
        
        
        correctwordlabel.text = wordwithspacing //update the correctword label
        scorelabel.text = "Wins: \(totalwins), Losses: \(totallosses)"      //update the scorelabel
        treeimageview.image = UIImage(named: "Tree \(currentgame.incorrectmovesremaining)") //update the tree image
        
    }
    
    func updategamestate(){  //check after press the button
        if currentgame.incorrectmovesremaining == 0 {
            totallosses += 1            //if no moves left it will lose
        }
        else if currentgame.word == currentgame.formatword {
            totalwins += 1                //or the word is complete correctly, it will win
        }
        else {
            updateui()   // or update the game and continue
        }
        
    }


}

