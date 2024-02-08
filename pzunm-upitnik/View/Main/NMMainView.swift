//
//  NMMainView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct NMMainView: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    
    @State var isAuthenticated = false
    
    var body: some View {
        ZStack {
            VStack {
                NMAuthenticationView(isAuthenticated: $isAuthenticated)
                Spacer()
            }
            VStack {
                Spacer()
                    .frame(height: 100.0)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200.0)
                Text("UPITNIK O ZDRAVSTVENOM STANJU")
                    .dynamicTypeSize(.xxxLarge)
                Spacer()
                NMCardView {
                    NMClientsView(shouldShowAll: $isAuthenticated)
                }
                .padding()
                Spacer()
            }
            .background(Color(NMPalette.light.rawValue))
        }
    }
}

struct NMMainView_Previews: PreviewProvider {
    static var previews: some View {
        NMMainView()
            .environmentObject(CoordinatorViewModel())
            .environmentObject(NMClientsViewModel(clientsService: NMClientsServiceImplementation(repository: MockRepositoryModule().clients)))
            .environmentObject(NMAuthenticationViewModel(authenticationService: NMAuthenticationServiceImplementation(repository: MockRepositoryModule().authentication)))
    }
}
