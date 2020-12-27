//
//  NetService.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import Foundation

class NetService {
    
    static let sharedInstanse: NetService = NetService()
    private let queue = DispatchQueue(label: "NetQueue", qos: .utility)
    
    func getData(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCredentialStorage = nil
        let session = URLSession(configuration: .default)
        self.queue.async {
            session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            } .resume()
        }
    }
    
}
