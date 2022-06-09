//
//  API.swift
//  Task
//
//  Created by John Doe on 2022-06-08.
//

import Foundation
enum API{
    case getDefault
  
}

extension API: EndPoint{
    var baseURL: String {
        return "http://myjson.dit.upm.es"
    }
    var urlSubFolder: String {
        return "/api"
    }
    
    
    var queryItems: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    
    
    
    var method: HTTPMethod {
        switch self {
        default :
            return  .get
        }
    }
    
    
    var path: String {
        switch self {
        case .getDefault:
            return "bins/9cmx"
        }
    }
    
    var body: [String: Any]? {
        switch self{
        default:
            return nil
        }
    }
    
    
    

}

