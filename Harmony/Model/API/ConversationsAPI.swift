//
//  ConversationsAPI.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

struct MessageAPI : Identifiable, Codable {
    
    var id = ""
    
    var content : String?
    var isRecipient : Bool?
    var date : String?
    var isRead : Bool?
    var isReaction : Bool?
    var reaction : String?
    
    init(id: String = "", content: String? = "", isRecipient: Bool? = false, date: String? = "", isRead: Bool? = false, isReaction: Bool? = false, reaction: String? = "") {
        self.id = id
        self.content = content
        self.isRecipient = isRecipient
        self.date = date
        self.isRead = isRead
        self.isReaction = isReaction
        self.reaction = reaction
    }

    enum CodingKeys: String, CodingKey {
        case content, isRecipient, date, isRead, isReaction, reaction
    }
    
}

struct MessageContentAPI : Identifiable, Codable {
    
    var id = ""
    
    var typeMessage: String?
    var contentText: String?
    var contentEvent: String?
    var contentUser: String?
    var contentCommunity: String?
    
    internal init(id: String = "", typeMessage: String? = "", contentText: String? = "", contentEvent: String? = "", contentUser: String? = "", contentCommunity: String? = "") {
        self.id = id
        self.typeMessage = typeMessage
        self.contentText = contentText
        self.contentEvent = contentEvent
        self.contentUser = contentUser
        self.contentCommunity = contentCommunity
    }


    enum CodingKeys: String, CodingKey {
        case typeMessage, contentText, contentEvent, contentUser, contentCommunity
    }
}

struct ConversationAPI: Identifiable, Codable {
    
    var id = ""
    
    var messages : [String]?
    var user : String?
    var isRead : Bool?
    
    internal init(id: String = "", messages: [String]? = [], user: String? = "", isRead: Bool? = false) {
        self.id = id
        self.messages = messages
        self.user = user
        self.isRead = isRead
    }
    
    enum CodingKeys: String, CodingKey {
        case messages, user, isRead
    }
}

struct MessageResponse: Codable {
    let records: [RecordMessage]
    
    var messages: [MessageAPI] {
        return records.map { rec in
            var messages = rec.fields
            messages.id = rec.id ?? "EF12030JF320"
            return messages
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordMessage: Codable {
    var id: String?
    var deleted: Bool?
    var fields: MessageAPI
}

struct MessageContentResponse: Codable {
    let records: [RecordMessageContent]
    
    var messages: [MessageContentAPI] {
        return records.map { rec in
            var messages = rec.fields
            messages.id = rec.id ?? "EF12030JF320"
            return messages
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct RecordMessageContent: Codable {
    var id: String?
    var deleted: Bool?
    var fields: MessageContentAPI
}

struct ConversationResponse: Codable {
    let records: [RecordConversation]
    
    var conversations: [ConversationAPI] {
        return records.map { rec in
            var conversations = rec.fields
            conversations.id = rec.id ?? "EF12030JF320"
            return conversations
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}
struct RecordConversation: Codable {
    var id: String?
    var deleted: Bool?
    var fields: ConversationAPI
}
