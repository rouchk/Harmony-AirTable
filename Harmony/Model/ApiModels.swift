//
//  ApiModel.swift
//  Harmony
//
//  Created by apprenant49 on 04/07/2023.
//

import Foundation

//struct CommunityResponse: Codable {
//    let records: [RecordCommunity]
//    
//    var communities: [Community] {
//        return records.map { rec in
//            var com = rec.fields
//            //com.id = rec.id ?? "EF12030JF320"
//            return com
//        }
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case records
//    }
//}
//
//struct UserResponse: Codable {
//    let records: [RecordUser]
//    
//    var users: [User] {
//        return records.map { rec in
//            var user = rec.fields
//            //user.id = rec.id ?? "EF12030JF320"
//            return user
//        }
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case records
//    }
//}

// MARK: - Record
//struct RecordUser: Codable {
//    var id: String?
//    var deleted: Bool?
//    var fields: User
//}
//
//struct RecordCommunity: Codable {
//    var id: String?
//    var deleted: Bool?
//    var fields: Community
//}
