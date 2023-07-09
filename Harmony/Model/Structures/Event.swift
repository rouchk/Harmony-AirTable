//
//  Event.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import Foundation

struct Address : Identifiable {

    
    var id : UUID = UUID()
    
    var idAPI = ""
    var city : String
    var address : String
    var namePlace : String
    
    init(idAPI: String = "", city: String, address: String, namePlace: String) {
        self.idAPI = idAPI
        self.city = city
        self.address = address
        self.namePlace = namePlace
    }
    
}

//struct Team : Identifiable {
//    var id : UUID = UUID()
//    var name : String
//    var members : [User]
//}

class Event : Identifiable, ObservableObject {
    var id: UUID = UUID()
    
    var isFetch = true
    @Published var idAPI: String
    @Published var title: String
    @Published var isOnline: Bool
    @Published var date: Date?
    @Published var address : Address?
    @Published var listParticipant : [User]
    @Published var detail : String
    @Published var minParticipants: Int
    @Published var photo : String
    @Published var team : [User]
    @Published var comments : [Comment]
    @Published var community : Community?
    
    init(idAPI: String) {
        self.isFetch = false
        self.idAPI = idAPI
        self.title = ""
        self.isOnline = false
        self.date = nil
        self.address = nil
        self.listParticipant = []
        self.detail = ""
        self.minParticipants = 0
        self.photo = ""
        self.team = []
        self.comments = []
        self.community = nil
    }
    
    init(idAPI: String = "", title: String, isOnline: Bool, date: Date? = nil, address: Address?, listParticipant: [User], detail: String, minParticipants: Int, photo : String, team : [User], comments : [Comment], community : Community? = nil) {
        self.idAPI = idAPI
        self.title = title
        self.isOnline = isOnline
        self.date = date
        self.address = address
        self.listParticipant = listParticipant
        self.detail = detail
        self.minParticipants = minParticipants
        self.photo = photo
        self.team = team
        self.comments = comments
        self.community = community
    }
    

    func addComment (newComment: Comment) {
        self.comments.append(newComment)
    }
}
