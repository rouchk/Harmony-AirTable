//
//  EventsViewModel.swift
//  Harmony
//
//  Created by apprenant71 on 23/06/2023.
//

import Foundation

class EventsViewModel: ObservableObject {
    @Published var eventsList : [Event] = []
    @Published var eventsAPI: [EventAPI] = []
    @Published var addressList : [Address] = []
    @Published var addressAPI: [AddressAPI] = []
    @Published var comments : [Comment] = []
    @Published var commentsAPI : [CommentAPI] = []
    
    init() {
        Task {
            await self.fetchAddress()
            for ad in addressAPI {
                addressList.append(ad.APItoClass())
            }
            
            await self.fetchEvents()
            for ev in eventsAPI {
                print("AJOUT")
                await eventsList.append(ev.APItoClass(addressList: addressList))
            }
            print(eventsList.count)
        }
    }
    
    func refresh() {
        Task {
            addressAPI = []
            addressList = []
            
            await self.fetchAddress()
            for ad in addressAPI {
                addressList.append(ad.APItoClass())
            }
            
            await self.fetchEvents()
            for ev in eventsAPI {
                print("AJOUT")
                await eventsList.append(ev.APItoClass(addressList: addressList))
            }
            
            print(eventsList.count)
        }
    }
    
    func fetchEvents() async {
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblpEmQSR9j3p1phL/") {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(EventResponse.self, from: data) {
                    print("TABLE EVENT OK")
                    eventsAPI = decodedResponse.events
                } else {
                    print("TABLE EVENT BAD")
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
    func fetchEventById (id: String) async -> EventAPI? {
        var event: EventAPI? = nil
        
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblpEmQSR9j3p1phL/" + id) {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(RecordEvent.self, from: data) {
                    print("TESSST")
                    event = decodedResponse.fields
                    if (event == nil) {
                        print("PAS BOOOONNNNNNNNNN")
                    }
                } else {
                    print("PAS BONNN")
                }
            } catch {
                print("Invalid data")
            }
        }
        return event
    }
    
    func getEventById(id: String) -> Event? {
        for event in eventsList {
            if event.idAPI == id {
                return event
            }
        }
        return nil
    }
    
    func getEventByIdInAirtable(id: String) async -> Event? {
        let eventAPI = await self.fetchEventById(id: id)
        var event: Event? = nil
        var isNew = true
        
        if eventAPI != nil {
            eventsAPI = eventsAPI.map {
                var mutableUser = $0
                if ($0.id == id) {
                    isNew = false
                    mutableUser = eventAPI!
                }
                return mutableUser
            }
            
            //event = eventAPI!.APItoClass()
            
            if isNew {
                eventsAPI.append(eventAPI!)
                eventsList.append(event!)
            } else {
                eventsList = eventsList.map {
                    var mutableUser = $0
                    if $0.idAPI == id {
                        mutableUser = event!
                    }
                    return mutableUser
                }
            }
    
        }
        
        return event!
    }
    
    func fetchAddress() async {
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblJV08m6Tf9amcJT/") {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(AddressResponse.self, from: data) {
                    print("TABLE ADDRESS OK")
                    addressAPI = decodedResponse.address
                } else {
                    print("TABLE ADDRESS BAD")
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
    func fetchComments() async {
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblvr1kRMJjHLOLFI/") {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(CommentResponse.self, from: data) {
                    print("TABLE COMMENT OK")
                    commentsAPI = decodedResponse.comments
                } else {
                    print("TABLE COMMENT BAD")
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
    func fetchCommentById (id: String) async -> CommentAPI? {
        var comment: CommentAPI? = nil
        
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblpEmQSR9j3p1phL/" + id) {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(RecordComment.self, from: data) {
                    print("TESSST")
                    comment = decodedResponse.fields
                    if (comment == nil) {
                        print("PAS BOOOONNNNNNNNNN")
                    }
                } else {
                    print("PAS BONNN")
                }
            } catch {
                print("Invalid data")
            }
        }
        return comment
    }
    
    func getCommentById(id: String) -> Comment? {
        for com in self.comments {
            if com.idAPI == id {
                return com
            }
        }
        return nil
    }
    
    func getCommentByIdInAirtable(id: String) async -> Comment? {
        let commentAPI = await self.fetchCommentById(id: id)
        var comment: Comment? = nil
        var isNew = true
        
        if commentAPI != nil {
            self.commentsAPI = self.commentsAPI.map {
                var mutableComment = $0
                if ($0.id == id) {
                    isNew = false
                    mutableComment = commentAPI!
                }
                return mutableComment
            }
            
            if isNew {
                self.commentsAPI.append(commentAPI!)
                self.comments.append(comment!)
            } else {
                self.comments = self.comments.map {
                    var mutableComment = $0
                    if $0.idAPI == id {
                        mutableComment = comment!
                    }
                    return mutableComment
                }
            }
    
        }
        
        return comment!
    }
    
    
}

var eventExampleNonRegistered: Event = Event(
    title: "Initiation Calligraphie",
    isOnline: false,
    date: Date(timeIntervalSince1970: 1688722200),
    address: Address(city: "Lyon 2e", address: "23 rue Victor Hugo", namePlace: "Espace Culture Japon"),
    listParticipant: [userJeanChristophe, userThomas, userMax, userYuko, userAdeline, userKelian],
    detail: "Explorez la calligraphie japonaise et laissez votre créativité s'exprimer à travers des tracés précis et élégants, dans l'art ancestral de la beauté des mots.",
    minParticipants: 8,
    photo: "japon",
    team: [userTom, userYuko],
    comments: [
        Comment(user: userMax, content: "J'ai hâte !", date: Date(timeIntervalSince1970: 1687522965)),
        Comment(user: userSonia, content: "Je viendrai de Marseille. Quequ'un pourrait me dire comment s'y rendre ?", date: Date(timeIntervalSince1970: 1687368600))],
    community: culturejaponaise
)
