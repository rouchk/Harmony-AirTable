//
//  QuizzView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct QuizView: View {
    
    @ObservedObject var quizManagerVM: QuizManagerVM = QuizManagerVM()
    
    var body: some View {
        
        
//        ZStack {
            
//            Image("bg")
//                .resizable()
//                .aspectRatio(contentMode: ContentMode.fill)
//                .ignoresSafeArea()
//
//            LinearGradient(colors: [.white.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
            
            
            if (quizManagerVM.model.isCompleted) {
                 QuizCompletedView(quizManagerVM: quizManagerVM)
            } else {
                VStack {
                    
                    Section {
                        TitleView()
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 16, trailing: 0))
                        
                        Text("Mes points : \(quizManagerVM.myPoints)")
                            .modifier(Head3())
                            .fontWeight(.bold)
                        
                        //                    Text("\(quizManagerVM.progress)")
                        
                        ZStack {
                            Circle() // Base circle in gray color
                                .stroke(lineWidth: 15)
                                .foregroundColor(.gray)
                                .opacity(0.4)
                            
                            Circle() // Circle animated
                                .trim(from: 0.0, to:
                                        min(CGFloat(quizManagerVM.progress), 1.0))
                                .stroke(LinearGradient(colors: [.red, .darkPeriwinkle], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round))
                                .rotationEffect(Angle(degrees: 270))
                            
                                .animation(Animation.linear(duration: Double(quizManagerVM.maxProgress)), value: quizManagerVM.progress)
                            
                            
                            
                            Text("\(quizManagerVM.timeRemaining)")
                                .font(.system(size: 40, weight: .bold))
                            
                        }
                        .frame(width: 96, height: 96)
                        .padding(.vertical, 16)
                        
                        
                        QuestionView(question: quizManagerVM.model.quizModel.question, questionNumber: quizManagerVM.model.currentQuestionIndex)
                            .padding(16)
                        
                        
                        QuizOptionsGridView(quizManagerVM: quizManagerVM)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 24)
                }
                .background(Color.whiteSmoke)
                
                .navigationBarTitle("Quiz", displayMode: .inline)
                .onAppear {
                    quizManagerVM.start()
                }
            }
    }
    
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quizManagerVM: QuizManagerVM())
    }
}


// ---------------- Extracted Views --------------------

struct TitleView: View {
    var body: some View {
        
        ZStack(alignment: .top){
            
//            QuizBanner()
//                .fill(Color.darkPeriwinkle)
//                .frame(height: 80)
            
            Text("Culture générale sur le Japon")
                .font(.custom("Urbanist", size: 18))
                .foregroundColor(Color.sapphire)
                .fontWeight(.bold)
                .padding(.top, 16)
        }
        .frame(height: 80)
    }
}


struct QuestionView: View {
    
    var question : String
    var questionNumber : Int
    
    var body: some View {
        
        VStack(spacing: 4) {
            Text("Question \(questionNumber + 1) / 10")
                .foregroundColor(Color.darkPeriwinkle)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(question)
                .foregroundColor(Color.midnight)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.custom("Urbanist", size: 18))
        .fontWeight(.bold)
        .frame(width: 342, height: 80)
//        .multilineTextAlignment(.leading)
//        .frame(width: UIScreen.main.bounds.size.width - 16)
//        .border(.red)
//
        
    }
}


