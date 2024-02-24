//
//  pzunm_upitnikApp.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.10.23..
//

import SwiftUI
import Networking

@main
struct pzunm_upitnikApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(CoordinatorViewModel(dependencyContainer: DependencyAssembler().assemble()))
        }
    }
}
