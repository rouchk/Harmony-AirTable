//
//  CreateEvenementView.swift
//  Harmony
//
//  Created by apprenant60 on 26/06/2023.
//

import SwiftUI

struct CreateEvenementView: View {
    
    @ObservedObject var currentUser: User
    @State var newEvent : String = ""
    @State var newDate : String = ""
    @State var showConfirmationMessage = false
    @State var moveToExploreView = false
    
    var body: some View {
        
        VStack {
            Text("Proposer un événement")
                .modifier(Head1())
                .padding(.vertical, 16)
            
            
            ZStack {
                Rectangle()
                    .frame(width: 390, height: 150)
                    .foregroundColor(Color.sky)
                
                
                Rectangle()
                    .frame(width: 300, height: 60)
                    .cornerRadius(10)
                    .foregroundColor(Color.graySky)
                    .offset(x:0 , y:0)
                HStack {
                    Image(systemName:"plus")
                    Text("Ajouter une photo de couverture")
                    
                }// End Hstack
            } // End Zstack
            List {
                Text("Nom de l'événement")
                
                TextField("Nom de l'événement", text: $newEvent)
                
                Text ("Date de début")
                
                
                TextField("Date de debut", text: $newDate)
                
                HStack {
                    Text("Evénement en ligne")
                    //                         .padding()
                    Spacer()
                    Image(systemName:"square")
                    //                    .offset(x:100 ,y:0)
                    
                }
                
                Text("Lieu")
                TextField("Lieu de l'événement", text: $newEvent)
                
                
                Text("Description")
                TextField("Déscription de l'événement", text: $newEvent)
                //                    .padding()
                //                    .frame(width: 100,height: 100)
            } //End List
            .padding()
            .listStyle(.plain)
            
            Button {
                showConfirmationMessage = true
//                showSheet.toggle()
            } label: {
                Text("Proposer l'événement")
                //                    .modifier(Head1())
                    .frame(width: 300, height: 44)
                    .foregroundColor(Color.white)
                .font(.custom("Urbanist", size: 20))
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.darkPeriwinkle)
            .padding()
            
            .alert("Merci !", isPresented: $showConfirmationMessage) {
                Button("OK") {
                 moveToExploreView = true
//                    showConfirmationMessage = false
//                    showSheet.toggle()
                }
            } message: {
                Text("Votre proposition a bien été transmise aux hôtes de la communauté. Elle sera examinée dans les mailleurs délais.")
            }
        }
//        .padding()
        .navigationDestination(isPresented: $moveToExploreView, destination: {ExploreView(currentUser: currentUser)})
    }
    
    
}




struct CreateEvenementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEvenementView(currentUser: myUser)
    }
}
