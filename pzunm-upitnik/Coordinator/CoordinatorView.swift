//
//  CoordinatorView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct CoordinatorView: View {
    @EnvironmentObject var viewModel: CoordinatorViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            NMMainView()
                .navigationDestination(for: NMClient.self) { client in
                    if client.language != nil {
                        NMLanguagesView(client: client)
                    } else {
                        NMQuestionnaireView(client: client)
                    }
                }
        }
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
            .previewDevice("iPad mini (6th generation)")
            .environmentObject(CoordinatorViewModel())
    }
}
