//
//  LGMapViewController.swift
//  LGWeChatKit
//
//  Created by jamy on 10/29/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import MapKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


protocol LGMapViewControllerDelegate {
    func mapViewController(_ controller: LGMapViewController, didSelectLocationSnapeShort image: UIImage)
    func mapViewController(_ controller: LGMapViewController, didCancel error: NSError?)
}

class LGMapViewController: UIViewController {

    var tableView: UITableView!
    var mapView: MKMapView!
    var geocoder: CLGeocoder!
    var localSearch: MKLocalSearch!
    var myAnnotation: placeAnnotation!
    var locationManager: CLLocationManager!
    
    var mapItems = [MKMapItem]()
    
    var selectMapItem: MKMapItem?
    var delegate: LGMapViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIndentifier)
        
        mapView = MKMapView()
        
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        view.addSubview(tableView)
        view.addSubview(mapView)
        // Do any additional setup after loading the view.
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 64))
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: -32))
        
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1, constant: 0))
        
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
        myAnnotation = placeAnnotation(coordinate: CLLocationCoordinate2DMake(31.203694, 121.545212), title: "", subtitle: "")
        mapView.addAnnotation(myAnnotation)
        
        geocoder = CLGeocoder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(LGMapViewController.dismissView))
        self.navigationItem.leftBarButtonItem = item
        
        let send = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(LGMapViewController.send))
        self.navigationItem.rightBarButtonItem = send
    }
    
    func dismissView() {
        self.delegate?.mapViewController(self, didCancel: nil)
        self.dismiss(animated: true, completion: nil)
    }

    
    func send() {
        let option = MKMapSnapshotOptions()
        if mapItems.count > 0 {
            if selectMapItem != nil {
                option.region.center = (selectMapItem?.placemark.coordinate)!
            } else {
                option.region.center = ((mapItems.first! as MKMapItem).placemark.coordinate)
            }
            option.region = mapView.region
        }
        let snape = MKMapSnapshotter(options: option)
        snape.start (completionHandler: { (snapeShort, error) -> Void in
            if error == nil {
                self.delegate?.mapViewController(self, didSelectLocationSnapeShort: (snapeShort?.image)!)
                self.dismissView()
            }
        })
    }
}

private let reuseIndentifier = "mapViewCell"
extension LGMapViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath)
        
        let mapItem = mapItems[indexPath.row]
        cell.textLabel?.text = mapItem.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let mapItem = mapItems[indexPath.row]
        let placeMark = mapItem.placemark
        selectMapItem = mapItem
        mapView.setCenter(placeMark.coordinate, animated: true)
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}


extension LGMapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("get location")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKPinAnnotationView?
        if annotation .isKind(of: placeAnnotation.self) {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                annotationView!.animatesDrop = true
                annotationView!.canShowCallout = true
            }
            return annotationView!
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let point = CGPoint(x: mapView.center.x, y: mapView.center.y - 64)
        let centerCoordinate = mapView.convert(point, toCoordinateFrom: mapView)
        mapView.removeAnnotation(myAnnotation)
        myAnnotation = placeAnnotation(coordinate: centerCoordinate, title: "", subtitle: "")
        mapView.addAnnotation(myAnnotation)
        
        let location = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) -> Void in
            if placeMarks?.count > 0 {
                self.startSearch(centerCoordinate, name: (placeMarks?.first?.name)!)
            }
        }
    }
    
    func startSearch(_ coordinate: CLLocationCoordinate2D, name: String) {
        if localSearch != nil {
            if localSearch.isSearching {
                localSearch.cancel()
            }
        }
        
        let span = MKCoordinateSpanMake(0.412872, 0.709862)
        let newRegion = MKCoordinateRegion(center: coordinate, span: span)
        let request = MKLocalSearchRequest()
        request.region = newRegion
        request.naturalLanguageQuery = name
        let complectionHandle: MKLocalSearchCompletionHandler = { (response, error) -> Void in
            if error == nil {
                for mapitem in (response?.mapItems)! {
                    NSLog("%@", mapitem.name!)
                }
                self.mapItems = (response?.mapItems)!
                self.tableView.reloadData()
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        if localSearch != nil {
            localSearch = nil
        }
        localSearch = MKLocalSearch(request: request)
        localSearch.start(completionHandler: complectionHandle)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}


