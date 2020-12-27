//
//  MapRouter.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import UIKit

protocol MapRoutingLogic {
    func routeToAlert(title: String, message: String)
}

protocol MapDataPassing {
    var dataStore: MapDataStore? { get }
}

final class MapRouter: MapRoutingLogic, MapDataPassing {
    
    // MARK: - Public Properties
    
    weak var viewController: MapViewController?
    var dataStore: MapDataStore?
    
    // MARK: - Routing Logic
    
    func routeToAlert(title: String, message: String) {
        viewController?.showAlertWithOneButton(title: title, message: message, buttonTitle: "OK", buttonAction: nil)
    }
    
}
