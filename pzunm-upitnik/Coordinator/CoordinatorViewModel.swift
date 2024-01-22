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
    
    func present(with value: any Hashable) {
        path.append(value)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
