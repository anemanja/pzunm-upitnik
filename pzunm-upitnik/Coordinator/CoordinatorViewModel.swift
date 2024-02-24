//
//  CoordinatorViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation
import NMModel
import SwiftUI

final class CoordinatorViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var shouldCover = false

    init(path: NavigationPath = NavigationPath(), shouldCover: Bool = false) {
        self.path = path
        self.shouldCover = shouldCover
    }
    
    var questionnairePreviewCoverData: NMQuestionnairePreview?
    
    func present(with value: any Hashable) {
        path.append(value)
    }
    
    func cover(with questionnairePreviewData: NMQuestionnairePreview) {
        shouldCover = true
        questionnairePreviewCoverData = questionnairePreviewData
    }

    func dismissCover() {
        shouldCover = false
    }
    
    func popToRoot() {
        shouldCover = false
        path.removeLast(path.count)
    }
}
