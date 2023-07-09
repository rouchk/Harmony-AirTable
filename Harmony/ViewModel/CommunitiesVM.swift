//
//  CommunitiesVM.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

class CommunitiesVM: ObservableObject {
    @Published var communitiesAPI : [CommunityAPI] = []
    @Published var communities : [Community] = []
    
    init() {
        Task {
            await self.fetchCommunities()
            
            for com in self.communitiesAPI {
                await self.communities.append(com.APItoClass())
            }
        }
    }
    
    func refresh() {
        self.communities = []
        Task {
            await self.fetchCommunities()
            
            for com in self.communitiesAPI {
                await self.communities.append(com.APItoClass())
            }
        }
    }
    
    func fetchCommunities() async {
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblwKuLCTfaHoRsQS/") {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")

                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(CommunityResponse.self, from: data) {
                    print("TABLE COMMUNITY OK")
                    self.communitiesAPI = decodedResponse.communities
                } else {
                    print("TABLE COMMUNITY BAD")
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
    func fetchCommunityById (id: String) async -> CommunityAPI? {
        var comm: CommunityAPI? = nil
        
        let apikey = "key7FutjOPCf6ezGz"
        if let url = URL(string: "https://api.airtable.com/v0/appr9cfDbLcGoVIf8/tblwKuLCTfaHoRsQS/" + id) {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try? JSONDecoder().decode(RecordCommunity.self, from: data) {
                    print("GET COMMUNITY ID OK")
                    comm = decodedResponse.fields
                    if (comm == nil) {
                        print("GET COMMUNITY ID BAD")
                    }
                } else {
                    print("PAS BONNN")
                }
            } catch {
                print("Invalid data")
            }
        }
        return comm
    }
    
    func getCommunityById(id: String) -> Community? {
        if self.communities != nil {
            for comm in self.communities {
                if comm.idAPI == id {
                    return comm
                }
            }
        }
        
        return nil
    }
    
    func getCommunityByIdInAirtable(id: String) async -> Community? {
        let commAPI = await self.fetchCommunityById(id: id)
        var comm: Community? = nil
        var isNew = true
        
        if commAPI != nil {
            self.communitiesAPI = self.communitiesAPI.map {
                var mutableComm = $0
                if ($0.id == id) {
                    isNew = false
                    mutableComm = commAPI!
                }
                return mutableComm
            }
            
            comm = await commAPI!.APItoClass()
            
            if isNew {
                self.communitiesAPI.append(commAPI!)
                self.communities.append(comm!)
            } else {
                self.communities = self.communities.map {
                    var mutableComm = $0
                    if $0.idAPI == id {
                        mutableComm = comm!
                    }
                    return mutableComm
                }
            }
    
        }
        
        return comm!
    }
}

