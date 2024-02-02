//
//  LoadingState.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading(CGFloat)
    case failed(Error)
    case loaded(Value)
}
