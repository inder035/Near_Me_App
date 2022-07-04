//
//  ViewController.swift
//  Near Me
//
//  Created by Inder Singh on 25/06/22.
//

import UIKit
import GoogleMaps

class HomeVC: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var vwError: UIView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnMapType: UIButton!
    
    //    MARK: - Variabels
    var objLatitude : Double = 0
    var objLongitude : Double = 0
    var objData : ResultModel?
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkNetworkConnection()
    }
    
    //    MARK: - Button Actions
    @IBAction func searchBtnAtn(_ sender: Any) {
        let vc = MapSearchVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func locationBtnAtn(_ sender: Any) {
        LocationManager.shared.startStandardUpdates { cordinate in
            self.objLatitude = cordinate.latitude
            self.objLongitude = cordinate.longitude
            let position = CLLocationCoordinate2D(latitude: self.objLatitude , longitude: self.objLongitude)
            self.vwMap.animate(toLocation: position)
        }
    }
    
    @IBAction func mapTypeBtnAtn(_ sender: Any) {
    }
    
    @IBAction func listNearBtnAtn(_ sender: Any) {
        let vc = NearbyListVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.objLatitude = self.objLatitude
        vc.objLongitude = self.objLongitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//    MARK: - Methods
extension HomeVC{
    func setupData(){
        self.vwMap.delegate = self
        self.vwMap.isMyLocationEnabled = true
        LocationManager.shared.startStandardUpdates { cordinate in
            self.objLatitude = cordinate.latitude
            self.objLongitude = cordinate.longitude
            let position = GMSCameraPosition(latitude:  self.objLatitude, longitude: self.objLongitude, zoom: 14)
            self.vwMap.camera = position
        }
    }
    
    func checkNetworkConnection(){
        self.vwError.isHidden = ApiManager.shared.isConnectedToInternet()
    }
}

//    MARK: - Place Methods
extension HomeVC : PlaceSearchDelegate, GMSMapViewDelegate{
    func didSelectAddress(_ result: ResultModel) {
        self.objData = result
        self.lblSearch.text = result.name ?? ""
        self.objLatitude = result.geometry?.location?.lat ?? 0
        self.objLongitude = result.geometry?.location?.lng ?? 0
        let position = CLLocationCoordinate2D(latitude: self.objLatitude, longitude: self.objLongitude)
        let marker = GMSMarker(position: position)
        marker.title = result.name ?? ""
        marker.map = self.vwMap
        self.vwMap.animate(toLocation: position)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let vc = DetailPageVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.objID = self.objData?.place_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        return true
    }
}
