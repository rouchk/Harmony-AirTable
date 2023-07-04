//
//  QuizManagerVM.swift
//  Harmony
//
//  Created by apprenant71 on 25/06/2023.
//

import Foundation
import SwiftUI

class QuizManagerVM : ObservableObject {
    
    static var currentIndex = 0
    
    static func createQuizModel(i: Int) -> Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quizData[i])
    }
    
    @Published var model = QuizManagerVM.createQuizModel(i: QuizManagerVM.currentIndex)
    
    var timer = Timer()
    var maxProgress = 80
    @Published var progress = 0
    @Published var timeRemaining = 80
    
    @Published var myPoints: Int = 0
    
//    init() {
//        self.start()
//    }
    
    
    func verifyMyAnswer(selectedOption: QuizOption) {
        
        for index in model.quizModel.options.indices {
            model.quizModel.options[index].isCorrect = false
            model.quizModel.options[index].isSelected = false
        }
        
        if let index = model.quizModel.options.firstIndex(where: { $0.optionId == selectedOption.optionId} ) {
            if selectedOption.optionId == model.quizModel.answer { // If the user selected the right answer
                model.quizModel.options[index].isCorrect = true
                model.quizModel.options[index].isSelected = true
                myPoints += 5 // ------ To write the code to add points
                
            } else {
                model.quizModel.options[index].isCorrect = false
                model.quizModel.options[index].isSelected = true
                // ------- To write the code to show the right answer
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if (QuizManagerVM.currentIndex < 9) {
                    QuizManagerVM.currentIndex = QuizManagerVM.currentIndex + 1 // Next question
                    self.model = QuizManagerVM.createQuizModel(i: QuizManagerVM.currentIndex)
                } else {
                    self.model.isCompleted = true
                    self.model.winningStatus = true
                    self.reset()
                }
            }
            
        }
        
    }
    
//    func restartQuiz() {
//        QuizManagerVM.currentIndex = 0
//        model = QuizManagerVM.createQuizModel(i: QuizManagerVM.currentIndex)
//    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { time in
            if self.progress == self.maxProgress {
                self.model.isCompleted = true
                self.model.winningStatus = false
                self.reset()
            } else {
                self.progress += 1
                self.timeRemaining -= 1
            }
        } )
    }
    
    func reset() {
        timer.invalidate()
        self.progress = 0
        self.timeRemaining = 80
    }
    

    
}

