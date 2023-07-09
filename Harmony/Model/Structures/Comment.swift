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
    
    var isFetch = true
    @Published var idAPI: String
    @Published var user: User?
    @Published var content: String
    @Published var date: Date?
    
    init(idAPI: String) {
        self.isFetch = false
        self.idAPI = idAPI
        self.user = nil
        self.content = ""
        self.date = nil
    }
    
    init(idAPI: String = "", user: User? = nil, content: String, date: Date? = nil) {
        self.idAPI = idAPI
        self.user = user
        self.content = content
        self.date = date
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: self.date!)
    }
}


class PostComment : Identifiable, ObservableObject {
    var id = UUID()
    
    var isFetch = true
    @Published var idAPI: String
    @Published var user: User?
    @Published var content: String
    @Published var date: Date?
    @Published var comlikes: Int
    
    init(idAPI: String) {
        self.idAPI = idAPI
        self.user = nil
        self.content = ""
        self.date = nil
        self.comlikes = 0
    }
    
    init(idAPI: String = "", user: User?, content: String, date: Date? = nil, comlikes: Int) {
        self.idAPI = idAPI
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
        
        return dateFormatter.string(from: self.date!)
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
