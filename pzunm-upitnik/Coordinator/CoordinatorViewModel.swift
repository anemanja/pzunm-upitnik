//
//  CoordinatorViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation
import SwiftUI

final class CoordinatorViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var shouldCover = false

    var dependencyContainer: DependencyContainer

    init(path: NavigationPath = NavigationPath(), shouldCover: Bool = false, dependencyContainer: DependencyContainer) {
        self.path = path
        self.shouldCover = shouldCover
        self.dependencyContainer = dependencyContainer
    }
    
    var questionnairePreviewCoverData: NMQuestionnairePreview?
    
    func present(with value: any Hashable) {
        path.append(value)
    }
    
    func cover(with questionnairePreviewData: NMQuestionnairePreview) {
        shouldCover = true
        questionnairePreviewCoverData = questionnairePreviewData
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
