//
//  CommentsAPI.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

struct CommentAPI: Identifiable, Codable {
  
    var id: String = ""
    
    var user: String
    var content: String?
    var date: String?
    
    internal init(id: String = "", user: String, content: String? = "", date: String? = "") {
        self.id = id
        self.user = user
        self.content = content
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case user, content, date
    }
    
    func APItoClass() -> Comment? {
        var user = User(idAPI: self.user)
        var date = APIGeneral().StringToDate(string: self.date!) ?? Date()
        
        return Comment(user: user, content: self.content!, date: date)
    }
}


struct PostCommentAPI: Identifiable, Codable {
  
    var id: String = ""
    
    var user: String
    var content: String?
    var date: String?
    var comlikes: Int?
    
    internal init(id: String = "", user: String, content: String? = "", date: String? = "", comlikes: Int? = 0) {
        self.id = id
        self.user = user
        self.content = content
        self.date = date
        self.comlikes = comlikes
    }
    
    enum CodingKeys: String, CodingKey {
        case user, content, date, comlikes
    }
    
    func APItoClass() -> PostComment? {
        var user = User(idAPI: self.user)
        var date = APIGeneral().StringToDate(string: self.date!) ?? Date()
        
        return PostComment(user: user, content: self.content!, date: date, comlikes: self.comlikes ?? 0)
    }
}

struct CommentResponse: Codable {
    let records: [RecordComment]
    
    var comments: [CommentAPI] {
        return records.map { rec in
            var comments = rec.fields
            comments.id = rec.id ?? "EF12030JF320"
            return comments
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordComment: Codable {
    var id: String?
    var deleted: Bool?
    var fields: CommentAPI
}

struct PostCommentResponse: Codable {
    let records: [RecordPostComment]
    
    var postComments: [PostCommentAPI] {
        return records.map { rec in
            var postComments = rec.fields
            postComments.id = rec.id ?? "EF12030JF320"
            return postComments
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordPostComment: Codable {
    var id: String?
    var deleted: Bool?
    var fields: PostCommentAPI
}
