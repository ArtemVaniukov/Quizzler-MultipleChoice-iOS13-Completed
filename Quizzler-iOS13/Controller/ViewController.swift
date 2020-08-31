//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //Added another button and a corroponding outlet.
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateUI()
    }
    
    // Let's make'em buttons round corners!
    func configureUI() {
        scoreLabel.text = "Score: 0"
        choice1.layer.cornerRadius = 20
        choice2.layer.cornerRadius = 20
        choice3.layer.cornerRadius = 20
    }
    
    // Also let's create custom function to flash button's background with color
    func flashButton(_ button: UIButton, withColor color: UIColor) {
        let originalColor = button.backgroundColor
        button.backgroundColor = color
        UIView.animate(withDuration: 0.4) {
            button.backgroundColor = originalColor
        }
    }

    //New button needs to be linked to this IBAction too.
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        
        let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer)
        
        if userGotItRight {
            flashButton(sender, withColor: UIColor.green)
        } else {
            flashButton(sender, withColor: UIColor.red)
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        
        //Need to fetch the answers and update the button titles using the setTitle method. 
        let answerChoices = quizBrain.getAnswers()
        choice1.setTitle(answerChoices[0], for: .normal)
        choice2.setTitle(answerChoices[1], for: .normal)
        choice3.setTitle(answerChoices[2], for: .normal)
        
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore()
    }

}


























