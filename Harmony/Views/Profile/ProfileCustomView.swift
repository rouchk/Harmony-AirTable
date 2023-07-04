//
//  ProfileCustomView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ProfileCustomView: View {
    @ObservedObject var currentUser : User
    
    @State private var showMediaGallery = false
    @State private var isAddingLanguage = false
    @State private var newLanguage = ""
    
    var body: some View {
        ScrollView {
            // Banner
            
            ScrollView {
                // Banner
                
                ZStack(alignment: .bottomTrailing) {
                    Image(currentUser.coverPhoto)
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fit)
                        .overlay(
                            ZStack {
                                Button(action: {
                                    showMediaGallery = true
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.black.opacity(0.5))
                                            .aspectRatio(16/9, contentMode: .fit)
                                            
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                            .foregroundColor(.white)
                                    }
                                }

                            }
                        )

                    Image(currentUser.photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                        .offset(x: -240, y: 84)
                        .overlay(
                            ZStack {
                                Button(action: {
                                    showMediaGallery = true
                                }) {
                                    ZStack {
                                        
                                        Rectangle()
                                            .foregroundColor(Color.black.opacity(0.5))
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                            .foregroundColor(.white)
                                    }
                                }
                                .offset(x: -240, y: 84)
                                
                            }
                        )
                }

                
                Text(currentUser.pseudo)
                    .modifier(Head1())
                
                Text(currentUser.city)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                VStack (alignment: .leading) {
                    Text("Média")
                        .modifier(Head1())
                        .padding()
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(currentUser.media, id: \.self) { media in
                                Button(action: {
                                    showMediaGallery = true
                                }) {
                                    Image(media)
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                // Action for add new media button tapped
                                showMediaGallery = true
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.gray)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // About me text
                    Text("À propos de moi")
                        .modifier(Head1())
                        .padding()
                    
                    TextField("Entrez une description", text: $currentUser.about)
                        .modifier(Normal())
                        .padding()
                    
                    // Language selection
                    Text("Mes langues")
                        .modifier(Head1())
                        .padding()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(currentUser.language, id: \.self) { language in
                                Text(language.rawValue)
                                    .padding(8)
                                    .background(Color.darkPeriwinkle)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            if isAddingLanguage {
                                Picker(selection: $newLanguage, label: Text("Ajouter une langue")) {
                                    ForEach(Language.allCases, id: \.self) { language in
                                        Text(language.rawValue)
                                            .tag(language.rawValue)
                                    }
                                }
                                .pickerStyle(DefaultPickerStyle())
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.horizontal)
                                
                                Button(action: {
                                    if let selectedLanguage = Language(rawValue: newLanguage) {
                                        currentUser.language.append(selectedLanguage)
                                        newLanguage = ""
                                        isAddingLanguage = false
                                    }
                                }) {
                                    Text("Ajouter")
                                        .padding(8)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            } else {
                                Button(action: {
                                    isAddingLanguage = true
                                }) {
                                    Text("+ Ajouter une langue")
                                        .padding(8)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding()


                    Spacer() // Add space at the bottom
                }
            }
        }
        .sheet(isPresented: $showMediaGallery) {
            // Present media gallery here
            MediaGalleryView(selectedMedia: $currentUser.media)
        }
    }
}



struct ProfileCustomView_Previews: PreviewProvider {
    static var previews: some View {
        //let userViewModel = UserViewModel(currentUser: myUser)
        
        ProfileCustomView(currentUser: myUser)
           // .environmentObject(userViewModel) // Provide the UserViewModel as an environment object
    }
}
