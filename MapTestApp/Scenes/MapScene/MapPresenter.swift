//
//  MapPresenter.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import UIKit

protocol MapPresentationLogic {
    func presentClients(response: MapModels.Clients.Response)
}

final class MapPresenter: MapPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: MapDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentClients(response: MapModels.Clients.Response) {
        viewController?.displayClients(viewModel: MapModels.Clients.ViewModel(clients: response.clients, city: response.city))
    }
    
}
