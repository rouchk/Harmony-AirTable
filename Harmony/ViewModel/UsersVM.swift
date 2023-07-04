//
//  UserVM.swift
//  Harmony
//
//  Created by apprenant49 on 26/06/2023.
//

import Foundation

class UsersVM : ObservableObject {
    @Published var users : [User] = []
    
    init() {
        self.users = []
    }
    
    init(users : [User]) {
        self.users = users
    }
    
    func createUser (user: User) {
        self.users.append(user)
    }
    
    func removeUser (user: User) {
        self.users = self.users.filter { $0 !== user }
    }
    
//    func fetchUsers() async {
//        let apikey = "key7FutjOPCf6ezGz"
//        if let url = URL(string: "https://api.airtable.com/v0/appQOh9n8IsrhPdsC/tblf1zycTZfeMXAjY/") {
//            do {
//                var request = URLRequest(url: url)
//                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
//
//                let (data, _) = try await URLSession.shared.data(for: request)
//                if let decodedResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
//                    print("TESSST")
//                    users = decodedResponse.users
//                } else {
//                    print("PAS BONNN")
//                }
//            } catch {
//                print("Invalid data")
//            }
//        }
//    }
//
//    func addUser(user: User) async {
//        let record = RecordUser(fields: user)
//
//        let apikey = "key7FutjOPCf6ezGz"
//        if let url = URL(string: "https://api.airtable.com/v0/appQOh9n8IsrhPdsC/tblf1zycTZfeMXAjY/") {
//            do {
//                var request = URLRequest(url: url)
//                request.httpMethod = "POST"
//                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//                let jsonPig = try JSONEncoder().encode(record)
//
//                request.httpBody = jsonPig
//
//                let (_, response) = try await URLSession.shared.data(for: request)
//
//                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                    print("All is ok")
//                    await fetchUsers()
//                }
//
//            } catch {
//                print("Invalid data")
//            }
//        }
//    }
//
//    func delUser (id: String) async  {
//        var deleted: Bool = false
//
//        let apikey = "key7FutjOPCf6ezGz"
//        if let url = URL(string: "https://api.airtable.com/v0/appQOh9n8IsrhPdsC/tblf1zycTZfeMXAjY/" + id) {
//            do {
//                var request = URLRequest(url: url)
//                request.httpMethod = "DELETE"
//                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
//
//                let (data, _) = try await URLSession.shared.data(for: request)
//
//                if let decodedResponse = try? JSONDecoder().decode(RecordUser.self, from: data) {
//                    print("TESSST")
//                    deleted = decodedResponse.deleted!
//
//                    if (deleted) {
//                        print("DEL")
//                    }
//                } else {
//                    print("PAS BONNN")
//                }
//            } catch {
//                print("Invalid data")
//            }
//        }
//    }
//
//    func updateUser (user: User) async {
//        let record = RecordUser(fields: user)
//
//        let apikey = "key7FutjOPCf6ezGz"
//
//        if let url = URL(string: "https://api.airtable.com/v0/appQOh9n8IsrhPdsC/tblf1zycTZfeMXAjY/" + user.id) {
//            do {
//                var request = URLRequest(url: url)
//                request.httpMethod = "PATCH"
//                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//                let jsonPig = try JSONEncoder().encode(record)
//
//                request.httpBody = jsonPig
//
//                let (_, response) = try await URLSession.shared.data(for: request)
//
//                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                    print("All is ok")
//                    await fetchUsers()
//                }
//
//            } catch {
//                print("Invalid data")
//            }
//        }
//    }
}

var userSonia: User = User(pseudo: "Sonia", photo: "sonia", coverPhoto: "sonia", city: "Marseille", language: [Language.french, Language.english], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [])

var userTom: User = User(pseudo: "Tom", photo: "tomy", coverPhoto: "temple", city: "Marseille", language: [Language.french, Language.english], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [])

var userMax: User = User(pseudo: "Max", photo: "Max", coverPhoto: "", city: "Lille", language: [Language.french, Language.portuguese], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [])

var userThomas: User = User(pseudo: "Thomas", photo: "thomas", coverPhoto: "hawai2", city: "Paris", language: [Language.french, Language.japanese], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [userMax])

var userYuko: User = User(pseudo: "Yuko", photo: "Yuko", coverPhoto: "", city: "Lyon", language: [Language.french, Language.japanese], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [])

var userKelian: User = User(pseudo: "Kelian", photo: "Kelian", coverPhoto: "", city: "Toulouse", language: [Language.french, Language.japanese], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [])

var userAdeline: User = User(pseudo: "Adeline", photo: "Adeline", coverPhoto: "", city: "Lyon", language: [Language.french, Language.japanese], media: ["japon"], about: "Hello.", isConnected: true, myContacts: [])

