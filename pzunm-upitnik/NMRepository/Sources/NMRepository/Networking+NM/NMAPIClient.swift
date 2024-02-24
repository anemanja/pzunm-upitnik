//
//  File.swift
//  
//
//  Created by Немања Аврамовић on 24.2.24..
//

import Foundation
import Networking

public class NMAPIClientWrapper {
    let apiClient = APIClient<Endpoint>(dataParser: DataParser.json,
                                                responseParser: ResponseParser(),
                                                requestBuilder: NMRequestBuilder())

    public init() {}
}
