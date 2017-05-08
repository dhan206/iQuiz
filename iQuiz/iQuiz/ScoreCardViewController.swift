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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CorrectLabel.text = "\(correctAnswers)"
        TotalLabel.text = "\(numberQuestions)"
        TopicLabel.text = topic
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
