//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Андрей on 04.11.2021.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multiplyStackView: UIStackView!
    @IBOutlet var multyLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    private var answersChoosen = [Answer]() {
        didSet {
            print(#line, #function, answersChoosen)
        }
    }
    
    // Можем вызвать любое из вычислимых свойств в любом месте
    private var currentAnswers: [Answer] {
        currentQuestion.answers
    }
    
    private var currentQuestion: Question {
        Question.all[questionIndex]
    }
    
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rangedSlider.maximumValue = 0.99999
        updateUI()
    }

    func updateUI() {
        
        func updateSingleStack() {
            singleStackView.isHidden = false
            for (index, button) in singleButtons.enumerated() {
                button.tag = index
                button.setTitle(nil, for: [])
            }
            for (button, answer) in zip(singleButtons, currentAnswers) {
                button.setTitle(answer.text, for: [])
            }
        }
        
        func updateMultipleStack() {
            multiplyStackView.isHidden = false
            for label in multyLabels {
                label.text = nil
            }
            for (label, answer) in zip(multyLabels, currentAnswers) {
                label.text = answer.text
            }
        }
        
        func updateRangedStack() {
            rangedStackView.isHidden = false
            rangedLabels.first?.text = currentAnswers.first?.text
            rangedLabels.last?.text = currentAnswers.last?.text
        }
        
        for stackView in [singleStackView, multiplyStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiply:
            updateMultipleStack()
        case .range:
            updateRangedStack()
        }
        
    }
    
    func nextQuestion() {
        // TODO: change to segue to results screen
        questionIndex += 1
        if questionIndex < Question.all.count{
            updateUI()
        } else {
            performSegue(withIdentifier: "Results Segue", sender: nil)
        }
    }
    
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = Question.all[questionIndex].answers
        let index = sender.tag
        guard index >= 0 && index < answers.count else {
            return
        }
        let answer = answers[index]
        answersChoosen.append(answer)
        nextQuestion()
    }
    
    @IBAction func multiButtonPressed() {
        for (index, multiSwitch) in multiSwitches.enumerated() {
            if multiSwitch.isOn && index < currentAnswers.count {
                let answer = currentAnswers[index]
                answersChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answersChoosen.append(answer)
        }
        nextQuestion()
    }
    
    @IBSegueAction func resultsSegue(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, answersChoosen)
    }
    
}
