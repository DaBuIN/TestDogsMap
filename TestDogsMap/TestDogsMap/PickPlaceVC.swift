//
//  PickPlaceVC.swift
//  TestDogsMap
//
//  Created by Chuei-Ching Chiou on 19/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit
import MapKit

class PickPlaceVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func back(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load pickPlaceVC")

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back) )
        
        navBar.topItem?.leftBarButtonItem = backBtn
    }
    
    var countTap:Int = 0
    func mapTapHandle( gestureReg: UITapGestureRecognizer ) {
        countTap += 1
        print("Tap(\(countTap)) on mapView. OK!")
    }

}
