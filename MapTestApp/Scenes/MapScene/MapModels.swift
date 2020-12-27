//
//  MapModels.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import UIKit

// MARK: - Client Model

struct Client: Decodable {
    var idClient: Int
    var idClientAccount: Int
    var clientCode: String
    var latitude: Double
    var longitude: Double
    var avatarHash: String?
    var statusOnline: Bool
    
    private enum CodingKeys: String, CodingKey {
        case idClient = "IdClient"
        case idClientAccount = "IdClientAccount"
        case clientCode = "ClientCode"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case avatarHash = "AvatarHash"
        case statusOnline = "StatusOnline"
    }
}

enum MapModels {
    
    // MARK: - Clients
    
    enum Clients {
        
        struct Request {
        }
        
        struct Response {
            var clients: [Client]
            var city: City
        }
        
        struct ViewModel {
            var clients: [Client]
            var city: City
        }
    }
    
}
