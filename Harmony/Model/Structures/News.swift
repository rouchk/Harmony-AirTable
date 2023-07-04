//
//  News.swift
//  Harmony
//
//  Created by apprenant49 on 22/06/2023.
//

import Foundation

enum CategoryNews {
    case news, post
}

class News : Identifiable, ObservableObject {
    
    var id = UUID()
    
    @Published var title : String
    @Published var photo : String
    @Published var author : User
    @Published var content : String
    @Published var publishDate : Date
    @Published var like : Int
    @Published var comments : [PostComment]
    @Published var community : Community //peut pas lier encore
    @Published var commentLikes: [Int]
    
    init(id: UUID = UUID(), title: String, photo: String, author: User, content: String, publishDate: Date, like: Int, comments: [PostComment], community: Community, commentLikes: [Int]) {
        self.id = id
        self.title = title
        self.photo = photo
        self.author = author
        self.content = content
        self.publishDate = publishDate
        self.like = like
        self.comments = comments
        self.community = community
        self.commentLikes = commentLikes
    }
    
    func addComment (newComment: PostComment) {
        self.comments.append(newComment)
    }
//    var categoryNews : CategoryNews : a revoir avec le bouton actualité
}

