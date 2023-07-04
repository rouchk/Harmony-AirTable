//
//  EventsView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct EventsView: View {
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.darkPeriwinkle)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.darkPeriwinkle).withAlphaComponent(0.3)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor .white, .font : UIFont.systemFont(ofSize: 20)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor .white, .font : UIFont.systemFont(ofSize: 20)], for: .selected)
    } // Modify Color & Font size in the Picker
    
    @State private var selectedSegmentIndex = 0
    
    
    @ObservedObject var eventsList = EventsViewModel()
    
    var myProfil: User = myUser
    let now = Date() // Date() means the date and the time of now.

    var myFuturEvents: [Event] {
        return eventsList.eventsList.filter { event in
            (event.listParticipant.contains(myProfil)) && (event.date >= now)
        }.sorted(by: { $0.date < $1.date })
    }
    
    var myPastEvents: [Event] {
        return eventsList.eventsList.filter { event in
            (event.listParticipant.contains(myProfil)) && (event.date < now)
        }.sorted(by: { $0.date > $1.date })
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
                                    DetailEventView(event: event)
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
                                    DetailEventView(event: event)
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
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
