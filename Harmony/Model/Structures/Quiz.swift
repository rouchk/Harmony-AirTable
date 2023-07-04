//
//  Quiz.swift
//  Harmony
//
//  Created by apprenant49 on 22/06/2023.
//

import Foundation
import SwiftUI

struct Quiz {
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var isCompleted: Bool = false
    var winningStatus: Bool = false
}

struct QuizModel {
    var question: String
    var answer: String
    var options: [QuizOption]
}

struct QuizOption : Identifiable {
    var id: Int
    var optionId: String
    var option: String
    var color: Color
    var isSelected: Bool = false
    var isCorrect: Bool = false
}

class QuizResult: Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var user : User
    @Published var points : Int
    
    init(user: User, points: Int) {
        self.user = user
        self.points = points
    }
}

