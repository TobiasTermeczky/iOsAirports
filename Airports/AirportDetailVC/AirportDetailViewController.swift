//
//  AirportDetailViewController.swift
//  Airports
//
//  Created by Tobias Termeczky@hotmail.com on 18/10/2017.
//  Copyright © 2017 Tobias Termeczky@hotmail.com. All rights reserved.
//

import UIKit

class AirportDetailViewController: UIViewController {

    @IBOutlet weak var icao: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var elevation: UILabel!
    @IBOutlet weak var iso_country: UILabel!
    @IBOutlet weak var municipality: UILabel!
    @IBOutlet weak var dinstance: UILabel!
    
    var airport: Airport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.icao.text = airport.icao
        self.name.text = airport.name
        self.longitude.text = String(format:"%f", airport.longitude)
        self.latitude.text = String(format:"%f", airport.latitude)
        self.elevation.text = String(format:"%f", airport.elevation)
        self.iso_country.text = airport.iso_country
        self.municipality.text = airport.municipality
        self.dinstance.text = "added code here"
        self.title = airport.name
    }
    
    func customInit (airport: Airport){
        self.airport = airport
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
