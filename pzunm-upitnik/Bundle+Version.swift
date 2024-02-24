//
//  Bundle+Version.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 21.2.24..
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
    }
    var buildVersionNumber: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
}
