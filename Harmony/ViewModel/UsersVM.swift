//
//  UserVM.swift
//  Harmony
//
//  Created by apprenant49 on 26/06/2023.
//

import Foundation

class UsersVM : ObservableObject {
    @Published var users : [User] = []
    @Published var myUser: User? = nil
    @Published var usersAPI: [UserAPI] = []
    @Published var myUserAPI: UserAPI? = nil
    
    init() {
        Task {
//            await self.fetchUsers()
//            for user in usersAPI {
//                await users.append(user.APItoClass())
//            }
            
            await self.getMyUserAirtable()
            if myUserAPI != nil {
                myUser = await myUserAPI!.APItoClass()
            } else {
                print("PROBLEME AVEC myUserAPI")
            }
        }
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
    
    
    func fetchUsers() async {
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblSFhyjk9RTMvctb/") {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
                    print("TABLE USER OK")
                    usersAPI = decodedResponse.users
                } else {
                    print("TABLE USER BAD")
                }
            } catch {
                print("Invalid data")
            }
        }
    }

    func addUserAirtable(user: UserAPI) async {
        let record = RecordUser(fields: user)

        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblSFhyjk9RTMvctb/") {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let jsonPig = try JSONEncoder().encode(record)

                request.httpBody = jsonPig

                let (_, response) = try await URLSession.shared.data(for: request)

                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print("All is ok")
                    await fetchUsers()
                }

            } catch {
                print("Invalid data")
            }
        }
    }

    func delUserAirtable (id: String) async  {
        var deleted: Bool = false

        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblSFhyjk9RTMvctb/" + id) {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)

                if let decodedResponse = try? JSONDecoder().decode(RecordUser.self, from: data) {
                    print("DEL USER ID OK")
                    deleted = decodedResponse.deleted!

                    if (deleted) {
                        print("DEL USER ID BAD")
                    }
                } else {
                    print("PAS BONNN")
                }
            } catch {
                print("Invalid data")
            }
        }
    }

    func fetchUserById (id: String) async -> UserAPI? {
        var user: UserAPI? = nil
        
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblSFhyjk9RTMvctb/" + id) {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(RecordUser.self, from: data) {
                    print("GET USER ID OK")
                    user = decodedResponse.fields
                    if (user == nil) {
                        print("GET USER ID BAD")
                    }
                } else {
                    print("PAS BONNN")
                }
            } catch {
                print("Invalid data")
            }
        }
        return user
    }
    
    func updateUserAirtable (user: UserAPI) async {
        let record = RecordUser(fields: user)

        let apikey = "key7FutjOPCf6ezGz"

        if let url = URL(string: "https://api.airtable.com/v0/appQOh9n8IsrhPdsC/tblSFhyjk9RTMvctb/" + user.id) {
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "PATCH"
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let jsonPig = try JSONEncoder().encode(record)

                request.httpBody = jsonPig

                let (_, response) = try await URLSession.shared.data(for: request)

                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print("All is ok")
                    await fetchUsers()
                }

            } catch {
                print("Invalid data")
            }
        }
    }
    
    func searchUserById (id: String) -> User? {
//        for user in users {
//            if user.id == id {
//                return user
//            }
//        }
        return nil
    }
    
    func getMyUserAirtable() async {
        self.myUserAPI = await self.fetchUserById(id: "reczBTJLlmNiTSHNC")!
    }

    func getUserById(id: String) -> User? {
        if self.users != nil {
            for user in self.users {
                if user.idAPI == id {
                    return user
                }
            }
        }
        
        return nil
    }
    
    func getUserByIdInAirtable(id: String) async -> User? {
        let userAPI = await self.fetchUserById(id: id)
        var user: User? = nil
        var isNew = true
        
        if userAPI != nil {
            usersAPI = usersAPI.map {
                var mutableUser = $0
                if ($0.id == id) {
                    isNew = false
                    mutableUser = userAPI!
                }
                return mutableUser
            }
            
            user = await userAPI!.APItoClass()
            
            if isNew {
                usersAPI.append(userAPI!)
                users.append(user!)
            } else {
                users = users.map {
                    var mutableUser = $0
                    if $0.idAPI == id {
                        mutableUser = user!
                    }
                    return mutableUser
                }
            }
    
        }
        
        return user
    }
}

var userSonia: User = User(pseudo: "Sonia", photo: "sonia", coverPhoto: "beach", city: "Marseille",
                           language: [Language.french, Language.english], media: ["japon"],
                           about: "Bonjour à tous ! Je suis Sonia, une passionnée de pâtisserie basée à Marseille. J'adore créer de délicieux gâteaux et desserts. Rejoignez-moi dans l'univers sucré de la pâtisserie où je partage mes recettes et mes créations gourmandes avec vous !",
                           isConnected: true, myContacts: [])

var userTom: User = User(pseudo: "Tom", photo: "tomy", coverPhoto: "temple", city: "Marseille",
                         language: [Language.french, Language.english], media: ["japon"], about: "Hey, moi c'est Tom, originaire de Seattle. Je suis complètement immergé dans l'univers des mangas et des jeux vidéo.",
                         isConnected: true, myContacts: [])

var userMax: User = User(pseudo: "Max", photo: "Max", coverPhoto: "portugal", city: "Lille",
                         language: [Language.french, Language.portuguese], media: ["japon"],
                         about: "Salut ! Je m'appelle Max et je suis un amateur d'aventures en plein air. Randonnée, escalade, camping, j'adore explorer la nature et me laisser emporter par sa beauté.",
                         isConnected: true, myContacts: [])

