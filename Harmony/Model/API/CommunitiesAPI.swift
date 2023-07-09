//
//  CommunitiesAPI.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

struct CommunityAPI : Identifiable, Codable {
       
    var id = ""
    
    var name : String
    var photo : String?
    var photo1 : String?
    var icon : String?
    var rank : Double?
    var description : String?
    var rating : Double?
    var hosts : [String]?
    var members : [String]?
    var events : [String]?
    var continent : String?
    
    internal init(id: String = "", name: String, photo: String? = "", photo1: String? = "", icon: String? = "", rank: Double? = 0.0, description: String? = "", rating: Double? = 0.0, hosts: [String]? = [], members: [String]? = [], events: [String]? = [], continent: String? = "") {
        self.id = id
        self.name = name
        self.photo = photo
        self.photo1 = photo1
        self.icon = icon
        self.rank = rank
        self.description = description
        self.rating = rating
        self.hosts = hosts
        self.members = members
        self.events = events
        self.continent = continent
    }

    enum CodingKeys: String, CodingKey {
        case name, photo, photo1, icon, rank, description, rating, hosts, members, events, continent
    }
    
    func APItoClass() async -> Community {
        var hosts: [User] = []
        var members: [User] = []
        var events: [Event] = []
        
        if self.hosts != nil {
            for ho in self.hosts! {
                hosts.append(User(idAPI: ho))
            }
        }
        
        if self.members != nil {
            for mb in self.members! {
                members.append(User(idAPI: mb))
            }
        }
        
        if self.events != nil {
            for ev in self.events! {
                events.append(Event(idAPI: ev))
            }
        }
        
        return Community(idAPI: self.id, name: self.name, photo: self.photo ?? "", photo1: self.photo1 ?? "", icon: self.icon ?? "", rank: self.rank ?? 0.0, description: self.description ?? "", rating: self.rating ?? 0.0, hosts: hosts, members: members, events: events, continent: APIGeneral().StringToContinent(string: self.continent!) ?? Continent.afrique)
    }
}

struct CommunityResponse: Codable {
    let records: [RecordCommunity]
    
    var communities: [CommunityAPI] {
        return records.map { rec in
            var communities = rec.fields
            communities.id = rec.id ?? "EF12030JF320"
            return communities
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordCommunity: Codable {
    var id: String?
    var deleted: Bool?
    var fields: CommunityAPI
}
