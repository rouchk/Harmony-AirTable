//
//  WaitingToStartQuiz.swift
//  Harmony
//
//  Created by apprenant71 on 27/06/2023.
//

import Foundation
import SwiftUI

struct WaitingToStartQuizView: View {
    
    @State private var count = 5
    @State private var isCountDown = true
    
    @State var isShow = false
    @State var goToQuiz = false
    
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Image(systemName: "timer")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(Color.darkPeriwinkle)
                .padding(24)
            
            Text("Le quiz commence")
            
            
            Text("dans \(self.count) secondes")
            
            
            
            NavigationLink(destination:
                            QuizView(), isActive: $goToQuiz){ EmptyView()}
        }
        .modifier(Head2())
        .padding(50)
        
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in self.count -= 1
                if self.count == 0 {
                    timer.invalidate()
                    self.isCountDown = false
                }
            }
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                goToQuiz = true
            }
        }
        
        
        
    } // end body
    
}
