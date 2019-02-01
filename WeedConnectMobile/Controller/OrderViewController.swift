//
//  OrderViewController.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/18/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

class OrderViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var tbvProducts: UITableView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var lbStatus: UILabel!
    
    var tray = [JSON]()
    
    var destination: MKPlacemark?
    var source: MKPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        getLatestOrder()

    }
    
    func getLatestOrder() {
        
        APIManager.shared.getlatestOrder { (json) in
            
            print(json)
            
            let order = json["order"]
            
            if let orderDetails = order["order"]["order_details"].array {
                
                self.lbStatus.text = order["status"].string!.uppercased()
                self.tray = orderDetails
                self.tbvProducts.reloadData()
            }
            
            let from = order["dispensary"]["address"].string!
            let to = order["address"].string!
            
            self.getLocation(from, "Dispensary", { (sou) in
                self.source = sou
                
                self.getLocation(to, "Customer", { (des) in
                    self.destination = des
                    self.getDirection()
                })
            })
        }
    }
    
}

extension OrderViewController: MKMapViewDelegate {
    
    // # 1 - Delegate method of MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    // # 2 - Convert an address string to a location on the map
    func getLocation(_ address: String,_ title: String,_ completionHandler: @escaping (MKPlacemark) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            if (error != nil) {
                print("Error: ", error)
            }
            
            if let placemark = placemarks?.first {
                
                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                
                // Create a pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = coordinates
                dropPin.title = title
                
                self.map.addAnnotation(dropPin)
                completionHandler(MKPlacemark.init(placemark: placemark))
            }
        }
    }
    
    // # 3 - Get direction and zoom to address
    func getDirection() {
        
        let request = MKDirections.Request()
        request.source = MKMapItem.init(placemark: source!)
        request.destination = MKMapItem.init(placemark: destination!)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            
            if error != nil {
                print("Error: ", error)
            } else {
                // Show route
                self.showRoute(response: response!)
            }
        }
        
    }
    
    // # 4 - Show route between locations and make a visible zoom
    func showRoute(response: MKDirections.Response) {
        
        for route in response.routes {
            self.map.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
        
        var zoomRect = MKMapRect.null
        for annotation in self.map.annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(pointRect)
        }
        
        
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderViewCell
        
        let item = tray[indexPath.row]
        cell.lbQty.text = String(item["quantity"].int!)
        cell.lbProductName.text = item["product"]["name"].string
        cell.lbSubTotal.text = "$\(String(item["sub_total"].float!))"
        
        
        return cell
    }
}
