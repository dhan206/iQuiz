//
//  QuizTopicViewController.swift
//  iQuiz
//
//  Created by Derek Han on 5/2/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

// Quiz struct
struct Quiz {
    var topic: String
    var description: String
    var icon: String
    var questions: [Question]
    
    // empty initializer
    init() {
        self.topic = ""
        self.description = ""
        self.icon = ""
        self.questions = []
    }
    
    init(topic: String, description: String, icon: String, questions: [Question]) {
        self.topic = topic
        self.description = description
        self.icon = icon
        self.questions = questions
    }
}

// Question struct
struct Question {
    var question: String
    var answer: String
    var options: [String]
    
    init() {
        self.question = ""
        self.answer = ""
        self.options = []
    }
    
    init(question: String, answer: String, options: [String]) {
        self.question = question
        self.answer = answer
        self.options = options
    }
}

protocol QuizDelegate: class {
    func changeScene(quiz: Quiz)
}

// NSObject,
class QuizTopicDataModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: QuizDelegate?
    
    var Quizzes: [Quiz] = [
        Quiz(topic: "Mathematics", description: "The study of topics such as quanitity, structure, space, and change.", icon: "mathIcon", questions: [
            Question(question: "What is the sum of 1 + 1?", answer: "2", options: ["1", "2","3","4"]),
            Question(question: "What is the product of 3 x 3?", answer: "9", options: ["27", "12", "-19", "9"]),
            Question(question: "What is the the total of 5 - 5?", answer: "0", options: ["5", "0", "-10", "10"]),
            Question(question: "What is the result of 6 / 3?", answer: "2", options: ["1", "10", "2", "5"])
            ]
        ),
        Quiz(topic: "Marvel Super Heroes", description: "Comic book superheroes: Spiderman, Ironman, The Hulk and more.", icon: "marvelIcon", questions: [
            Question(question: "Which superhero wears red, blue and black?", answer: "Spiderman", options: ["Iron Man", "The Hulk", "Spiderman", "Captain America"])
            ]
        ),
        Quiz(topic: "Science", description: "Science is curiosity in thoughtful action about the world and how it behaves.", icon: "scienceIcon", questions: [
            Question(question: "What is the process plants use to make enegery?", answer: "Photosynthesis", options: ["Photosynthesis", "The Creb Cycle", "ATP Synthase", "Cytokinesis"])
            ]
        )
    ]
    
    let cellIdentifier = "QuizTopicCellIdentifier"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ QuizTopicTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let index = indexPath.row
        
        let quizTopic = Quizzes[index]
        
        
        // set title
        cell.textLabel?.text = quizTopic.topic
        
        
        // set description
        cell.detailTextLabel?.text = quizTopic.description
        cell.detailTextLabel?.numberOfLines = 0 // allows for wrap text
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping // allows for wrap text
        
        // set image
        cell.imageView?.image = UIImage.init(named: quizTopic.icon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        
        delegate?.changeScene(quiz: Quizzes[index])
    }
}

class QuizTopicViewController: UIViewController, QuizDelegate {
    
    @IBOutlet weak var QuizTopicTableView: UITableView!
    
    let QuizTopicData = QuizTopicDataModel()
    let QuestionSceneSegue = "questionSceneSegue"
    var selectedQuiz: Quiz = Quiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuizTopicTableView.delegate = QuizTopicData
        QuizTopicTableView.dataSource = QuizTopicData
        QuizTopicData.delegate = self
        QuizTopicTableView.tableFooterView = UIView()
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingsAlert = UIAlertController(title: "Settings Alert Message", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        settingsAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    func changeScene(quiz: Quiz) {
        self.selectedQuiz = quiz
        performSegue(withIdentifier: QuestionSceneSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == QuestionSceneSegue) {
            let viewController = segue.destination as! QuestionViewController
            viewController.quiz = self.selectedQuiz
        }
    }
}
