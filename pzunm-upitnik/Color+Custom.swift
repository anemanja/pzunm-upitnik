//
//  NMPalette.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.1.24..
//

import Foundation
import SwiftUI

extension Color {
    /// A context-dependent color to be used for **main text areas**.
    public static let nmPrimaryText = Color("text")
    
    /// A context-dependent color to be used for secondary text areas like **placeholders**.
    public static let nmPlaceholderText = Color("secondaryText")
    
    /// A context-dependent color to be used as background for **main text areas**.
    public static let nmTextBackground = Color("background")
    
    /// A context-dependent color to be used as **general background**.
    public static let nmBackground = Color("light")
    
    /// A context-dependent color to be used as the app's **main UI color**.
    public static let nmPrimary = Color("foreground")
    
    /// A context-dependent color to be used for highlighting **errors and warnings**.
    public static let nmError = Color("error")

    /// A context-dependent color to be used for **titles**.
    public static let nmTitle = Color("title")
}
