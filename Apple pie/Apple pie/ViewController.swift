//
//  ViewController.swift
//  Apple pie
//
//  Created by 杨振誉 on 2021/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeimageview: UIImageView!
    @IBOutlet weak var correctwordlabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    
    @IBOutlet var letterbuttons: [UIButton]!
    
    var listofwords = ["one", "eleven", "twentytwo", "thirtythree", "fiftyfive", "sixtysix"]
    let incorrectmovesallowed = 7
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
    var currentgame : Game!
    
    
    @IBAction func buttonpressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterstring = sender.title(for: .normal)!
        let letter = Character(letterstring.lowercased())  //letter是按钮选择的字母
        currentgame.playerguessed(letter: letter)
        updategamestate()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newround()
    }
    
    func newround() {
        if !listofwords.isEmpty {
            let newword = listofwords.removeFirst()
            currentgame = Game(word: newword, incorrectmovesremaining: incorrectmovesallowed, guessedletters: [])
            enableletterbuttons(true)
            updateui()
        }
        else{
            enableletterbuttons(false)
        }
    }
    
    func enableletterbuttons(_ enable: Bool){
        for button in letterbuttons{
            button.isEnabled = enable
        }
    }
    
    func updateui() {
        var letters = [String]()
        for letter in currentgame.formatword {
            letters.append(String(letter))
        }
        let wordwithspacing = letters.joined(separator: " ")
        
        
        correctwordlabel.text = wordwithspacing
        scorelabel.text = "Wins: \(totalwins), Losses: \(totallosses)"
        treeimageview.image = UIImage(named: "Tree \(currentgame.incorrectmovesremaining)")
        
    }
    
    func updategamestate(){
        if currentgame.incorrectmovesremaining == 0 {
            totallosses += 1
        }
        else if currentgame.word == currentgame.formatword {
            totalwins += 1
        }
        else {
            updateui()
        }
        
    }


}

