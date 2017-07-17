//
//  MapVC.swift
//  TestDogsMap
//
//  Created by Chuei-Ching Chiou on 18/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var pins:Array<MKPointAnnotation>? = []
    var locations:[String:CLLocationCoordinate2D]? = [:]
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDB()

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print(locations?.description)
//        print(pins?.description)
//        
//        mapView.addAnnotations(pins!)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        

        print(locations?.description)
        print(pins?.description)
        
        mapView.addAnnotations(pins!)
        
    }
    
    private func setAnnotation( title:String, subtitle:String, coordinate: CLLocationCoordinate2D ) -> MKPointAnnotation {
        let annotation:MKPointAnnotation = MKPointAnnotation()
        
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = coordinate
        
        return annotation
    }

    private func loadDB() {
        
        let url = URL(string: "https://together-seventsai.c9users.io/getSjc.php")
        let session = URLSession(configuration: .default)
        
        var req = URLRequest(url: url!)
        req.httpMethod = "POST"
        
        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
            
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                
                for obj in jsonObj as! Array<[String:String]> {
                    
                    
                    let name:String = obj["subject"]!
                    let latStr:String = obj["lat"]!
                    let lngStr:String = obj["lng"]!
                    
//                    print(obj.description)
//                    print("\(name): \(latStr), \(lngStr)")
                    
                    let coor:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latStr)!, CLLocationDegrees(lngStr)! )
                    
                    self.locations?[name] = coor
                    
                }
                
                for loc in self.locations! {
                    let title:String = loc.key
                    let subtitle:String = "\(loc.value.latitude),\(loc.value.longitude)"
                    let coordinate:CLLocationCoordinate2D = loc.value
                    
                    self.pins! += [self.setAnnotation(title: title, subtitle: subtitle, coordinate: coordinate)]
                    
                }
                
            } catch {
                print(error)
            }
        
        })
        
        task.resume()
    }



}
