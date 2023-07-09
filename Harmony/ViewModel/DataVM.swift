//
//  DataVM.swift
//  Harmony
//
//  Created by apprenant49 on 05/07/2023.
//

import Foundation

class DataVM : ObservableObject {
    @Published var usersVM: UsersVM
    @Published var eventsVM: EventsViewModel
    @Published var postVM: Post
    
    init() {
        self.usersVM = UsersVM()
        self.eventsVM = EventsViewModel()
        self.postVM = Post()
    }
}
