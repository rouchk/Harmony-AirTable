//
//  NewsViewModel.swift
//  Harmony
//
//  Created by apprenant44 on 23/06/2023.
//

import SwiftUI

struct NewsViewModel: View {
    
    @ObservedObject var news: News
    @ObservedObject var usersVM: UsersVM
    @ObservedObject var eventsVM: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    
    @State private var isLiked = false
    @State private var showingSheet = false
    
    var body: some View {
        
        VStack{
            HStack{
                NavigationLink {
                    OtherUserProfileView(user: news.author, usersVM: usersVM, eventsList: eventsVM, communitiesVM: communitiesVM)
                } label: {
                    Image(news.author.photo)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(height: 40)
                }
                
                VStack{
                    Text(news.community.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .modifier(Head2())
                    Text(news.author.pseudo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .modifier(Normal())
                }
            }
            
            Image(news.photo)
                .resizable()
            //                 .scaledToFit()
                .frame(width: 365,height: 250)
   
            
            HStack{
                
                HeartButton(isLiked: $isLiked)
                Text(isLiked ? "\(news.like + 1)" : "\(news.like)")
                    .frame(width: 20, height: 20)
                
                
                
                Button(action: {
                    showingSheet.toggle()
                }, label: {
                    Image(systemName: "message")
                    Text("9")
                })
                .sheet(isPresented: $showingSheet) {
                    CommentsView(news: news)
                    
                }
                
            } .modifier(Normal())
                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom)
            Text(news.title)
                .modifier(Head2())
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, -5)
            HStack{
                Text(news.content)
                    .multilineTextAlignment(.leading)
                    .modifier(Normal())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                                  .truncationMode(.tail)
              
                Image(systemName: "chevron.right")
                    .font(.system(size:12))
            }  .opacity(0.7)

    
            
            
        }
        .padding()
        .onAppear {
            if !news.author.isFetch {
                let id = news.author.idAPI
                print("AUTHOR" + id)
                
                print(usersVM.users.count)
                if usersVM.users.count == 0 {
                    Task {
                        await news.author = usersVM.getUserByIdInAirtable(id: id)!
                    }
                } else {
                    let user = usersVM.getUserById(id: id)
                    if user == nil {
                        Task {
                            await news.author = usersVM.getUserByIdInAirtable(id: id)!
                        }
                    }
                }
                
            }
            
            if !news.community.isFetch {
                let id = news.community.idAPI
                let comm = communitiesVM.getCommunityById(id: id)
                
                if comm == nil {
                    Task {
                        await news.community = communitiesVM.getCommunityByIdInAirtable(id: id)!
                    }
                } else {
                    news.community = comm!
                }
               
            }
        }
        //fin Vstack
        
    } // fin body
} // fin newsView model


struct HeartButton: View{
    @Binding var isLiked: Bool
    private let animationDuration: Double = 0.1
    private var animationScale: CGFloat {
        isLiked ? 0.7: 1.5
    }
    @State private var animate = false
    
    var body: some View{
        Button(action: {
            self.animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
                self.animate = false
                self.isLiked.toggle()
            })
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundColor(isLiked ? .red : .midnight)
        }).buttonStyle(BorderlessButtonStyle())
            .scaleEffect(animate ? animationScale : 1)
            .animation(.easeIn(duration: animationDuration))
        
    }
} //structure pour le bouton de like




//struct NewsViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsViewModel(news: exemplePost, )
//    }
//}


