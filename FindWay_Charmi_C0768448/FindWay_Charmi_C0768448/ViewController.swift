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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.LocationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            LocationManager.delegate = self
            LocationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationManager.startUpdatingLocation()
        }
    }

 //42.974152
    // -82.347359
}

