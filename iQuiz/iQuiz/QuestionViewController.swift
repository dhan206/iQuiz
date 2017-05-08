//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Derek Han on 5/6/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // the quiz being shown
    var quiz: Quiz = Quiz()
    // which question to display, 0 based indexing
    var questionNumber = 0
    // the question to display
    var question: Question = Question()
    var answer: String = ""
    var numberCorrectAnswers = 0
    var showAnswer: Bool = true
    
    @IBOutlet weak var AnswerTitleLabel: UILabel!
    @IBOutlet weak var AnswerText: UILabel!
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var AnswerOptionTable: UITableView!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet var SceneCard: UIView!
    @IBOutlet weak var AnswerImage: UIImageView!
    
    let cellIdentifier = "questionAnswerOptions"
    let ScoreCardSceneSegue = "scoreCardSceneSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the tableview delegate and datasource
        AnswerOptionTable.delegate = self
        AnswerOptionTable.dataSource = self
        // update the topic label breadcrump
        TopicLabel.text = quiz.topic
        
        question = quiz.questions[questionNumber]
        // set question label to display current question
        QuestionLabel.text = question.question
        
        AnswerOptionTable.tableFooterView = UIView()
        AnswerTitleLabel.isHidden = true
        AnswerText.isHidden = true
        AnswerImage.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of answer options
        return question.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let index = indexPath.row
        
        // set option
        cell.textLabel?.text = question.options[index]
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let oldIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: oldIndex)?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.answer = question.options[indexPath.row]
        return indexPath
    }
    
    @IBAction func SubmitAnswer(_ sender: Any) {
        let option: UIViewAnimationOptions = .transitionFlipFromRight
        
        // show question scene
        if (showAnswer) {
            AnswerImage.isHidden = false
            if (self.answer == question.answer) {
                AnswerImage.image = UIImage.init(named: "check-mark")
                numberCorrectAnswers += 1
            } else {
                 AnswerImage.image = UIImage.init(named: "cancel-mark")
            }
            questionNumber += 1
            showAnswer = false
            AnswerOptionTable.isHidden = true
            AnswerTitleLabel.isHidden = false
            AnswerText.isHidden = false
            AnswerText.text = "The correct answer was \(question.answer)"
            if (questionNumber < quiz.questions.count) {
                SubmitButton.setTitle("Next Question", for: .normal)
            } else {
                SubmitButton.setTitle("View Score", for: .normal)
            }
            
        } else { // show answer scene or scorecard
            if (questionNumber < quiz.questions.count) {
                question = quiz.questions[questionNumber]
                AnswerOptionTable.isHidden = false
                AnswerTitleLabel.isHidden = true
                AnswerText.isHidden = true
                QuestionLabel.text = question.question
                AnswerOptionTable.reloadData()
                AnswerImage.isHidden = true
                SubmitButton.setTitle("Submit Answer", for: .normal)
                showAnswer = true
            } else {
                performSegue(withIdentifier: ScoreCardSceneSegue, sender: self)
            }
        }
        UIView.transition(with: self.SceneCard, duration: 0.8, options: option, animations: nil, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == ScoreCardSceneSegue) {
            let viewController = segue.destination as! ScoreCardViewController
            viewController.correctAnswers = self.numberCorrectAnswers
            viewController.numberQuestions = self.quiz.questions.count
            viewController.topic = self.quiz.topic
        }
    }
}
