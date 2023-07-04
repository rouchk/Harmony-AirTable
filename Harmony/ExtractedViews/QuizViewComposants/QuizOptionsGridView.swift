//
//  QuizOptionsGridView.swift
//  Harmony
//
//  Created by apprenant71 on 25/06/2023.
//

import Foundation
import SwiftUI

struct QuizOptionsGridView: View {
    
   @ObservedObject var quizManagerVM: QuizManagerVM
    
//    var columns: [GridItem] = Array(repeating: GridItem(.fixed(170), spacing: 2), count: 2)
    var gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        LazyVGrid(columns: gridLayout, spacing: 12) {
            ForEach(quizManagerVM.model.quizModel.options) { quizOption in
                OptionCardView(quizOption: quizOption)
                    .onTapGesture {
                        quizManagerVM.verifyMyAnswer(selectedOption: quizOption)
                    }
            }
        }
    }
       
   
    
    struct OptionCardView : View {
        var quizOption: QuizOption
        var body: some View {
            VStack {
                if (quizOption.isCorrect) && (quizOption.isSelected) {
                    // If the right answer is selected
                    OptionStatusImageView(imageName: "checkmark")
                } else if (!(quizOption.isCorrect) && (quizOption.isSelected)) {
                    // If a wrong answer is selected
                    OptionStatusImageView(imageName: "xmark")
                } else {
                    OptionView(quizOption: quizOption)
                }
            }
            .frame(width: 160, height: 120)
            .foregroundColor(setTextColor())
//            .border(quizOption.color, width: 4)
//            .cornerRadius(16)
            
        }
        
        func setTextColor() -> Color {
            if (quizOption.isCorrect) && (quizOption.isSelected) {
                        return Color.green
                    } else if (!(quizOption.isCorrect) && (quizOption.isSelected)) {
                        return Color.red
                    } else {
                        return Color.midnight
                    }
        }
    }
    
    
    struct OptionView: View {
        var quizOption: QuizOption
        var body: some View {
            VStack {
                Text(quizOption.optionId + ".")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(quizOption.color)
                
                Text(quizOption.option)
                    .frame(width: 150, height: 38)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.midnight)
            }
            .frame(width: 160, height: 120)
//            .background(.white)
//            .background(Color.graySky.opacity(0.2))
            .background(quizOption.color.opacity(0.2))
            
            .cornerRadius(16)
            
            
//            .background(quizOption.color.opacity(0.5))
//            .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(quizOption.color.opacity(0.8), lineWidth: 4))


        }
    }
    
    struct OptionStatusImageView: View {
        var imageName: String
        var body: some View {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(40)
                    
            }
        }
    }
}
