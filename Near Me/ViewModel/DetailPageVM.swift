//
//  DetailPageVM.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation

class DetailPageVM{
    static let sheard = DetailPageVM()
    var controller : DetailPageVC?
    
    func callPlaceDetailApi(_ placeID: String){
        let url = Map_Base_URL + ApiPath.placeDetail + "?place_id=\(placeID)&key=" + Google_Api_Key
        ApiManager.shared.requestApi(method: .post, url: url, parameters: nil, isLoader: true, type: PlaceDetailModel.self) { model in
            self.controller?.objData = model.result
            self.controller?.setupData()
        } onFailure: { status, code, str in
            AlertManager.sheard.showAlert(code, str)
        }
    }
}
