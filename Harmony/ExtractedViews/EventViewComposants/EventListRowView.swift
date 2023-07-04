//
//  EventListRowView.swift
//  Harmony
//
//  Created by apprenant49 on 27/06/2023.
//

import Foundation
import SwiftUI

struct EventListRowView: View {
    
    var myEvent: Event
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: myEvent.date)
    } // Convert the display format of myEvent.date
    
    var isSmall: Bool? = false
    
    var body: some View {
        
        HStack {
            
            Image(myEvent.photo)
                .resizable()
                .scaledToFill()
                .frame(width: !isSmall! ? 120 : 90, height: !isSmall! ? 132 : 99)
                .clipped()
            
            VStack(alignment: .leading, spacing: !isSmall! ? 8 : 2) {
                if (!isSmall!) {
                    Text(myEvent.title)
                        .modifier(Head1())
                        .multilineTextAlignment(.leading)
                    
                    Text(formattedDateString)
                        .modifier(Head3()) // Affciher myEvent.date en format "jj mois aaaa"
                    
                    HStack {
                        if myEvent.isOnline {
                            Image(systemName: "iphone.gen3")
                        } else {
                            
                            MapPinView() // icon Map Pin
                            }
                    
                        Text(myEvent.address?.city ?? "En ligne")
                    }
                    .modifier(HeadGray())
                } else {
                    Text(myEvent.title)
                        .modifier(MinHead1())
                    
                    Text(formattedDateString)
                        .modifier(MinHead3())
                    
                    
                    HStack {
                        MapPinView() // icon Map Pin
                        
                        Text(myEvent.address?.city ?? "En ligne")
                    }
                    .modifier(MinHeadGray())
                }
               
                
                
            }
            .frame(width: !isSmall! ? 172 : 90, alignment: .leading)
            .padding(.leading, !isSmall! ? 16 : 4)

            
            if !isSmall! {
                Image(systemName: "chevron.right")
                    .modifier(Head3()) // icon ">" en couleur darkPeriwinkle
            }
        }
        .frame(width: !isSmall! ? 342 : 200)
        .background(.white)
        
    }
}
