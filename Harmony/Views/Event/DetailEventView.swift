//
//  DetailEventView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct DetailEventView: View {
    
    @ObservedObject var event: Event
    
    let now = Date()
    var myProfil: User = myUser
    
    @State var showBookingForm = false
    
    @State var newContent: String = ""
    
    
    var body: some View {
        ScrollView(.vertical) {
            
            Image(event.photo) // Cover image
                .resizable()
                .scaledToFill()
                .frame(width: 390, height: 240)
                .clipped()
                .padding(.bottom, 8)
            
            
            VStack(spacing: 32) {
                
                EventInfoView(event: event)
                
                VStack(spacing: 12) {
                    
                    if (!self.event.community.members.contains(myProfil)) {
                        Text("Pour vous inscrire à l'événement, rejoignez d'abord la communauté.")
                            .font(.custom("Urbanist", size: 16))
                            .foregroundColor(Color("DarkPeriwinkle"))
                            .padding(.horizontal, 24)
                        // If the user isn't member of this community, this message is shown.
                        
                    } else if (self.event.listParticipant.contains(myProfil)) && ( self.event.date > now) {
                        DeactivatedButtonView()
                        // If the participants list contains my profil, a desactivated button is displayed.
                        
                        if self.event.isOnline == true {
                            NavigationLink {
                                WaitingToStartQuizView()
                            } label: {
                                Text("Commencer le Quiz")
                                    .frame(width: 342, height: 56)
                                    .background(Color.darkPeriwinkle)
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                                    .font(.custom("UrbanistRegular", size: 18))
                                    .fontWeight(.bold)
                            }
                        }
                        
                    } else if self.event.date < now {
                        // If the event date is past
                        ButtonEvenementPastView()
                    }
                    else {
                        BookButtonView(showBookingForm: $showBookingForm)
                    }   // Else, a registration button is displayed
                }
                
                if (self.event.listParticipant.contains(myProfil)) {
                    VStack(alignment: .leading) {
                        Text("Mon équipe")
                            .padding(.horizontal, 24)
                            .modifier(Head2())
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(event.team) { teamMate in
                                    NavigationLink {
                                        OtherUserProfileView(user: teamMate, eventsList: EventsViewModel())
                                    } label: {
                                        MyTeamView(teamMate: teamMate)
                                    }
                                }
                            }
                            .padding(.leading, 24)
                        }
                    }
                }
                
                
                
                VStack(alignment: .leading) {
                    Text("Participants")
                        .padding(.horizontal, 24)
                        .modifier(Head2())
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(event.listParticipant) { participant in
                                
                                NavigationLink {
                                    OtherUserProfileView(user: participant, eventsList: EventsViewModel())
                                } label: {
                                    ParticipantsView(participant: participant)
                                }
                            }
                        }
                        .padding(.leading, 24)
                    }
                }
                
                
                
                EventDescriptionView(event: event)
                
                
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Discussion")
                        .modifier(Head2())
                    
                    ForEach(event.comments) { comment in
                        DiscussionFeedView(comment: comment)
                    }
                }
                .padding(.horizontal, 24)
                
                
                WriteCommentFieldEventView(myProfil: myProfil, newContent: newContent, event: event)
                    .padding(.bottom, 8)
                
                
            }  // end VStack
            
            .sheet(isPresented: $showBookingForm) {
                BookingFormView(event: event, showBookingForm: $showBookingForm)
            }
            .presentationDetents([.medium, .large])
            
        } // end ScrollView
        .background(Color("whiteSmoke"))
        
        
    }
}

struct DetailEventView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEventView(event: eventExampleNonRegistered)
    }
}



// ------------------- ExtractedViews -------------------

struct EventInfoView: View {
    
    var event: Event
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: event.date)
    } // Convert the display format of event.date in "dd month yyyy" in French
    
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text(event.title)
                .modifier(Head0())
                .multilineTextAlignment(.center)
            
            Text(formattedDateString) // Display the converted date
                .modifier(Head2())
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    
                    MapPinView()
                        .frame(width: 28)
                    
                    VStack(alignment: .leading) {
                        Text(event.address?.namePlace ?? "Evénement")
                        HStack {
                            Text(event.address?.address ?? "en ligne")
                            Text(event.address?.city ?? "")
                        }
                    }
                    .padding(.leading, 4)
                }
                
                HStack {
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 16.0))
                        .frame(width: 28)
                    Text(event.community.name)
                        .padding(.leading, 4)
                }
            }
            .modifier(Normal())
            
        }
    }
}



struct DeactivatedButtonView: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Je suis déjà inscrit")
                .frame(width: 316, height: 44)
                .modifier(Head2())
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.sky.opacity(0.5))
        .cornerRadius(8)
    }
}



struct BookButtonView: View {
    
    @Binding var showBookingForm: Bool
    
    var body: some View {
        Button {
            showBookingForm = true
        } label: {
            Text("M'inscrire à l'événement")
                .frame(width: 316, height: 44)
                .foregroundColor(.white)
                .font(.custom("Urbanist", size: 18))
                .fontWeight(.bold)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.darkPeriwinkle)
        .cornerRadius(8)
    }
}



struct ButtonEvenementPastView: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Cet événement est terminé")
                .frame(width: 316, height: 44)
                .modifier(Head2())
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.sky.opacity(0.5))
        .cornerRadius(8)
    }
}



struct MyTeamView: View {
    
    var teamMate : User
    
