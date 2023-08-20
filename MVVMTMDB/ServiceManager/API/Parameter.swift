//
//  Parameter.swift
//  MVVMTMDB
//
//  Created by Cenk Bahadır Çark on 20.08.2023.
//

import Foundation

enum Parameter {
    case apiKey(String)
    case page(String)
    
    var queryItem: URLQueryItem {
        switch self {
        case .apiKey(let value):
            return URLQueryItem(name: "api_key", value: value)
        case .page(let value):
            return URLQueryItem(name: "page", value: value)
        }
    }
}
