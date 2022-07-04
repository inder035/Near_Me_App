//
//  NearbyListVM.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation

class NearbyListVM{
    static let sheard = NearbyListVM()
    var controller : NearbyListVC?
    
    func callNearbyListApi(_ latitude: Double, longitude: Double){
        let url = Map_Base_URL + ApiPath.nearby + "?location=\(latitude),\(longitude)&radius=500&key=" + Google_Api_Key
        ApiManager.shared.requestApi(method: .get, url: url, parameters: nil, isLoader: true, type: PlaceListModel.self) { model in
            if let list = model.results{
                self.controller?.objList = list
                self.controller?.listTable.reloadData()
            }
        } onFailure: { status, code, str in
            AlertManager.sheard.showAlert(code, str)
        }
    }
}
