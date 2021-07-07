//
//  SelectedMapViewController.swift
//  MyTask2
//
//  Created by Luka Bukuri on 07.07.21.
//

import UIKit
import MapKit
import CoreLocation
class SelectedMapViewController: UIViewController {

    var selectedCountry: String?
    
    var lat = 0.0
    var long = 0.0
    
    let myPin: MKPointAnnotation = MKPointAnnotation()
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(recognizeLongPress(_:)))
        
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let region = MKCoordinateRegion(
            center: coordinates,
            latitudinalMeters: 1000000,
            longitudinalMeters: 1000000
        )
        
        mapView.setRegion(region, animated: true)
        mapView.addGestureRecognizer(longPress)
        mapView.delegate = self
        
        if userDefaults.array(forKey: selectedCountry!) != nil
        {
            let pinCoordinatesArray = userDefaults.array(forKey: selectedCountry!) as! [Double]
            let pinCoordinates = CLLocationCoordinate2D(latitude: pinCoordinatesArray[0], longitude: pinCoordinatesArray[1])

            myPin.coordinate = pinCoordinates
            mapView.addAnnotation(myPin)
        }
    }
    
    @objc private func recognizeLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began {
                return
            }
        mapView.removeAnnotation(myPin)
        let location = sender.location(in: mapView)
        let myCoordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        let pinLat : Double = myCoordinate.latitude
        let pingLong : Double = myCoordinate.longitude
        
        userDefaults.setValue([pinLat,pingLong], forKey: selectedCountry!)
            myPin.coordinate = myCoordinate
            mapView.addAnnotation(myPin)
        }
 
}

extension SelectedMapViewController: MKMapViewDelegate {
    
    // Delegate method called when addAnnotation is done.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let myPinIdentifier = "PinAnnotationIdentifier"
        let myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)
        myPinView.animatesDrop = true
        myPinView.canShowCallout = true
        myPinView.annotation = annotation
        
        print("latitude: \(annotation.coordinate.latitude), longitude: \(annotation.coordinate.longitude)")
        
        return myPinView
    }
}
