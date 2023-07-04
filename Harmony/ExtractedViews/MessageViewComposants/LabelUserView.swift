//
//  LabelUserView.swift
//  Harmony
//
//  Created by apprenant49 on 30/06/2023.
//

import SwiftUI

struct LabelUserView: View {
    var user : User
    
    var body: some View {
        HStack {
            IconUserView(icon: user.photo, isConnected: user.isConnected)
            Text(user.pseudo)
        }
    }
}
//
//struct LabelUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelUserView()
//    }
//}
