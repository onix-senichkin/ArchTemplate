//
//  UserLocationService.swift
//  ArchitectureTemplate
//
//  Created by Denis Senichkin on 10/29/18.
//  Copyright © 2018 Denis Senichkin. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserLocationServiceType: Service {
    
    //callback
    var callBackUserAddressWasChanged: SimpleClosure<String>? { get set }
    
    //getters
    var userLocation: CLLocationCoordinate2D? { get }
    var userAddress: String? { get }
    
}

class UserLocationService: NSObject, UserLocationServiceType {

    private var locationManager: CLLocationManager?
    private var lastUserLocation: CLLocationCoordinate2D?
    private var lastUserAddress: String?

    var callBackUserAddressWasChanged: SimpleClosure<String>?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter =  kCLDistanceFilterNone
        locationManager?.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.locationManager?.requestWhenInUseAuthorization()
            }
        } else {
            locationManager?.startUpdatingLocation()
        }
    }
    
    deinit {
        print("UserLocationService deinit")
    }
}

//MARK:- Getters
extension UserLocationService {
    
    var userLocation: CLLocationCoordinate2D? {
        return lastUserLocation
    }
    
    var userAddress: String? {
        return lastUserAddress ?? "n/a"
    }
}

//MARK:- CLLocationManagerDelegate
extension UserLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("locationManager didUpdateLocations to \(String(describing: locations.last))")
        lastUserLocation = locations.last?.coordinate
        updateUserAddress(locations.last)
        
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AlertHelper.showAlert(msg: error.localizedDescription)
    }
}

//MARK:- Address routine
extension UserLocationService {
    
    private func updateUserAddress(_ location: CLLocation?) {
        guard let location = location else { return }

        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (places, error) in
            if let place = places?.first {
                if let address = self?.makeAddressString(place: place) {
                    self?.lastUserAddress = address
                    self?.callBackUserAddressWasChanged?(address)
                    //print("reverseGeocodeLocation address \(address)")
                }
            }
        }
    }
    
    private func makeAddressString(place: CLPlacemark) -> String {
        let items = [place.country, place.locality, place.thoroughfare, place.subThoroughfare].compactMap( { $0 })
        //print("makeAddressString \(items)")
        let address = items.joined(separator: ", ")
        return address
    }
}
