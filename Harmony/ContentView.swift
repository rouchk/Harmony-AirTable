//
//  ContentView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var usersVM = UsersVM()
    @ObservedObject var eventsVM = EventsViewModel()
    @ObservedObject var newsmodel = Post()
    @ObservedObject var communitiesVM = CommunitiesVM()

    var body: some View {
        MenuView(usersVM: usersVM, eventsVM: eventsVM, newsmodel: newsmodel, communitiesVM: communitiesVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
