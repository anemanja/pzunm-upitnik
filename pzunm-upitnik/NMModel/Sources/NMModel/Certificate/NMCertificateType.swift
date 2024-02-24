//
//  NMCertificateType.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 21.2.24..
//

import Foundation

public enum NMCertificateType: String, Codable {
    case sport = "za sportiste"
    case driving = "o zdravstvenoj sposobnosti za upravljanje vozilom"
    case residence = "za boravak i rad u Crnoj Gori"
    case hazardWorkNoHeight = "za otežane uslove rada bez rada na visinu"
    case other = "drugo"
}
