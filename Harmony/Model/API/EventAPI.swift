//
//  EventAPI.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

struct AddressAPI : Identifiable, Codable {
 
    var id: String = ""
    var city : String?
    var address : String?
    var namePlace : String?
    
    internal init(id: String = "", city: String? = "", address: String? = "", namePlace: String? = "") {
        self.id = id
        self.city = city
        self.address = address
        self.namePlace = namePlace
    }
    
    enum CodingKeys: String, CodingKey {
        case city, address, namePlace
    }
    
    func APItoClass() -> Address {
        return Address(idAPI: self.id, city: self.city ?? "", address: self.address ?? "", namePlace: self.namePlace ?? "")
    }
    
}

struct EventAPI : Identifiable, Codable {
 
    var id: String = ""
    
    var title: String?
    var isOnline: Bool?
    var date: String?
    var address : [String]?
    var listParticipant : [String]?
    var detail : String?
    var minParticipants: Int?
    var photo : String?
    var team : String?
    var comments : [String]?
    var community : [String]?
 
    internal init(id: String = "", title: String? = "", isOnline: Bool? = false, date: String? = "", address: [String]? = [], listParticipant: [String]? = [], detail: String? = "", minParticipants: Int? = 0, photo: String? = "", team: String? = "", comments: [String]? = [], community: [String]? = []) {
        self.id = id
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
   
    enum CodingKeys: String, CodingKey {
        case title, isOnline, date, address, listParticipant, detail, minParticipants, photo, team, comments, community
    }

    mutating func addCommentAPI (newCommentId: String) {
        if (self.comments != nil) {
            self.comments!.append(newCommentId)
        }
    }
    
    func APItoClass(addressList: [Address]) async -> Event {
        var listParticipant: [User] = []
        var team: [User] = []
        var comments : [Comment] = []
        var address : Address? = nil
        var isOnline = (self.isOnline != nil) ? self.isOnline : false
        var date = APIGeneral().StringToDate(string: self.date!)
        
        if self.listParticipant != nil {
            for parti in self.listParticipant! {
                listParticipant.append(User(idAPI: parti))
            }
        }
        
        if self.comments != nil {
            for comm in self.comments! {
                comments.append(Comment(idAPI: comm))
            }
        }
        
        if self.address != nil {
            if self.address![0] != nil {
                for add in addressList {
                    if add.idAPI == self.address![0] {
                        
                            print(self.address![0])
                        address = add
                        break
                    }
                }
            }
            
        }
        
        return Event(idAPI: id, title: self.title!, isOnline: isOnline!, date: date ?? Date(), address: address, listParticipant: listParticipant, detail: self.detail!, minParticipants: self.minParticipants!, photo: self.photo!, team: [], comments: comments)
    }
    
//    func APItoClass() -> Event {
//        var event: Event
//        
//        
//        return event
//    }
}

struct EventResponse: Codable {
    let records: [RecordEvent]
    
    var events: [EventAPI] {
        return records.map { rec in
            var events = rec.fields
            events.id = rec.id ?? "EF12030JF320"
            return events
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordEvent: Codable {
    var id: String?
    var deleted: Bool?
    var fields: EventAPI
}

struct AddressResponse: Codable {
    let records: [RecordAddress]
    
    var address: [AddressAPI] {
        return records.map { rec in
            var address = rec.fields
            address.id = rec.id ?? "EF12030JF320"
            return address
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordAddress: Codable {
    var id: String?
    var deleted: Bool?
    var fields: AddressAPI
}