var userThomas: User = User(pseudo: "Thomas", photo: "thomas", coverPhoto: "hawai2", city: "Paris",
                            language: [Language.french, Language.japanese], media: ["japon"],
                            about: "Konnichiwa ! Je m'appelle Thomas et je suis un grand amateur du Japon, en particulier de sa cuisine exquise et de ses boissons raffinées comme le saké et le whisky. Yoroshiku !",
                            isConnected: true, myContacts: [userMax])

var userYuko: User = User(pseudo: "Yuko", photo: "Yuko", coverPhoto: "grapes", city: "Lyon",
                          language: [Language.french, Language.japanese], media: ["japon"],
                          about: "Je suis Yuko, épicurienne qui apprécie l'art de la cuisine et les plaisirs de la dégustation. Mon palais s'émerveille particulièrement des vins français, qui apportent une dimension unique à chaque repas.",
                          isConnected: true, myContacts: [])

var userKelian: User = User(pseudo: "Kelian", photo: "Kelian", coverPhoto: "car2", city: "Toulouse",
                            language: [Language.french, Language.japanese], media: ["japon"],
                            about: "Salut à tous ! Je suis Kelian, un passionné de l'automobile depuis mon plus jeune âge. Les moteurs vrombissants, les lignes élégantes et la mécanique sophistiquée me fascinent. Rejoignez-moi pour plonger dans le monde palpitant des voitures et partager ensemble cette passion qui fait battre mon cœur !",
                            isConnected: true, myContacts: [])

var userAdeline: User = User(pseudo: "Adeline", photo: "Adeline", coverPhoto: "butterflies", city: "Lyon",
                             language: [Language.french, Language.japanese], media: ["japon"],
                             about: "Bonjour ! Je m'appelle Adeline et j'ai une passion pour l'art et la beauté de la nature. Lyon, ma ville natale, est une source d'inspiration inépuisable pour moi.",
                             isConnected: true, myContacts: [])

var userMarie = User(
    pseudo: "Marie", photo: "Marie", coverPhoto: "hawai2",
    city: "Strasbourg",
    language: [Language.english, Language.japanese],
    media: ["Media1", "Media2"],
    about: "Konnichiwa ! Aloha ! Je suis Marie, une amoureuse de la culture japonaise et des îles d'Hawaï. Mon cœur oscille entre les traditions ancestrales et les plages de sable fin, et j'ai hâte de partager ma passion avec vous tous. Rejoignez-moi dans cette exploration captivante ! ",
    isConnected: true,
    events: [],
    conversations: [conversation1, conversation2, conversation3], myContacts: [userSonia, userThomas, userTom])

var userJohan = User(pseudo: "Johan", photo: "Johan", coverPhoto: "shrine", city: "Paris",
                     language: [Language.english, Language.japanese, Language.french], media: ["Media1", "Media2"],
                     about: "Bonjour à tous ! Je suis Johan, un épicurien passionné par la découverte de nouvelles saveurs à travers le monde. Entre gourmandises et aventures culinaires, je vous emmène avec moi pour un voyage gustatif sans frontières !",
                     isConnected: false, myContacts: [])

var userAlexandre = User(pseudo: "Alexandre", photo: "Jeremy", coverPhoto: "car", city: "Londres",
                         language: [Language.english, Language.french], media: ["Media1", "Media2"],
                         about: "Salut, je suis Alexandre, passionné par l'univers automobile. Mon amour pour les voitures est une source infinie d'inspiration et de créativité. Rejoignez-moi pour explorer ensemble cet univers passionnant !",
                         isConnected: true, myContacts: [])

var userElodie = User(pseudo: "Elodie", photo: "Elodie", coverPhoto: "mountains", city: "Metz",
                      language: [Language.english, Language.french, Language.portuguese], media: ["Media1", "Media2"],
                      about: "Salut à tous ! Je suis Elodie, une aventurière originaire de Metz. Je parle couramment le français et l'anglais, et j'ai soif de voyages et d'explorations. Ensemble, partons à la découverte du monde et créons des souvenirs inoubliables !",
                      isConnected: false, myContacts: [])

var userHildegarde = User(pseudo: "Hildegarde", photo: "Hildegarde", coverPhoto: "lavender", city: "Berlin",
                          language: [Language.english, Language.deutsch, Language.portuguese], media: ["Media1", "Media2"],
                          about: "Guten Tag ! Je m'appelle Hildegarde et je suis Allemande. La nature, les fleurs et la France sont mes plus grandes sources d'inspiration.",
                          isConnected: false, myContacts: [])

var userJeanChristophe: User = User(pseudo: "Jean-Christophe", photo: "jc", coverPhoto: "owl", city: "Lyon",
                                    language: [Language.french, Language.english], media: ["japon"],
                                    about: "Salut ! Je suis Jean-Christophe, passionné par les cultures traditionnelles et complètement dingue des hibous. Rejoignez-moi pour explorer le monde fascinant de la tradition et de la sagesse nocturne des chouettes !",
                                    isConnected: false, myContacts: [])

//var myUser = userMarie

var arrayUsers = [userMarie, userJohan, userAlexandre, userElodie, userHildegarde, userSonia, userTom, userThomas, userYuko, userKelian, userAdeline]

//var users = UsersVM(users: arrayUsers)
var users = UsersVM()
var myUser = userMarie

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
