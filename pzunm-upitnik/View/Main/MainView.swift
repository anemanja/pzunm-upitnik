//
//  MainView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    
    @State var isAuthenticated = false
    
    var body: some View {
        ZStack {
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
                CardView { _ in
                    CertificatesView(shouldShowAll: $isAuthenticated)
                }
                .padding()
                Spacer()
            }
            .background(Color.nmBackground)
            VStack {
                AuthenticationView(isAuthenticated: $isAuthenticated)
                Spacer()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CoordinatorViewModel())
            .environmentObject(CertificatesViewModel(certificatesService: CertificatesService(repository: MockRepositoryModule().certificates)))
            .environmentObject(AuthenticationViewModel(authenticationService: AuthenticationService(repository: MockRepositoryModule().authentication)))
    }
}
