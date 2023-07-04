//
//  CommentsView.swift
//  Harmony
//
//  Created by apprenant44 on 30/06/2023.
//

import SwiftUI


struct CommentsView: View {
    
    
    @State var newContent: String = ""
    var myProfil: User = userSonia
    @State private var isLiked = false
    @ObservedObject var news: News
    
    var body: some View {
        ScrollView {
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    HStack{
                        Spacer()
                        Text("Commentaires")
                            .modifier(Head2())
                        Spacer()
                    }
                    ForEach(news.comments) { comment in
                        
                        CommentPostView(comments: comment)
                        
                    } //fin foreach
                } //fin vstack
                .padding(.horizontal, 24)
                
                VStack{
                    
                    WriteCommentFieldNewsView(myProfil: myProfil, newContent: newContent, news: news)
//                        .frame(width: 390, height: 60)
                    
                }
                
                
            }//fin section commentaire
            
        }
    }
}

struct CommentPostView: View {
    @State private var isLiked = false
    var comments: PostComment
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: comments.date)
    }     // Convert the display format of comment.date
    
    
    var body: some View {
        
        
        HStack {
            Image(comments.user.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Spacer()
            
            VStack(alignment: .leading) {
                
                Divider()
//                    .padding(.bottom)
                
                Spacer()
                
                HStack {
                
                    Text(comments.user.pseudo)
                        .modifier(Head2())

                    Spacer()
                    
                    Text(formattedDateString)
                        .modifier(SmallGray())
                        .padding(.trailing, 8)
                }
                .padding(.bottom, 4)
                
                Text(comments.content)
                    .modifier(Normal())
//                    .frame(height: 40)
                    .multilineTextAlignment(.leading)
                
            } //finvstack nom + commentaire
            .padding(.leading, 8)
            .frame(height: 50)
            
            VStack{
                HeartButton(isLiked: $isLiked)
                
                Text(isLiked ? "\(comments.comlikes + 1)" : "\(comments.comlikes)")
                    .modifier(Normal())
                    .frame(width: 30)
            }
        }// fin hstack principale
        .frame(height: 90)
    } //finbody
    
    
} // fin structure




struct NewCommentFieldView: View {
    
    var myProfil : User
    @State var newContent: String = ""
    @ObservedObject var event: Event
    //    @ObservedObject var eventComments: Comments
    
    var body: some View {
        HStack {
            
            Image(myProfil.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 40)
                .clipShape(Circle())
            
//            TextField("Ecrire un commentaire", text: $newContent)
//                .textFieldStyle(PlainTextFieldStyle())
//                           .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
//                                       .cornerRadius(16)
//                                           .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.graySky))
            
            
            Button {
                event.addComment(newComment: Comment(user: myProfil, content: newContent, date: Date()))
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.sapphire)
            }
            
        }
        .padding(.horizontal, 24)

        
    }
}


struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(news: exemplePost)
    }
}
