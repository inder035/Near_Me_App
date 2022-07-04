//
//  APIManager.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import UIKit
import Alamofire

class ApiManager: NSObject {
    static let shared = ApiManager()
    
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func headerParam() -> HTTPHeaders {
        var headerParam = HTTPHeaders()
        headerParam["Content-Type"] = "application/json"
        return headerParam
    }
    
//    MARK: - Data Api
    func requestApi<T:Codable>(method: HTTPMethod, url: String, parameters: [String:Any]?, isLoader: Bool, type: T.Type, onSuccess:@escaping (T)->(), onFailure: @escaping (Bool, String, String)->()){
        if isConnectedToInternet() {
            let urlString = url
            debugPrint("")
            debugPrint("**********************************************")
            debugPrint("url is ------------->>> \(urlString)")
            debugPrint("header is ------->>> \(headerParam())")
            debugPrint("param is -------->>> \(parameters ?? ["":""])")
            debugPrint("**********************************************")

            if isLoader{
                Indicator.shared.start()
            }
            
            AF.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headerParam()).response { response in
                if isLoader{
                    Indicator.shared.stop()
                }
                switch response.result{
                case .success(_):
                    if let responseData = response.data{
                        let statusCode = response.response?.statusCode ?? 0
                        self.handleResponse(responseData: responseData, statusCode: statusCode, type: type) { model in
                            onSuccess(model)
                        } onFailure: { status, title, errorString in
                            onFailure( status, title, errorString)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    switch error{
                    case .sessionTaskFailed(error: let error):
                        debugPrint("Sesion Failed", error.localizedDescription )
                        onFailure(false, "Error", error.localizedDescription)
                    default:
                        debugPrint("API Failure", error.localizedDescription)
                        onFailure(false, "Error", error.localizedDescription)
                    }
                }
            }
        } else {
            onFailure(false, "Error", "No Internet Connection")
        }
    }
    
//    MARK: - Upload Media Api
    func uploadImageApi<T:Codable>(method: HTTPMethod, url: String, image:URL?, imageKey:String, isLoader: Bool, type: T.Type, onSuccess:@escaping (T)->(), onFailure: @escaping (Bool, String, String)->()){
        if isConnectedToInternet() {
            let urlString = url
            let imageExt = image?.pathExtension ?? ""
            let nameDate : Int = Int((Date().timeIntervalSince1970 * 1000).rounded())
            let fileName = "Image_\(nameDate).\(imageExt)"
            debugPrint("")
            debugPrint("**********************************************")
            debugPrint("url is ------------->>> \(urlString)")
            debugPrint("header is ------->>> \(headerParam())")
            debugPrint("param is -------->>> \(imageKey):\(fileName)")
            debugPrint("**********************************************")
            if isLoader{
                Indicator.shared.start()
            }
            AF.upload(multipartFormData: { multipartFormData in
                if let imageURL = image{
                    if let imageData = try? Data(contentsOf: imageURL){
                        multipartFormData.append(imageData, withName: imageKey, fileName: fileName, mimeType: "image/jpeg")
                    }
                }
            }, to: urlString, method: .post, headers: headerParam()).response { response in
                if isLoader{
                    Indicator.shared.stop()
                }
                switch response.result{
                case .success(_):
                    if let responseData = response.data{
                        let statusCode = response.response?.statusCode ?? 0
                        self.handleResponse(responseData: responseData, statusCode: statusCode, type: type) { model in
                            onSuccess(model)
                        } onFailure: {  status, title, errorString in
                            onFailure( status, title, errorString )
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    switch error{
                    case .sessionTaskFailed(error: let error):
                        debugPrint("Sesion Failed", error.localizedDescription )
                        onFailure(false, "Error", error.localizedDescription)
                    default:
                        debugPrint("API Failure", error.localizedDescription)
                        onFailure(false, "Error", error.localizedDescription)
                    }
                }
            }
        } else {
            onFailure(false, "Error", "No Internet Connection")
        }
    }
}

extension ApiManager{
    func handleResponse<T:Codable>(responseData: Data, statusCode: Int, type: T.Type, onSuccess:@escaping (T)->(), onFailure: @escaping (Bool, String, String)->()){
        let response = responseData.dataToJson()
        let errorString = response["error_description"] as? String ?? ""
        debugPrint("Response:", response)
        switch statusCode {
        case 200:
            do{
                let json = try JSONDecoder().decode(T.self, from: responseData)
                onSuccess(json)
            } catch let error as NSError {
                debugPrint(error.userInfo)
                onFailure(false, "Error", error.userInfo.debugDescription)
            }
        case 400:
            debugPrint("Bad Request")
            let toastTitle = "\(statusCode) : Bad Request"
            onFailure(false, toastTitle, errorString)
        case 401:
            debugPrint("Unauthorized")
            let toastTitle = "\(statusCode) : Unauthorized"
            onFailure(false, toastTitle, errorString)
        case 404:
            debugPrint("Server Not Found")
            let toastTitle = "\(statusCode) : Server Not Found"
            onFailure(false, toastTitle, errorString)
        case 500, 503:
            debugPrint("Server Error")
            let toastTitle = "\(statusCode) : Server Error"
            onFailure(false, toastTitle, errorString)
        default:
            debugPrint(errorString)
            onFailure(false, "Error", errorString)
        }
    }
}

extension Data {
    func dataToJson() -> [String:Any]{
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
            return json ?? [:]
        } catch let error as NSError {
            print(error.userInfo)
            return [:]
        }
    }
}
