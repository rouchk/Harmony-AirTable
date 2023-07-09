//
//  NewsAPI.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

struct NewsAPI : Identifiable, Codable {
    
    var id: String = ""
    
    var title : String
    var photo : String?
    var author : [String]?
    var content : String?
    var publishDate : String?
    var like : Int?
    var comments : [String]?
    var community : [String]?
    var commentLikes: String?
    
    init(id: String = "", title: String, photo: String? = "", author: [String]? = [], content: String? = "", publishDate: String? = "", like: Int? = 0, comments: [String]? = [], community: [String]? = [], commentLikes: String? = "") {
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
    
    enum CodingKeys: String, CodingKey {
        case title, photo, author, content, publishDate, like, comments, community, commentLikes
    }
    
    mutating func addComment (newCommentId: String) {
        if self.comments != nil {
            self.comments!.append(newCommentId)
        }
    }
    
    func APItoClass() async -> News {
        var commentLikesArrayString : [String]
        var arrayInt : [Int] = []
        var community : Community? = nil
        var author : User? = nil
        var publishDate = APIGeneral().StringToDate(string: self.publishDate!)
        
        if self.commentLikes != nil {
            commentLikesArrayString = self.commentLikes!.components(separatedBy: ",")
            
            for comm in commentLikesArrayString {
                arrayInt.append(Int(comm)!)
            }
        }
        
        if self.community != nil {
            community = Community(idAPI: self.community![0])
        }
        
        if self.author != nil {
            author = User(idAPI: self.author![0])
        }
        
        return News(idAPI: id, title: self.title, photo: self.photo ?? "", author: author!, content: self.content ?? "", publishDate: publishDate ?? Date(), like: self.like ?? 0, comments: [], community: community!, commentLikes: arrayInt)
    }
    
}

struct NewsResponse: Codable {
    let records: [RecordNews]
    
    var news: [NewsAPI] {
        return records.map { rec in
            var news = rec.fields
            news.id = rec.id ?? "EF12030JF320"
            return news
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordNews: Codable {
    var id: String?
    var deleted: Bool?
    var fields: NewsAPI
}
