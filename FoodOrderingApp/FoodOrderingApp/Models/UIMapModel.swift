//
//  MapModel.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 4/3/23.
//

import Foundation
import SwiftUI
import MapKit


struct mapView: UIViewRepresentable {
    
    @EnvironmentObject var mapAPI: MapAPI
    @Binding var userLocation: CLLocationCoordinate2D
    
    
    func makeCoordinator() -> Coordinator {
        return mapView.Coordinator()
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()
        
        let exampleRestaurantLocation = CLLocationCoordinate2D(latitude: 41.884930, longitude: -87.632940)
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: exampleRestaurantLocation, span: span)
        
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = exampleRestaurantLocation
        sourcePin.title = "Little Lemon Example"
        map.addAnnotation(sourcePin)
        
        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = userLocation
        destinationPin.title = "My Address"
        map.addAnnotation(destinationPin)
        
        map.region = region
        map.delegate = context.coordinator
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: exampleRestaurantLocation))
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        
        
        let directions = MKDirections(request: req)
        
        directions.calculate { (direct, error) in
            
            if error != nil {
                print("There was an error: \((error?.localizedDescription)!)")
                return
            }
            
            for route in direct!.routes {
                
                mapAPI.time = 0
                
                let eta = route.expectedTravelTime // time in seconds
                mapAPI.time = eta
                
                mapAPI.distance = 0
                
                let distance = route.distance // distance in meters
                mapAPI.distance = distance
            }
            
            let polilyne = direct?.routes.first?.polyline
            
            map.addOverlay(polilyne!)
            map.setRegion(MKCoordinateRegion(polilyne!.boundingMapRect), animated: true)
            map.showAnnotations([sourcePin , destinationPin], animated: true)
        }
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 3
            
            return render
            
        }
    }
    
}
