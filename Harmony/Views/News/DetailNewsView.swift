//
//  DetailNewsView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct DetailNewsView: View {
    @ObservedObject var news: News
    @State private var isLiked = false
    @State var newContent: String = ""
    var myProfil: User = userSonia
    var community : Community
    @ObservedObject var eventsList: EventsViewModel
    
    var body: some View {

            ScrollView{
                VStack{
                    Image(news.photo)
                        .resizable()
                        .frame(width: 395,height: 240)
                        .padding(.bottom)
                    Text(news.title)
                        .modifier(Head0())
                    Button {
//
                    } label: {
                        Text("Actualité")
                            .foregroundColor(.white)
                            .font(.custom("Urbanist", size: 16))
                            .fontWeight(.bold)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.darkPeriwinkle)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    
                    HStack{
                      
                        HeartButton(isLiked: $isLiked)
                        Text(isLiked ? "\(news.like + 1)" : "\(news.like)")
                            .frame(width: 20)
                        Image(systemName: "message")
                        Text("32")
                    } .modifier(Normal())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    NavigationLink {
                        OtherUserProfileView(user: news.author, eventsList: EventsViewModel())
                    } label: {
                        HStack{
                            Image(news.author.photo)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(height: 40)
                            HStack{
                                Text("Par")
                                Text(news.author.pseudo)
                            } .frame(maxWidth: .infinity, alignment: .leading)
                                .modifier(Head2())
                        }
                    }
                    
                    Text("Publié le 12 juin 2023")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .modifier(Normal())
                        .padding(.leading)
                    
                    Text("\(news.content)")
                        .padding()
                    
                    NavigationLink(destination: DetailCommunityView(community: news.community, eventsList: EventsViewModel()), label: {
                        Text("Découvre la communauté")
                            .frame(width: 336, height: 57)
                            .background(Color.darkPeriwinkle)
                            .cornerRadius(8)
                        
                            .foregroundColor(.white)
                            .font(.custom("UrbanistRegular", size: 18))
                            .fontWeight(.bold)

                    })
                        
               
                    .padding(.bottom)
                    
                    
                    Section{
                        VStack(alignment: .leading, spacing: 16) {
                            HStack{
                                Text("Commentaire")
                                    .modifier(Head2())
                                Spacer()
                            }
                            ForEach(news.comments) { comment in
                                CommentPostView(comments: comment)
                            }
                        }
                        .padding(.horizontal, 24)

                        WriteCommentFieldNewsView(myProfil: myProfil, newContent: newContent, news: news)
                    }//fin section commentaire
                }//fin vstack
                .padding(.bottom)
                .navigationBarTitle(news.community.name, displayMode: .inline )
            }//fin scroll view

       
    }//fin body
    
}//fin detail view



struct DetailNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsView(news: exemplePost,community: culturejaponaise, eventsList: EventsViewModel())
    }
}