var userMarie = User(
    pseudo: "Marie", photo: "Marie", coverPhoto: "hawai2",
    city: "Strasbourg",
    language: [Language.english, Language.japanese],
    media: ["Media1", "Media2"],
    about: "Konnichiwa ! Aloha ! Je suis Marie, une amoureuse de la culture japonaise et des îles d'Hawaï. Mon cœur oscille entre les traditions ancestrales et les plages de sable fin, et j'ai hâte de partager ma passion avec vous tous. Rejoignez-moi dans cette exploration captivante ! ",
    isConnected: true,
    events: [],
    conversations: [conversation1, conversation2, conversation3], myContacts: [userSonia, userThomas, userTom])

var userJohan = User(pseudo: "Johan", photo: "Johan", coverPhoto: "CoverPhoto2", city: "Paris", language: [Language.english, Language.japanese, Language.french], media: ["Media1", "Media2"], about: "Lorem ipsum dolor sit amet. Et optio quasi non explicabo itaque ea vero neque ea reprehenderit dolorem qui modi voluptatem. Aut aspernatur quibusdam in quam optio cum dignissimos dolor qui provident unde. Quo nihil quia aut optio officiis in praesentium voluptatum. Et expedita rerum ea ducimus necessitatibus qui iste quis non dolores consequatur aut voluptatem velit?", isConnected: false, myContacts: [])

var userAlexandre = User(pseudo: "Alexandre", photo: "Jeremy", coverPhoto: "Normandie", city: "Londres", language: [Language.english, Language.french], media: ["Media1", "Media2"], about: "Lorem ipsum dolor sit amet. Et optio quasi non explicabo itaque ea vero neque ea reprehenderit dolorem qui modi voluptatem. Aut aspernatur quibusdam in quam optio cum dignissimos dolor qui provident unde. Quo nihil quia aut optio officiis in praesentium voluptatum. Et expedita rerum ea ducimus necessitatibus qui iste quis non dolores consequatur aut voluptatem velit?", isConnected: true, myContacts: [])

var userElodie = User(pseudo: "Elodie", photo: "Elodie", coverPhoto: "CoverPhoto4", city: "Metz", language: [Language.english, Language.french, Language.portuguese], media: ["Media1", "Media2"], about: "Lorem ipsum dolor sit amet. Et optio quasi non explicabo itaque ea vero neque ea reprehenderit dolorem qui modi voluptatem. Aut aspernatur quibusdam in quam optio cum dignissimos dolor qui provident unde. Quo nihil quia aut optio officiis in praesentium voluptatum. Et expedita rerum ea ducimus necessitatibus qui iste quis non dolores consequatur aut voluptatem velit?", isConnected: false, myContacts: [])

var userHildegarde = User(pseudo: "Hildegarde", photo: "Hildegarde", coverPhoto: "CoverPhoto5", city: "Berlin", language: [Language.english, Language.deutsch, Language.portuguese], media: ["Media1", "Media2"], about: "Lorem ipsum dolor sit amet. Et optio quasi non explicabo itaque ea vero neque ea reprehenderit dolorem qui modi voluptatem. Aut aspernatur quibusdam in quam optio cum dignissimos dolor qui provident unde. Quo nihil quia aut optio officiis in praesentium voluptatum. Et expedita rerum ea ducimus necessitatibus qui iste quis non dolores consequatur aut voluptatem velit?", isConnected: false, myContacts: [])

var userJeanChristophe: User = User(pseudo: "Jean-Christophe", photo: "Hawai1", coverPhoto: "", city: "Lyon", language: [Language.french, Language.english], media: ["japon"], about: "Hello.", isConnected: false, myContacts: [])

var myUser = userMarie

var arrayUsers = [userMarie, userJohan, userAlexandre, userElodie, userHildegarde, userSonia, userTom, userThomas, userYuko, userKelian, userAdeline]

var users = UsersVM(users: arrayUsers)

var conversation1 = Conversation(messages: [
    Message(content: MessageContent(typeMessage: .text, contentText: "Salut, tu vas bien ?"), isRecipient: false, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Oui très bien et toi ?"), isRecipient: true, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Aujourd'hui, il y a eu bcp de changements dans ma vie"), isRecipient: false, date: Date())
], user: userJohan, isRead: true)

var conversation2 = Conversation(messages: [
    Message(content: MessageContent(typeMessage: .text, contentText: "Salut, tu vas bien ?"), isRecipient: true, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Oui très bien et toi ?"), isRecipient: false, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Quo nihil quia aut optio officiis in praesentium voluptatum. Et expedita rerum ea ducimus necessitatibus qui iste quis non dolores consequatur aut voluptatem velit?"), isRecipient: true, date: Date())
], user: userElodie, isRead: false)

var conversation3 = Conversation(messages: [
    Message(content: MessageContent(typeMessage: .text, contentText: "Salut, tu vas bien ?"), isRecipient: false, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Oui très bien et toi ?"), isRecipient: true, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Aujourd'hui, il y a eu bcp de changements dans ma vie"), isRecipient: false, date: Date()),
    Message(content: MessageContent(typeMessage: .text, contentText: "Haaa qu'est-ce qu'il se passe ????"), isRecipient: true, date: Date()),
    Message(content: MessageContent(typeMessage: .contact, contentUser: userMax), isRecipient: true, date: Date())
], user: userAlexandre, isRead: false)
