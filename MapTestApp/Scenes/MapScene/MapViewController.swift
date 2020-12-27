//
//  MapViewController.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

protocol MapDisplayLogic: class {
    func displayClients(viewModel: MapModels.Clients.ViewModel)
}

final class MapViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: MapBusinessLogic?
    var router: (MapRoutingLogic & MapDataPassing)?
    
    // MARK: - Private Properties
    
    private var mapView = GMSMapView()
    private var clusterManager: GMUClusterManager!
    private var city: City?
    private var clients: [Client] = []
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        fetchData()
        setupMap()
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        interactor?.fetchClients(request: MapModels.Clients.Request())
    }
    
    private func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: city?.latitude ?? 55.751244, longitude: city?.longitude ?? 37.618423, zoom: 5.0)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        setMode()
        view = mapView
    }
    
    private func setMode() {
        if #available(iOS 12.0, *) {
            traitCollection.userInterfaceStyle == .dark ? setDarkMode() : setLightMode()
        }
    }
    
    private func setDarkMode() {
        do {
            guard let styleURL = Bundle.main.url(forResource: "gmsDarkStyle", withExtension: "json") else { return }
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
        } catch {
            router?.routeToAlert(title: "Failed to load dark theme", message: "")
        }
    }
    
    private func setLightMode() {
        mapView.mapStyle = nil
    }
    
    private func generateClusterItems() {
        for client in clients {
            let latitude = client.latitude
            let longitude = client.longitude
            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let marker = GMSMarker(position: position)
            marker.title = client.clientCode
            marker.snippet = String(client.idClient)
            let customMarker = RoundMarkerView(frame: CGRect(x: 0, y: 0, width: 40, height: 46), imageName: "user", borderColor: .systemRed)
            marker.iconView = customMarker
            clusterManager.add(marker)
        }
        
    }
    
    private func configureMarkers() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setMapDelegate(self)
        generateClusterItems()
        clusterManager.cluster()
    }
    
    // MARK: - TraitCollectionDidChange
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setMode()
    }
    
}

// MARK: - Map Display Logic

extension MapViewController: MapDisplayLogic {
    
    func displayClients(viewModel: MapModels.Clients.ViewModel) {
        clients = viewModel.clients
        city = viewModel.city
        configureMarkers()
    }
    
}

// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        if let _ = marker.userData as? GMUCluster {
            mapView.animate(toZoom: mapView.camera.zoom + 1)
            return true
        }
        return false
    }
    
}
