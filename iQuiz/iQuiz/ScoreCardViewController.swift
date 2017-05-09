//
//  ScoreCardViewController.swift
//  iQuiz
//
//  Created by Derek Han on 5/7/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

class ScoreCardViewController: UIViewController {
    
    var correctAnswers = 0
    var numberQuestions = 0
    var topic = ""

    @IBOutlet weak var CorrectLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var ScoreDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CorrectLabel.text = "\(correctAnswers)"
        TotalLabel.text = "\(numberQuestions)"
        TopicLabel.text = topic
        
        if ((correctAnswers/numberQuestions) == 1) {
            ScoreDescription.text = "Perfect!"
        } else if (Double(Double(correctAnswers)/Double(numberQuestions)) > 0.5) {
            ScoreDescription.text = "Awesome!"
        } else if (Double(Double(correctAnswers)/Double(numberQuestions)) > 0.3) {
            ScoreDescription.text = "Okay!"
        } else {
            ScoreDescription.text = "Better Luck Nextime!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
