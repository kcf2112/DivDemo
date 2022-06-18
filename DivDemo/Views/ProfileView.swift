//
//  ProfileView.swift
//  DivDemo
//
//  Created by Kevin Filer on 6/10/22.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileVM = ProfileViewModel()
    var security: Security
    
    var body: some View {
        GeometryReader { geom in
            ScrollView {
                VStack {
                    if let image = profileVM.logoImage {
                        Image( uiImage: image )
                            .resizable()
                            .scaledToFit()
                            .frame( width: 220, height: 220 )
                            //.frame( maxWidth: geom.size.width * 0.6 )
                            //.padding( .top )
                    }
                    // Divider()  // Barely visible, pretty much useless.
                     
                    VStack( alignment: .leading ) {
                        Rectangle() // Spacer element.
                            .frame( height: 2 )
                            //.foregroundColor( .lightBackground )
                            .padding( .vertical )
                        Text( "Symbol" )
                            .font( .title.bold() )
                            .padding( .bottom, 5 )
                        Text( profileVM.profile.symbol )
                        
                        Rectangle()
                            .frame( height: 2 )
                            //.foregroundColor( .lightBackground )
                            .padding( .vertical )
                        Text( "Name" )
                            .font( .title.bold() )
                            .padding( .bottom, 5 )
                        Text( profileVM.profile.companyName )

                        Rectangle()
                            .frame( height: 2 )
                            //.foregroundColor( .lightBackground )
                            .padding( .vertical )
                        Text( profileVM.profile.description )
                    }
                    .padding( .horizontal )
                }
                .padding( .bottom )
                //.foregroundColor( .white ) // Use preferredColorScheme
                .task {
                    await profileVM.loadProfile( security: security )
                }
            }
        }
        .navigationTitle( "Profile" )
        .navigationBarTitleDisplayMode( .inline )
        //.background(  )
    }
    
    init( security: Security ) {
        self.security = security
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView( security: Security( symbol: "ABC", dollarAmount: 10000 ) )
    }
}
