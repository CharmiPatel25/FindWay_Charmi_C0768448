//
//  ViewController.swift
//  FindWay_Charmi_C0768448
//
//  Created by user174608 on 6/12/20.
//  Copyright © 2020 charmi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate{
       

   
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locationButton: UIButton!
    var LocationManager = CLLocationManager()
    var source = CLLocationCoordinate2D()
    var destination = CLLocationCoordinate2D()
    var travelMode: String = "Drive"
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // add long press gesture
        let uilpgr = UITapGestureRecognizer(target: self, action: #selector(tappress))
        mapView.addGestureRecognizer(uilpgr)
        uilpgr.numberOfTapsRequired = 2
        
        self.LocationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            LocationManager.delegate = self
            LocationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationManager.startUpdatingLocation()
        }
        
        setRegion()
    }
    
    
    
    
    
    @objc func tappress(gestureRecognizer: UIGestureRecognizer){
        
        mapView.removeAnnotations(mapView.annotations)
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        let touchPoint = gestureRecognizer.location(in: mapView)
        destination = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.title = "Destination"
        annotation.coordinate = destination
        mapView.addAnnotation(annotation)
        
    }
    
    
    func setRegion() {
        // define latitude and longitude for lambton college toronto
        let latitude: CLLocationDegrees = 42.974152
        let longitude: CLLocationDegrees = -82.347359
        let latDelta: CLLocationDegrees = 0.5
        let longDelta: CLLocationDegrees = 0.5
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
         mapView.delegate = self
        // mapView.userLocation = true
        
    }
    
    
    @IBAction func locationBtnClick(_ sender: UIButton) {
    }
    
    @IBAction func zoomInBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func travelModeSegment(_ sender: UISegmentedControl) {
    }
    @IBAction func zoomOutBtn(_ sender: UIButton) {
    }
    
}
extension ViewController: MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        source = locValue
    }
        
        
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 2.0
            return renderer
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 3.0
            return renderer
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 2.0
            return renderer
        }
        
        return MKOverlayRenderer()
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alert = UIAlertController(title: "Welcome to \(title)", message: "You have reached your destination :  \(title)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
}

