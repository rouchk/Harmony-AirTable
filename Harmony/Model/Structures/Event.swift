//
//  Event.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import Foundation

struct Address : Identifiable {
    var id : UUID = UUID()
    var city : String
    var address : String
    var namePlace : String
}

//struct Team : Identifiable {
//    var id : UUID = UUID()
//    var name : String
//    var members : [User]
//}

class Event : Identifiable, ObservableObject {
    var id: UUID = UUID()
    
    @Published var title: String
    @Published var isOnline: Bool
    @Published var date: Date
    @Published var address : Address?
    @Published var listParticipant : [User]
    @Published var detail : String
    @Published var minParticipants: Int
    @Published var photo : String
    @Published var team : [User]
//    @Published var comments : Comments // [Comment]
    @Published var comments : [Comment]
    @Published var community : Community
    
    init(title: String, isOnline: Bool, date: Date, address: Address?, listParticipant: [User], detail: String, minParticipants: Int, photo : String, team : [User], comments : [Comment], community : Community) {
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
