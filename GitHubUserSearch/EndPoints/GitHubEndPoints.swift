////
////  GitHubEndPoints.swift
////  GitHubUserSearch
////
////  Created by ADIL ZAHOOR MALIK on 19/11/2024.
////



import Foundation

struct GitHubUserSearchEndpoint: Endpoint {
    var query: String
    
    var path: String {
        return "/search/users"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "q", value: query)]
    }
}

struct GitHubUserDetailEndpoint: Endpoint {
    var username: String
    
    var path: String {
        return "/users/\(username)"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}


