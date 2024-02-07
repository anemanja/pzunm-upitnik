//
//  NMPalette.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.1.24..
//

import Foundation
import SwiftUI

enum NMPalette: String, CaseIterable {
    case background = "background"
    case text = "text"
    case textSecondary = "secondaryText"
    case error = "error"
    case foreground = "foreground"
    case light = "light"
    
    public var color: Color {
        Color(self.rawValue)
    }
}

extension Color {
    public static var random: Color {
        NMPalette.allCases.randomElement()?.color ?? .accentColor
    }
}
