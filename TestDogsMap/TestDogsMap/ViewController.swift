//
//  ViewController.swift
//  TestDogsMap
//
//  Created by Chuei-Ching Chiou on 18/07/2017.
//  Copyright © 2017 DaBuIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // test commit by Rand God

    @IBAction func backHome(segue:UIStoryboardSegue) {
        print("back home")
    }
    
    @IBAction func goTest(_ sender: Any) {
        if let vc:MapVC = storyboard?.instantiateViewController(withIdentifier: "mapVC") as! MapVC {
        
            show(vc, sender: self)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

