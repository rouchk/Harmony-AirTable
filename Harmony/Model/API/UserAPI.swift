//
//  User.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

struct UserAPI : Identifiable, Equatable, Codable {
   
    var id: String = ""
    var pseudo : String
    var photo : String?
    var coverPhoto : String?
    var city: String?
    var language : [String]?
    var media : String?
    var about : String?
    var isConnected : Bool?
    var myContacts : [String]?
    var events : [String]?
    var comments : [String]?
    var news : [String]?
    var postComments : [String]?
    var conversations : [String]?
    var communities : [String]?

    internal init(id: String = "", pseudo: String, photo: String? = "", coverPhoto: String? = "", city: String? = "", language: [String]? = [], media: String? = "", about: String? = "", isConnected: Bool? = false, myContacts: [String]? = [], events: [String]? = [], comments: [String]? = [], news: [String]? = [], postComments: [String]? = [], conversations: [String]? = [], communities: [String]? = []) {
        self.id = id
        self.pseudo = pseudo
        self.photo = photo
        self.coverPhoto = coverPhoto
        self.city = city
        self.language = language
        self.media = media
        self.about = about
        self.isConnected = isConnected
        self.myContacts = myContacts
        self.events = events
        self.comments = comments
        self.news = news
        self.postComments = postComments
        self.conversations = conversations
        self.communities = communities
    }

    enum CodingKeys: String, CodingKey {
        case pseudo
        case photo
        case coverPhoto
        case city
        case language
        case media
        case about
        case isConnected
        case myContacts
        case events
        case comments
        case news
        case postComments
        case conversations
        case communities
    }

    static func == (lhs: UserAPI, rhs: UserAPI) -> Bool {
        return lhs.id == rhs.id
    }
    
    func APItoClass() async -> User {
        var language: [Language] = []
        var media: [String] = []
        var myContacts: [User] = []
        var evs : [Event] = []
        
        if self.language != nil {
            language = APIGeneral().ArrayStringToLanguages(array: self.language!)
        }
        
        if self.events != nil {
            for evAPI in self.events! {
                evs.append(Event(idAPI: evAPI))
            }
        }
//        if self.events != nil {
//            for evAPI in self.events! {
//                var evsap = eventsVM.getEventById(id: evAPI)
//
//                if evsap == nil {
//                    evsap = await eventsVM.getEventByIdInAirtable(id: evAPI)
//
//                    if evsap != nil {
//                        evs.append(eventsVM.getEventById(id: evAPI)!)
//                    }
//                }
//
//            }
//        }
        
        
        return User(idAPI: self.id, pseudo: self.pseudo, photo: self.photo!, coverPhoto: self.coverPhoto!, city: self.city!, language: language, media: media, about: self.about!, isConnected: self.isConnected ?? false, myContacts: myContacts)
    }
}

struct UserResponse: Codable {
    let records: [RecordUser]
    
    var users: [UserAPI] {
        return records.map { rec in
            var users = rec.fields
            users.id = rec.id ?? "EF12030JF320"
            return users
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordUser: Codable {
    var id: String?
    var deleted: Bool?
    var fields: UserAPI
}
