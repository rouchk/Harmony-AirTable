//
//  QuizLankingView.swift
//  Harmony
//
//  Created by apprenant71 on 28/06/2023.
//

import Foundation
import SwiftUI

struct QuizLankingView: View {
    
    var columns: [GridItem] = [
        GridItem(.fixed(64)),
        GridItem(.fixed(48)),
        GridItem(.fixed(116)),
        GridItem(.flexible())
    ]
    
    @ObservedObject var quizResultsArray = quizResults()
    @ObservedObject var quizManagerVM : QuizManagerVM
    
    var sortedResults: [QuizResult] = []
    init(quizManagerVM : QuizManagerVM) {
        self.quizManagerVM = quizManagerVM
        self.quizResultsArray.quizResults.append(QuizResult(user: myUser, points: quizManagerVM.myPoints))
        self.sortedResults = self.quizResultsArray.quizResults.sorted {
            $0.points > $1.points
        }
    }
    
    var body: some View {
        
        VStack(spacing: 24) {

            PodiumQuizView(sortedResults: sortedResults)
            
            VStack {
                ForEach(3..<sortedResults.count) { index in
                    
                    LazyVGrid(columns: columns, alignment: .leading) {
                        Text("   No. \(index + 1)")
                        Image(sortedResults[index].user.photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height:40)
                            .clipShape(Circle())
                        Text(sortedResults[index].user.pseudo)
                            .padding(.vertical, 12)
                        Text("\(sortedResults[index].points) points")
                            .padding(.trailing, 8)
                    }
                    
                }
                .padding(.vertical, 8)
                .background(Color.graySky.opacity(0.05))
            }
            .background(.white)
            .cornerRadius(8)
        }
        .navigationBarHidden(true)
    }
}










struct PodiumQuizView: View {
    
    var sortedResults: [QuizResult]
    
    var user1 = userTom
//    var user2 = userSonia
    var user3 = myUser
    
    var body: some View {
        HStack (spacing: 12){
            
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.graySky, Color.whiteSmoke]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .cornerRadius(8)
                    .position(x: 0, y: 80)
                
                VStack {
                    Image(sortedResults[1].user.photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 74, height: 74)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 4))
                    
                    ZStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(Color.saharaSand.opacity(0.8))
                            .font(.title)
                        Text("2")
                            .modifier(Head1())
                    }
                    Text(sortedResults[1].user.pseudo)
                        .modifier(Head1())
                    Text("\(sortedResults[1].points) points")
                        .modifier(Normal())
                }
                .position(x: 0, y:38)
                
            }
            .frame(width: 96, height: 176)
            
            
            
            
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.graySky, Color.whiteSmoke]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .cornerRadius(8)
                    .position(x: 0, y:84)
                
                VStack {
                    Image(sortedResults[0].user.photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 76, height: 76)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 4))
                    
                    ZStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(Color.saharaSand.opacity(0.8))
                            .font(.title)
                        Text("1")
                            .modifier(Head1())
                    }
                    .padding(.top, 4)
                    
                    Text(sortedResults[0].user.pseudo)
                        .modifier(Head1())
                    Text("\(sortedResults[0].points) points")
                        .modifier(Normal())
                }
                .position(x: 0, y: 26)
            }
            .frame(width: 96, height: 200)
            
            
            
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.graySky, Color.whiteSmoke]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .cornerRadius(8)
                    .position(x: 0, y: 78)
                
                VStack {
                    Image(sortedResults[2].user.photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 74, height: 74)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 4))
                    
                    ZStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(Color.saharaSand.opacity(0.8))
                            .font(.title)
                        Text("3")
                            .modifier(Head1())
                    }
                    Text(sortedResults[2].user.pseudo)
                        .modifier(Head1())
                    Text("\(sortedResults[2].points) points")
                        .modifier(Normal())
                }
                .position(x: 0, y:46)
            }
            .frame(width: 96, height: 160)
            
            
        }
        .frame(width: 342)
        .position(x: 218, y:160)
    }
}

