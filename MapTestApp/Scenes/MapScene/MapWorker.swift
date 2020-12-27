//
//  MapWorker.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import Foundation

protocol MapWorkingLogic {
    func fetchClients(completion: @escaping ([Client], Error?) -> ())
}

final class MapWorker: MapWorkingLogic {
    
    // MARK: - Private Properties
    
    private let net = NetService.sharedInstanse
    
    // MARK: - Working Logic
    
    func fetchClients(completion: @escaping ([Client], Error?) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/96149d36-4ce8-4d4b-a3ac-f937068a1d35") else { return }
        net.getData(with: url) { (data, error) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode([Client].self, from: data)
                completion(response, nil)
            } catch {
                completion([], error)
            }
        }
    }
    
}
