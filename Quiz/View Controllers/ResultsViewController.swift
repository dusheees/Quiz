//
//  ResultsViewController.swift
//  Quiz
//
//  Created by Андрей on 05.11.2021.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var animalLabel: UILabel!
    let answers: [Answer]
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init?(coder: NSCoder, _ answers: [Answer]) {
        self.answers = answers
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("\(#line) \(#function) init(coder:) has not been implemented")
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = answers.reduce(into: [:]) { counts, answer in
            // counts - словарь
            // counts[answer.type] = (counts[answer.type] ?? 0) + 1
            counts[answer.type, default: 0] += 1
        }
        
//        cортировка
//        let frequencyOfAnswersSorted = frequencyOfAnswers.sorted { pair1, pair2 in
//            pair1.value > pair2.value
//        }
        let frequencyOfAnswersSorted = frequencyOfAnswers.sorted { $0.value > $1.value }
        
        let mostCommandAnswers = frequencyOfAnswersSorted.first!.key
        updateUI(with: mostCommandAnswers)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func updateUI(with animal: AnimalType) {
        animalLabel.text = "Вы это \(animal.rawValue)"
        descriptionLabel.text = animal.definition
    }
    
}
