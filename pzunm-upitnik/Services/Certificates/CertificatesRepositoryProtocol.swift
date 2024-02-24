//
//  CertificatesRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.2.24..
//

import Foundation

public protocol CertificatesRepositoryProtocol {
    func getCertificates() async -> Result<[NMCertificate], GenericError>
}
