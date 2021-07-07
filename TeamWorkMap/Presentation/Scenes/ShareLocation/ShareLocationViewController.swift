//
//  ShareLocationViewController.swift
//  TeamWorkMap
//
//  Created by AltaSoftware MacMINI on 7/8/21.
//

import UIKit
import MapKit
import CoreLocation

class ShareLocationViewController: BaseViewController, MKMapViewDelegate
 {

    private var currentLocation: CLLocation?
        @IBOutlet weak var mapView: MKMapView!

        let locationManager = CLLocationManager()
        let regionInMeters: Double = 1000

        override func viewDidLoad() {
            super.viewDidLoad()
            mapView.delegate = self
                mapView.showsUserLocation = true
                

                // Check for Location Services
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.startUpdatingLocation()
                }
            checkLocationServices()
        }


        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }


        func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                mapView.setRegion(region, animated: true)
            }
        }
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
            }
        }


    func checkLocationAuthorization(authorizationStatus: CLAuthorizationStatus? = nil) {
        switch (authorizationStatus ?? CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        case .restricted, .denied:
            // show alert instructing how to turn on permissions
            print("Location Servies: Denied / Restricted")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func shareLocation(_ sender: Any) {
        
        

    }

}

    extension ShareLocationViewController: CLLocationManagerDelegate {

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            self.checkLocationAuthorization(authorizationStatus: status)
        }

        
    }