extension QuizManagerVM {
    static var quizData: [QuizModel] {
        [
            QuizModel(question: "Quelle ville a la même latitude que Tokyo?",
                      answer: "A",
                      options: [QuizOption(id: 11, optionId: "A", option: "Athènes", color: Color.quizYellow),
                                QuizOption(id: 12, optionId: "B", option: "Rome", color: Color.darkPeriwinkle),
                                QuizOption(id: 13, optionId: "C", option: "Marseille", color: Color.quizGreen),
                                QuizOption(id: 14, optionId: "D", option: "Paris", color: Color.quizRed)]),
            
            QuizModel(question: "Quelle religion est la plus ancienne au Japon ?",
                      answer: "D",
                      options: [QuizOption(id: 21, optionId: "A", option: "Catholicisme", color: Color.quizRed),
                                QuizOption(id: 22, optionId: "B", option: "Bouddhisme", color: Color.quizGreen),
                                QuizOption(id: 23, optionId: "C", option: "Hindouisme", color: Color.darkPeriwinkle),
                                QuizOption(id: 24, optionId: "D", option: "Shintoïsme", color: Color.quizYellow)]),
            
            QuizModel(question: "Combien d'alphabets sont-ils utilisés dans la langue japonaise ?",
                      answer: "B",
                      options: [QuizOption(id: 31, optionId: "A", option: "2", color: Color.quizGreen),
                                QuizOption(id: 32, optionId: "B", option: "3", color: Color.quizYellow),
                                QuizOption(id: 33, optionId: "C", option: "4", color: Color.quizRed),
                                QuizOption(id: 34, optionId: "D", option: "1", color: Color.darkPeriwinkle)]),
            
            QuizModel(question: "Quel est le nom du train à grande vitesse japonais ?",
                      answer: "C",
                      options: [QuizOption(id: 41, optionId: "A", option: "KTX", color: Color.darkPeriwinkle),
                                QuizOption(id: 42, optionId: "B", option: "Azusa", color: Color.quizRed),
                                QuizOption(id: 43, optionId: "C", option: "Shinkansen", color: Color.quizYellow),
                                QuizOption(id: 44, optionId: "D", option: "Shinano", color: Color.quizGreen)]),
            
            QuizModel(question: "Quel est le nombre de départements au Japon ?",
                      answer: "A",
                      options: [QuizOption(id: 51, optionId: "A", option: "47", color: Color.quizRed),
                                QuizOption(id: 52, optionId: "B", option: "94", color: Color.darkPeriwinkle),
                                QuizOption(id: 53, optionId: "C", option: "13", color: Color.quizGreen),
                                QuizOption(id: 54, optionId: "D", option: "50", color: Color.quizYellow)]),
            
            QuizModel(question: "Quelle est la plus grande île de l'archipel au Japon ?",
                      answer: "C",
                      options: [QuizOption(id: 61, optionId: "A", option: "Shikoku", color: Color.quizYellow),
                                QuizOption(id: 62, optionId: "B", option: "Hokkaidô", color: Color.quizGreen),
                                QuizOption(id: 63, optionId: "C", option: "Honshû", color: Color.darkPeriwinkle),
                                QuizOption(id: 64, optionId: "D", option: "Kyûshû", color: Color.quizRed)]),
            
            QuizModel(question: "Quelle est la fleur utilisée dans l'emblème de la famille impériale japonaise ?",
                      answer: "B",
                      options: [QuizOption(id: 71, optionId: "A", option: "Cerisier", color: Color.quizGreen),
                                QuizOption(id: 72, optionId: "B", option: "Chrysanthème", color: Color.quizYellow),
                                QuizOption(id: 73, optionId: "C", option: "Lis", color: Color.quizRed),
                                QuizOption(id: 74, optionId: "D", option: "Prunier", color: Color.darkPeriwinkle)]),
            
            QuizModel(question: "Où fut située la première capitale du Japon ?",
                      answer: "A",
                      options: [QuizOption(id: 81, optionId: "A", option: "Nara", color: Color.darkPeriwinkle),
                                QuizOption(id: 82, optionId: "B", option: "Kyoto", color: Color.quizRed),
                                QuizOption(id: 83, optionId: "C", option: "Osaka", color: Color.quizYellow),
                                QuizOption(id: 84, optionId: "D", option: "Tokyo", color: Color.quizGreen)]),
            
            QuizModel(question: "Le surnom du Japon est 'Pays...'?",
                      answer: "D",
                      options: [QuizOption(id: 91, optionId: "A", option: "de l'oncle Sam", color: Color.quizRed),
                                QuizOption(id: 92, optionId: "B", option: "du matin calme", color: Color.quizGreen),
                                QuizOption(id: 93, optionId: "C", option: "du sourire", color: Color.darkPeriwinkle),
                                QuizOption(id: 94, optionId: "D", option: "du soleil levant", color: Color.quizYellow)]),
            
            QuizModel(question: "Quelle est la capitale actuelle du Japon ?",
                      answer: "D",
                      options: [QuizOption(id: 101, optionId: "A", option: "Osaka", color: Color.quizYellow),
                                QuizOption(id: 102, optionId: "B", option: "Nagoya", color: Color.darkPeriwinkle),
                                QuizOption(id: 103, optionId: "C", option: "Kyoto", color: Color.quizGreen),
                                QuizOption(id: 104, optionId: "D", option: "Tokyo", color: Color.quizRed)])
        ]
    }
}
