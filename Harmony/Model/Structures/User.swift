//
//  User.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import Foundation

enum Language: String, CaseIterable {
    case japanese = "Japonais"
    case french = "Français"
    case portuguese = "Portugais"
    case english = "Anglais"
    case deutsch = "Allemand"
}

enum TypeMessage {
    case text, contact, event
}

class MessageContent : ObservableObject {
    @Published var typeMessage: TypeMessage
    @Published var contentText: String?
    @Published var contentEvent: Event?
    @Published var contentUser: User?
    @Published var contentCommunity: Community?
    
    init(typeMessage: TypeMessage, contentText: String? = nil, contentEvent: Event? = nil, contentUser: User? = nil, contentCommunity: Community? = nil) {
        self.typeMessage = typeMessage
        self.contentText = contentText
        self.contentEvent = contentEvent
        self.contentUser = contentUser
        self.contentCommunity = contentCommunity
    }
}

class Message : Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var content : MessageContent
    @Published var isRecipient : Bool
    @Published var date : Date
    @Published var isRead : Bool
    @Published var isReaction : Bool
    @Published var reaction : String
    
    init(content: MessageContent, isRecipient: Bool, date: Date, isReaction: Bool = false, reaction: String = "") {
        self.content = content
        self.isRecipient = isRecipient
        self.date = date
        self.isRead = isRecipient ? true : false
        self.isReaction = isReaction
        self.reaction = reaction
    }
    
    func dateToString() -> String {
        var dateString = ""
        
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: Date()
        )
        let components2 = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: self.date
        )
        
        if components.year == components2.year {
            if components.month == components2.month {
                if components.day == components2.day {
                    if components.hour == components2.hour {
                        if components.minute == components2.minute {
                            dateString = "Maintenant"
                        } else {
                            dateString = String(components.minute!-components2.minute!) + " min"
                        }
                    } else {
                        dateString = String(components2.hour!) + "h" + String(components2.minute!)
                    }
                } else {
                    dateString = String(components2.hour!) + "h" + String(components2.minute!)
                    if (components2.day!-components.day!) == 1 {
                        dateString = "Hier à " + dateString
                    } else {
                        dateString = "Le " + String(components2.day!) + "/" + String(components2.month!)
                    }
                }
            } else {
                dateString = "Le " + String(components2.day!) + "/" + String(components2.month!)
            }
        } else {
            dateString = "Le " + String(components2.day!) + "/" + String(components2.month!) + "/" + String(components2.year!) 
        }
        
        return dateString
    }
    
    func startMessage(message: String) -> String {

        if (message.count > 40) {
            let range = message.startIndex..<message.index(message.startIndex, offsetBy: 40)
            return String(message[range]) + String("...")
        }
        
        return message
    }
}

class Conversation : Identifiable, ObservableObject {
    var id = UUID()
    
    @Published var messages : [Message]
    var user : User
    @Published var isRead : Bool
    var listEmojisAvailable = ["😀", "😂", "😍", "😔", "😡", "😳", "👍", "👎"]
    
    init(messages: [Message] = [], user: User, isRead : Bool) {
        self.messages = messages
        self.user = user
        self.isRead = isRead
    }
    
    func searchByMessage(pattern: String) -> Message? {
        for message in messages {
            if message.content.typeMessage == TypeMessage.text {
                if message.content.contentText != nil {
                    if message.content.contentText!.contains(pattern) {
                        return message
                    }
                }
            }
        }
        
        return nil
    }
    
    func addMessage (new: Message) {
        self.messages.append(new)
    }
    
    func lastMessage () -> Message? {
        return self.messages.last
    }
    
    func readAllMessages() {
        for message in self.messages {
            if !message.isRead {
                message.isRead = true
            }
        }
        self.isRead = true
    }
    
    func numberOfMessagesUnread() -> Int {
        var i = 0
        
        for message in messages {
            if !message.isRead {
                i += 1
            }
        }
        
        return i
    }
    
    func MessageWaitingForAResponse() -> Message? {
        for message in messages {
            if message.isReaction {
                return message
            }
        }
        
        return nil
    }
}

//class Conversations : ObservableObject {
//
//    @Published var conversations : [Conversation]
//
//    init() {
//        self.conversations = []
//    }
//
//    init(conversations : [Conversation]) {
//        self.conversations = conversations
//    }
//
//    func searchConversationByMessage(pattern: String) -> Conversation? {
//        for convers in self.conversations {
//            if convers.searchByMessage(pattern: pattern) != nil {
//                return convers
//            }
//        }
//        return nil
//    }
//}

class User : Identifiable, Equatable, ObservableObject {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    
    @Published var pseudo: String
    @Published var photo: String
    @Published var coverPhoto: String
    @Published var city: String
    @Published var language: [Language]
    @Published var media: [String]
    @Published var about: String
    @Published var isConnected : Bool
    @Published var events : [Event]
    @Published var conversations : [Conversation]
    @Published var myContacts : [User]
    
    init(pseudo: String, photo: String, coverPhoto: String, city: String, language: [Language], media: [String], about: String, isConnected: Bool, events : [Event] = [], conversations : [Conversation] = [], myContacts : [User]) {
        self.pseudo = pseudo
        self.photo = photo
        self.coverPhoto = coverPhoto
        self.city = city
        self.language = language
        self.media = media
        self.about = about
        self.isConnected = isConnected
        self.events = events
        self.conversations = conversations
        self.myContacts = myContacts
    }
    
    func newConversation(user: User, isRead: Bool) {
        self.conversations.append(Conversation(user: user, isRead: isRead))
    }
    
    func addConversation(conv: Conversation) -> Conversation {
        self.conversations.append(conv)
        return conv
    }
    func delConversationByIndex(index: IndexSet) {
        self.conversations.remove(atOffsets: index)
    }
    func delConversationLast() {
        self.conversations.removeLast()
    }
    
    func lastConversation() -> Conversation? {
        return self.conversations.last
    }
    
    func searchConversationByUser(user: User) -> Conversation? {
        for conversation in self.conversations {
            if (conversation.user === user) {
                return conversation
            }
        }
        
        return nil
    }
    
    func isMyContacts(user: User) -> Bool {
        for contact in self.myContacts {
            if (contact === user) {
                return true
            }
        }
        return false
    }
    
    func addMyContacts(user: User) {
        self.myContacts.append(user)
    }
}


