//
//  GenericResponse.swift
//  GitHubUserSearch
//
//  Created by ADIL ZAHOOR MALIK on 19/11/2024.
//

import Foundation

struct GenericResponse: Codable {

    var message: String
    var status: Bool
    var total_pages:Int?
}

struct GenericResponseModel<T: Codable>: Codable {

    var message: String?
    var status: Bool?
    var data: T?
    var total_pages : Int?
    var user_token:String?

}