    var body: some View {
        VStack {
            Image(teamMate.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text(teamMate.pseudo)
                .font(.custom("Urbanist", size: 12))
                .foregroundColor(Color.midnight)
                .frame(maxWidth: 44, maxHeight: .infinity, alignment: .center)
                
        }
    }
}



struct ParticipantsView: View {
    
    var participant: User
    
    var body: some View {
        VStack {
            Image(participant.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text(participant.pseudo)
                .font(.custom("Urbanist", size: 12))
                .foregroundColor(Color.midnight)
                .frame(maxWidth: 44, maxHeight: .infinity, alignment: .center)
        }
    }
}



struct EventDescriptionView: View {
    
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Description")
                .modifier(Head2())
//                .padding(.horizontal, 24)
            
            Text(event.detail)
                .modifier(Normal())
                .multilineTextAlignment(.leading)
            
            Text("Nombre minimum de participants : \(event.minParticipants) personnes")
                .font(.custom("Urbanist", size: 16))
                .foregroundColor(Color.darkGray)
//                .modifier(SmallGray())
        }
        .padding(.horizontal, 24)
    }
}




struct DiscussionFeedView: View {
    
    var comment: Comment
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: comment.date)
    }     // Convert the display format of comment.date
    
    
    var body: some View {
        
        VStack {
            Divider()
                .padding(.bottom, 16)
            
            HStack(alignment: .top)  {
                Image(comment.user.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Text(comment.user.pseudo)
                            .modifier(Head2())
                        
                        Spacer()
                        
                        Text(formattedDateString) // Display the date with the converted format
                            .font(.custom("Urbanist", size: 14))
                            .foregroundColor(Color.darkGray)
                            .padding(.trailing, 8)
                    }
                    .padding(.bottom, 4)
                    
                    Text(comment.content)
                        .modifier(Normal())
                    
                }
                .padding(.leading, 8)
            }
        }
    }
}



struct WriteCommentFieldEventView: View {
    
    var myProfil : User
    @State var newContent: String = ""
    //@ObservedObject var eventComments: Comments
    @ObservedObject var event: Event
    
    var body: some View {
        HStack {
            
            Image(myProfil.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38)
                .clipShape(Circle())
            
            TextField("Ecrire un commentaire", text: $newContent)
//                .frame(height: 16)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                            .cornerRadius(16)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.graySky))

            
            Button {
                event.addComment(newComment: Comment(user: myProfil, content: newContent, date: Date()))
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.sapphire)
            }
            
        }
        .padding(.horizontal, 24)
    }
}

struct WriteCommentFieldNewsView: View {
    
    var myProfil : User
    @State var newContent: String = ""
    //@ObservedObject var eventComments: Comments
    @ObservedObject var news: News
    
    var body: some View {
        HStack {
            
            Image(myProfil.photo)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            
            TextField("Ecrire un commentaire", text: $newContent)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                            .cornerRadius(16)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.graySky))
 
            
            Button {
                news.addComment(newComment: PostComment(user: myProfil, content: newContent, date: Date(), comlikes: 5))
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color.sapphire)
            }
            
        }
        .padding(.horizontal, 24)
    }
}




struct BookingFormView: View {
    
    @ObservedObject var event: Event
    
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        return dateFormatter.string(from: event.date)
    } // Convert the display format of event.date in "dd month yyyy" in French
    
    @State var showConfirmation = false
    @Binding var showBookingForm: Bool
    
    var body: some View {
        VStack {
            
//            ZStack {
//                BookingFormBannerShape()
//                Rectangle()
//                    .fill(Color.sapphire)
//                    .ignoresSafeArea()
//                    .frame(height: 148)
                
                VStack(spacing: 8) {
                    
                    Text("Inscription à l'événement")
                        .foregroundColor(Color.darkPeriwinkle)
                        .modifier(Head1())
                        .padding(.top, 48)
                                            
                    Text(event.title)
                        .foregroundColor(Color.sapphire)
                        .modifier(Head0())
                }
            .padding(.bottom, 24)

            
            VStack { // Need this VStack to apply 'listStyle(.plain)'
                List {
                    Text("Récapitulatif de l'événement")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .modifier(Head3())
                        .padding(8)
                    
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .frame(width: 60)
                        
                        Text(formattedDateString)
                    }
                    .padding(.vertical,8)
                    
                    HStack {
                        MapPinView()
                            .frame(width: 60)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.address?.namePlace ?? "Cet événement aura lieu")
                            
                            HStack {
                                Text(event.address?.address ?? "en ligne")
                                Text(event.address?.city ?? "")
                            }
                        }
                    }
                    .padding(.vertical,8)
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                            .frame(width: 60)
                        
                        Text(event.community.name)
                    }
                    .padding(.vertical,8)
                }
            }
            .listStyle(.plain)
            .modifier(Head2())
            
            
            Button {
                showConfirmation = true
            } label: {
                Text("Confirmer mon inscription")
                    .frame(width: 316, height: 44)
                    .foregroundColor(.white)
                    .font(.custom("Urbanist", size: 18))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.darkPeriwinkle)
            .cornerRadius(8)
            
            // Alert
            .alert("Merci ! Votre inscription a été prise en compte.", isPresented: $showConfirmation) {
                        Button("OK") {
                            showBookingForm = false
                            event.listParticipant.append(myUser)
                        }
                    }
            
            Spacer()
            
            
        }
    }
}
