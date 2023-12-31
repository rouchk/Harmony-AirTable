//
//  EventsView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct EventsView: View {
    
    @ObservedObject var usersVM: UsersVM
    @ObservedObject var eventsList: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    
    init(usersVM: UsersVM, eventsList: EventsViewModel, communitiesVM: CommunitiesVM) {
        self.usersVM = usersVM
        self.eventsList = eventsList
        self.communitiesVM = communitiesVM
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.darkPeriwinkle)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.darkPeriwinkle).withAlphaComponent(0.2)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.darkPeriwinkle), .font : UIFont.systemFont(ofSize: 16)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor .white, .font : UIFont.systemFont(ofSize: 16)], for: .selected)
    } // Modify Color & Font size in the Picker
    
    @State private var selectedSegmentIndex = 0
    
    let now = Date() // Date() means the date and the time of now.

    var myEvents: [Event] {
        return eventsList.eventsList.map {
            var mutateEvent = $0
            mutateEvent.listParticipant = mutateEvent.listParticipant.map {
                var mutateUser = $0
                if !mutateUser.isFetch {
                    let id = mutateUser.idAPI
                    var us = usersVM.getUserById(id: id)
                    
                    if us == nil {
                        Task {
                            await us = usersVM.getUserByIdInAirtable(id: id)
                            if us != nil {
                                mutateUser = us!
                            }
                        }
                    } else {
                        mutateUser = us!
                    }
                }
                return mutateUser
            }
            return mutateEvent
        }
    }
    var myFuturEvents: [Event] {
        return myEvents.filter { event in
            (event.listParticipant.contains(usersVM.myUser!)) && (event.date! >= now)
        }.sorted(by: { $0.date! < $1.date! })
    }
    
    var myPastEvents: [Event] {
        return myEvents.filter { event in
            (event.listParticipant.contains(usersVM.myUser!)) && (event.date! < now)
        }.sorted(by: { $0.date! > $1.date! })
    }
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Picker("Filter", selection: $selectedSegmentIndex)  {
                    Text("A venir")
                        .tag(0)
                    Text("Passés")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.vertical, 16)
                
                if selectedSegmentIndex == 0 {
    // When the user arrives on this screen, 'A venir' est selected on the Picker, so the coming events are shown on the list.
                    List {
                        ForEach(myFuturEvents) { event in
                            ZStack {
                                NavigationLink {
                                    DetailEventView(event: event, eventsVM: eventsList, usersVM: usersVM, communitiesVM: communitiesVM)
                                } label: {
                                    EventListRowView(myEvent: event)
                                }
                            }
                            .listRowBackground(
                                Rectangle()
                                    .fill(.white)
                                    .padding(16)
                            )
                            .background(Color.white)
                            .frame(width: 342)
                            .cornerRadius(8)
                            .listRowSeparator(.hidden)
                        }
                    } // end List
                    .listStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                } else {
    // When the user tap on 'Passés' on the Picker, selectedSegmentIndex becomes '1', so the past events are shown.
                    List {
                        ForEach(myPastEvents) { event in
                            ZStack {
                                NavigationLink {
                                    DetailEventView(event: event, eventsVM: eventsList, usersVM: usersVM, communitiesVM: communitiesVM)
                                } label: {
                                    EventListRowView(myEvent: event)
                                }
                            }
                            .listRowBackground(
                                Rectangle()
                                    .fill(.white)
                                    .padding(16)
                            )
                            .background(Color.white)
                            .frame(width: 342)
                            .cornerRadius(8)
                            .listRowSeparator(.hidden)
                        }
                    } // end List
                    .listStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
               }
                
                                
            } // end VStack
            .padding(.horizontal, 24)
            .background(Color .whiteSmoke)
            .navigationBarTitle("Mes événements", displayMode: .inline)

        } // end NavigationStack
        .onAppear {
            eventsList.refresh()
        }
    }
}
//
//struct EventsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsView()
//    }
//}
