//
//  AirportDetailViewController.swift
//  Airports
//
//  Created by Tobias Termeczky@hotmail.com on 18/10/2017.
//  Copyright © 2017 Tobias Termeczky@hotmail.com. All rights reserved.
//

import UIKit
import MapKit

class AirportDetailViewController: UIViewController {

    @IBOutlet weak var icao: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var elevation: UILabel!
    @IBOutlet weak var iso_country: UILabel!
    @IBOutlet weak var municipality: UILabel!
    @IBOutlet weak var dinstance: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var polyline: MKPolyline!
    var geodesicPolyline: MKGeodesicPolyline!
    
    var airport: Airport!
    var schiphol: Airport!
    
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
        
        self.title = airport.name
        mapView.delegate = self
        
        let sourceLocation = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
        let destinationLocation = CLLocation(latitude: schiphol.latitude, longitude: schiphol.longitude)
        
        let distanceInMeters = destinationLocation.distance(from: sourceLocation)
        self.dinstance.text = "\((distanceInMeters / 1000).rounded()) " + "KM"
        
        let regionRadius: CLLocationDistance = distanceInMeters
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }

        centerMapOnLocation(location: sourceLocation)

        let avgLat = (destinationLocation.coordinate.latitude + sourceLocation.coordinate.latitude)/2
        let avglon = (destinationLocation.coordinate.longitude + sourceLocation.coordinate.longitude)/2

        let avgcoor = CLLocationCoordinate2D(latitude: avgLat, longitude: avglon);

        mapView.setCenter(avgcoor, animated: true)
        
        var coordinates = [destinationLocation.coordinate, sourceLocation.coordinate]
        geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: coordinates.count)
        polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        mapView.add(polyline)
        mapView.add(geodesicPolyline)
    }
    
    func customInit (airport: Airport, schiphol: Airport){
        self.airport = airport
        self.schiphol = schiphol
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
