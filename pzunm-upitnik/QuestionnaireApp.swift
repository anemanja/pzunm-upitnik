//
//  pzunm_upitnikApp.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.10.23..
//

import SwiftUI
import GenericNetworking

@main
struct QuestionnaireApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView(dependencyContainer: DependencyAssembler().assemble())
                .environmentObject(CoordinatorViewModel())
        }
    }
}
