//
//  QuizCompletedView.swift
//  Harmony
//
//  Created by apprenant71 on 25/06/2023.
//

import Foundation
import SwiftUI


struct QuizCompletedView: View {
    
    @ObservedObject var quizManagerVM: QuizManagerVM
    
    var body: some View {
        
        if (quizManagerVM.model.winningStatus) {
            // If the user complete all the question in time
            ScrollView {
                ZStack {
                    
                    ConfettiAnimationView()
                                        
                    VStack(spacing: 16) {
                        
                        Text("BRAVO \(myUser.pseudo)!")
                            .modifier(Head0())
                            .padding(.top, 72)
                        
                        VStack(spacing: 8) {
                            
                            Text("Vous avez obtenu")
                                .modifier(Head1())
                            
                            Text("\(quizManagerVM.myPoints) points !")
                                .modifier(Head1())
                        }
                        .padding(.vertical, 8)
                        
                        Text("Merci d'avoir particié au quiz.")
                            .modifier(Normal())
                        
                        
//                        Text("Classement")
//                            .modifier(Head1())
//                            .padding(.top, 24)
                        
                        QuizLankingView(quizManagerVM: quizManagerVM)
                        
                    }
                    .padding(.horizontal, 24)
                }
            }
            .background(Color.whiteSmoke)
            
            
            
        } else {
            // If time over
            
            VStack(spacing: 8) {
                
                Spacer()
                
                Text("GAME OVER")
                    .modifier(Head0())
                    .foregroundColor(.red)
                
                FaceAnimationView()
                
                Text("Bonne chance pour la prochaine fois.")
                    .modifier(Normal())
                    .lineLimit(3)
                    .frame(width: UIScreen.main.bounds.size.width - 24, height: 80, alignment: .center)
                    .multilineTextAlignment(.center)
                
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
}
