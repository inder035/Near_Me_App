//
//  Location Manager.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//


import UIKit
import GoogleMaps

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var locationCallback : ((_ cordinate: CLLocationCoordinate2D) -> ())?
        
    static let shared: LocationManager = {
        let locationShareInstance = LocationManager()
        return locationShareInstance
    }()
    
    func checkAuthorizationStatus() -> Bool {
        return generateAlertToNotifyUser()
    }
    
    func startStandardUpdates(_ callback: @escaping ((_ cordinate: CLLocationCoordinate2D) -> ())) {
        locationCallback = callback
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func stopStandardUpdate() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    //MARK:- Location Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("----Location Fetched------ %@",locations.count)
        if let location = locations.last{
            self.locationCallback?(location.coordinate)
            locationManager.stopUpdatingLocation()
        }        
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        switch status {
        case CLAuthorizationStatus.restricted:
            debugPrint("Restricted Access to location")
        case CLAuthorizationStatus.denied:
            debugPrint("User denied access to location")
        case CLAuthorizationStatus.notDetermined:
            debugPrint("Status not determined")
        default:
            debugPrint("Allowed to location Access")
            shouldIAllow = true
        }
        
        if (shouldIAllow == true) {
            debugPrint("Location to Allowed")
            locationManager.startUpdatingLocation()
        } else {
            debugPrint("Denied access: ")
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
           let _ = self.generateAlertToNotifyUser()
        }
    }
    
    func generateAlertToNotifyUser() -> Bool {
        var message = String()
        if CLLocationManager.authorizationStatus() == .notDetermined {
            message = "Location Services are not able to determine your location"
            return false
        } else if CLLocationManager.authorizationStatus() == .denied {
            message = "To update your location, you must turn on Location Services from Settings"
            self.openSettingsAppWith(message)
            return false
        }else if CLLocationManager.authorizationStatus() == .restricted {
            message = "To update your location, you must turn on Location Services from Settings"
            self.openSettingsAppWith(message)
            return false
        }else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
            return true
        }
        return true
    }
    
    func openSettingsAppWith(_ mesge: String) {
        let settingAlert = UIAlertController(title: "Locations Alert", message: mesge, preferredStyle: UIAlertController.Style.alert)
        let openSetting = UIAlertAction(title:"Settings", style:UIAlertAction.Style.default, handler:{ (action: UIAlertAction!) in
            let url:URL = URL(string: UIApplication.openSettingsURLString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in })
            } else {
                UIApplication.shared.openURL(url)
            }
        })
        settingAlert.addAction(openSetting)
        let controller = UIApplication.visibleViewController
        controller?.present(settingAlert, animated: true, completion: nil)
    }
}


//extension UIViewController{
//    //    MARK:- Get Address From Coordinates
//    func getPlaceFrom(location: CLLocationCoordinate2D, completion: @escaping (_ address: String) -> Void) {
//        GMSGeocoder().reverseGeocodeCoordinate(location) { response, error in
//            if error != nil {
//                debugPrint("reverse geodcode fail: \(error!.localizedDescription)")
//            } else {
//                guard let places = response?.results(), let place = places.first, let lines = place.lines else {
//                    completion("No Address Found")
//                    return
//                }
//                completion(lines.joined(separator: ","))
//            }
//        }
//    }
//
//    func getLocalityAddressFrom(location: CLLocationCoordinate2D, completion: @escaping (_ fullAddress: String, _ country: String, _ state: String, _ city: String, _ code: String) -> Void) {
//        let geocoder = GMSGeocoder()
//        geocoder.reverseGeocodeCoordinate(location) { response, error in
//            if error != nil {
//                debugPrint("reverse geodcode fail: \(error!.localizedDescription)")
//            } else {
//                guard let places = response?.results(), let _ = places.first else {
//                        completion("","","","","")
//                        return
//                }
//                //let placeData = places.first?.lines?.joined(separator: ", ")
//                var thoroughfare = places.first?.thoroughfare ?? ""
//                if thoroughfare.isEmpty{
//                    thoroughfare = places.first?.subLocality ?? ""
//                }
//                completion(thoroughfare, places.first?.country ?? "", places.first?.administrativeArea ?? "", places.first?.locality ?? "", places.first?.postalCode ?? "")
//            }
//        }
//    }
//}
