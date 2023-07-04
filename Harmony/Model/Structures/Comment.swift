//
//  Comment.swift
//  Harmony
//
//  Created by apprenant49 on 22/06/2023.
//

import Foundation

//struct Comment : Identifiable {
//    var id : UUID = UUID()
//    var user : User
//    var content : String
//    var date : Date
//}


class Comment : Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var user: User
    @Published var content: String
    @Published var date: Date
    
    
    init(user: User, content: String, date: Date) {
        self.user = user
        self.content = content
        self.date = date
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: self.date)
    }
}


class PostComment : Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var user: User
    @Published var content: String
    @Published var date: Date
    @Published var comlikes: Int
    
    
    init(user: User, content: String, date: Date, comlikes: Int) {
        self.user = user
        self.content = content
        self.date = date
        self.comlikes = comlikes
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: self.date)
    }
}

//class Comments : Identifiable, ObservableObject {
//    var id = UUID()
//    
//    @Published var comments: [Comment]
//    
//    init(comments: [Comment]) {
//        self.comments = comments
//    }
//    
//    func addComment (newComment: Comment) {
//        self.comments.append(newComment)
//    }
//    
//}
