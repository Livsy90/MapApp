//
//  MapInteractor.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import Foundation

protocol MapBusinessLogic {
    func fetchClients(request: MapModels.Clients.Request)
}

protocol MapDataStore {
    var clients: [Client] { get set }
    var city: City { get set }
}

final class MapInteractor: MapBusinessLogic, MapDataStore {
    
    // MARK: - Public Properties
    
    var presenter: MapPresentationLogic?
    lazy var worker: MapWorkingLogic = MapWorker()
    
    // MARK: - Data Store
    
    var clients: [Client] = []
    var city: City = City(name: "Moscow", latitude: 55.751244, longitude: 37.618423)
    
    // MARK: - Business Logic
    
    func fetchClients(request: MapModels.Clients.Request) {
        worker.fetchClients { [weak self] (clients, error) in
            guard let self = self else { return }
            self.clients = clients
            self.presenter?.presentClients(response: MapModels.Clients.Response(clients: clients, city: self.city))
        }
    }
    
}
