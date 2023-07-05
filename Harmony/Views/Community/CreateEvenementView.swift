//
//  CreateEvenementView.swift
//  Harmony
//
//  Created by apprenant60 on 26/06/2023.
//

import SwiftUI
import PhotosUI

struct CreateEvenementView: View {
    
    @ObservedObject var currentUser: User
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var image: UIImage?
    
    @State var newEventName : String = ""
    @State var from : Date = Date.now.addingTimeInterval(24.0 * 3600.0)
    @State var to : Date = Date.now.addingTimeInterval(24.0 * 3600.0 + 7200.0)
    @State var isOnline: Bool = false
    @State var newEventPlaceName : String = ""
    @State var newEventAddress : String = ""
    @State var newEventCity : String = ""
    
    @State var showConfirmationMessage = false
    @State var moveToExploreView = false
    
    var body: some View {
        
        VStack {
            Text("Proposer un événement")
                .modifier(Head1())
                .padding(.vertical, 16)
            
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 390, height: 200)
            } else {
                ZStack {
                    Rectangle()
                        .frame(width: 390, height: 200)
                        .foregroundColor(Color.sky.opacity(0.7))
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack {
                                Image(systemName:"plus")
                                Text("Ajouter une photo de couverture")
                            }
                            .modifier(Normal())
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                // Retrieve selected asset in the form of Data
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                }
            }
            
            
            Form {
                Section(header: Text("Nom de l'événement").textCase(nil)) {
                    TextField("Choisissez un nom explicite.", text: $newEventName)
                }
                
                Section(header: Text ("Date et heure").textCase(nil)) {
                    DatePicker("Début", selection: $from)
                        .datePickerStyle(.compact)
                        .modifier(Normal())
                    
                    DatePicker("Fin", selection: $to)
                        .datePickerStyle(.compact)
                        .modifier(Normal())
                }
                
                Section(header: Text("Lieu").textCase(nil)) {
                    Toggle(isOn: $isOnline) {
                        Text("Evénement en ligne")
                            .modifier(Normal())
                    }
                    TextField("Nom du lieu", text: $newEventPlaceName)
                    TextField("Adresse", text: $newEventAddress)
                    TextField("Ville et arrondissement", text: $newEventCity)
                }
                
                Section(header: Text("Description").textCase(nil)) {
                    TextField("Expliquez les détails de l'événement.", text: $newEventName)
                }
            } //End Form
            .tint(Color.darkPeriwinkle)
            .scrollContentBackground(.hidden)
            .font(.custom("UrbanistRegular", size: 16))
            .foregroundColor(Color("DarkPeriwinkle"))
            
            Button {
                showConfirmationMessage = true
            } label: {
                Text("Proposer l'événement")
                    .frame(width: 300, height: 44)
                    .foregroundColor(Color.white)
                    .font(.custom("UrbanistSemibold", size: 20))
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.darkPeriwinkle)
            .padding()
            
            .alert("Merci !", isPresented: $showConfirmationMessage) {
                Button("OK") {
                    moveToExploreView = true
                }
            } message: {
                Text("Votre proposition a bien été transmise aux hôtes de la communauté. Elle sera examinée dans les mailleurs délais.")
            }
        }
        .navigationDestination(isPresented: $moveToExploreView, destination: {ExploreView(currentUser: currentUser)})
    }
}




struct CreateEvenementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEvenementView(currentUser: myUser)
    }
}
