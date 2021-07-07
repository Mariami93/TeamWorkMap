//
//  UserLocationViewController.swift
//  userLocation
//
//  Created by Zura Kobakhidze on 07.07.21.
//

import CoreLocation
import UIKit
import MapKit

class UserLocationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Outlets

    @IBOutlet weak var calculatedDistance: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Variables
    
    var locationManager: CLLocationManager!
    var destinationAnnotation: MKPointAnnotation!
    var currentCoordinate: CLLocation?
    var destinationCoordinate: CLLocation?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        addGestureRecognizerOnMap()
    }
    
    //MARK: - Functions
    
    private func setupLayout(){
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        destinationAnnotation = MKPointAnnotation()
        locationManager.delegate = self
    }
    
    func addGestureRecognizerOnMap(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func calculateDistance(){
        guard let currentCoordinate = currentCoordinate else { return }
        guard let destinationCoordinate = destinationCoordinate else { return }
        
        let distanceInMeters = currentCoordinate.distance(from: destinationCoordinate)
        let result = round(distanceInMeters * 100) / 100.0
        
        calculatedDistance.text = "\(result)M"
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        mapView.removeAnnotation(destinationAnnotation)
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        destinationCoordinate = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        destinationAnnotation.coordinate = coordinate
        destinationAnnotation.title = "Destination"
        mapView.addAnnotation(destinationAnnotation)
    }
    
    //MARK: - Actions
    
    @IBAction func onCalculate(_ sender: Any) {
        calculateDistance()
    }
    
}

    //MARK: - Extensions

extension UserLocationViewController: CLLocationManagerDelegate{
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        case .denied, .restricted:
            openSettingsAlert()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        currentCoordinate = location
        
        pinUserLocation(latitude: latitude, longtitude: longitude)
        
        zoomToRegion(with: location)
        
    }
    
    //MARK: - CLLocationManagerDelegate Extension Functions
    
    func pinUserLocation(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let annontation = MKPointAnnotation()
        annontation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        annontation.title = "My Location"
        mapView.addAnnotation(annontation)
    }
    
    func zoomToRegion(with location: CLLocation){
        let regionRadius: CLLocationDistance = 1_000

        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    private func openSettingsAlert() {
        
        let alert = UIAlertController(title: "Attention", message: "To be able to use this feature you must have allowed location service", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "parameters", style: .default, handler: { _ in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            
        }))
        
        self.present(alert, animated: true)
    }
    
}
