//
//  LoadingObject.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import Foundation

protocol LoadingObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}
