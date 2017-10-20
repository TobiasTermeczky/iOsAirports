//
//  VCMapView.swift
//  Airports
//
//  Created by Tobias Termeczky@hotmail.com on 20/10/2017.
//  Copyright © 2017 Tobias Termeczky@hotmail.com. All rights reserved.
//

import Foundation
import MapKit

extension AirportDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
    
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.alpha = 0.5
        if overlay as? MKPolyline ==  geodesicPolyline {
        renderer.strokeColor = UIColor.blue
        } else {
            renderer.strokeColor = UIColor.red
        }
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let planeIdentifier = "Plane"
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: planeIdentifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: planeIdentifier)
        
        annotationView.image = UIImage(named: "airplane")
        
        return annotationView
    }
    
}
