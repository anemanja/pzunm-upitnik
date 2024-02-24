//
//  LoadingState.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import Foundation
import NMServices

enum LoadingState<Value> {
    case idle
    case loading(CGFloat)
    case failed(GenericError)
    case loaded(Value)
}
