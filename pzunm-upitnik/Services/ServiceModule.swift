//
//  ServiceModule.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public class ServiceModule {
    public let authentication: any AuthenticationServiceProtocol
    public let certificates: any CertificatesServiceProtocol
    public let pdf: any PDFServiceProtocol
    public let localization: any LocalizationServiceProtocol
    
    init(authentication: any AuthenticationServiceProtocol,
         certificates: any CertificatesServiceProtocol,
         pdf: any PDFServiceProtocol,
         localization: any LocalizationServiceProtocol
    ) {
        self.authentication = authentication
        self.certificates = certificates
        self.pdf = pdf
        self.localization = localization
    }
}
