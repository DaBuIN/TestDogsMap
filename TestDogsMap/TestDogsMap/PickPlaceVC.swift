//
//  PickPlaceVC.swift
//  TestDogsMap
//
//  Created by Chuei-Ching Chiou on 19/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PickPlaceVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var lmgr:CLLocationManager?
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func back(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showUser(_ sender: Any) {
        let userLoc = lmgr?.location
        
        if !mapView.showsUserLocation {
            mapView.showsUserLocation = true
            print("User location: \(userLoc?.coordinate.latitude), \(userLoc?.coordinate.longitude)")
        } else {
            mapView.showsUserLocation = false
        }
    }
    
    @IBAction func allowOnlyOne(_ sender: Any) {
    }
    
    @IBAction func allowMultipleOnes(_ sender: Any) {
    }
    
    @IBAction func cleanAnnotations(_ sender: Any) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first as! CLLocation
        
        print("locationManager: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        
    }
    
    
    private func initStat() {
        
        
        if CLLocationManager.locationServicesEnabled() {
            
            lmgr = CLLocationManager()
            
            lmgr?.delegate = self
            lmgr?.desiredAccuracy = kCLLocationAccuracyBest
            lmgr?.requestWhenInUseAuthorization()
            lmgr?.startUpdatingLocation()
            lmgr?.distanceFilter = CLLocationDistance(10)
        }
    }
    
    private func initStatMap() {
        mapView.delegate = self
        
        let mapSingleTapReg = UITapGestureRecognizer(target: self, action: #selector(mapTapHandle) )
        mapSingleTapReg.delegate = self as? UIGestureRecognizerDelegate
        
        mapSingleTapReg.numberOfTapsRequired = 1
        mapSingleTapReg.numberOfTouchesRequired = 1
        
        let mapDoubleTapReg = UITapGestureRecognizer(target: self, action: nil)
        mapDoubleTapReg.delegate = self as? UIGestureRecognizerDelegate
        mapDoubleTapReg.numberOfTapsRequired = 2
        mapDoubleTapReg.numberOfTouchesRequired = 1
        
        // to distinguish single- and double-tap
        mapSingleTapReg.require(toFail: mapDoubleTapReg )
        
        // to make mapView recognizing single- and double-tap gestures
        mapView.addGestureRecognizer(mapSingleTapReg)
        mapView.addGestureRecognizer(mapDoubleTapReg)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load pickPlaceVC")
        
        initStat()
        initStatMap()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back) )
        
        navBar.topItem?.leftBarButtonItem = backBtn
    }
    
    var countTap:Int = 0
    func mapTapHandle( tapReg: UITapGestureRecognizer ) {
        countTap += 1
        
        let location = tapReg.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        print("Tap(\(countTap)) on mapView: \(coordinate.latitude),\(coordinate.longitude)")
        
        // add annotation
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        annotation.title = "Tap(\(countTap))"
        annotation.subtitle = "\(coordinate.latitude),\(coordinate.longitude)"
        
        mapView.addAnnotation(annotation)

    }

}
