//
//  MapSearchVM.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation

class MapSearchVM{
    static let sheard = MapSearchVM()
    var controller : MapSearchVC?
    
    func callSearchApi(_ text: String){
        let textUrl = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = Map_Base_URL + ApiPath.place + "?input=\(textUrl)&key=" + Google_Api_Key
        ApiManager.shared.requestApi(method: .get, url: url, parameters: nil, isLoader: false, type: PlaceModel.self) { model in
            self.controller?.objList = model.predictions ?? []
            self.controller?.searchTable.reloadData()
        } onFailure: { status, code, str in
            AlertManager.sheard.showAlert(code, str)
        }
    }
    
    func callPlaceDetailApi(_ placeID: String, onSuccess:@escaping (ResultModel)->()){
        let url = Map_Base_URL + ApiPath.placeDetail + "?place_id=\(placeID)&key=" + Google_Api_Key
        ApiManager.shared.requestApi(method: .post, url: url, parameters: nil, isLoader: false, type: PlaceDetailModel.self) { model in
            if let result = model.result{
                onSuccess(result)
            }
        } onFailure: { status, code, str in
            AlertManager.sheard.showAlert(code, str)
        }
    }
}
