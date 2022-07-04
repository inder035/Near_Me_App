//
//  MapSearchVC.swift
//  Near Me
//
//  Created by Inder Singh on 25/06/22.
//

import UIKit

protocol PlaceSearchDelegate{
    func didSelectAddress(_ result: ResultModel)
}

class MapSearchVC: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    
    //    MARK: - Variabels
    let Map_Cell = "MapSearchTVC"
    let objVM = MapSearchVM.sheard
    var delegate: PlaceSearchDelegate?
    var objList = [Predictions]()
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    //    MARK: - Button Actions
    @IBAction func backBtnAtn(_ sender: Any) {
        self.popToViewController()
    }
    
    @IBAction func editTextTFAtn(_ sender: UITextField) {
        self.objVM.callSearchApi(self.searchTF.text ?? "")
    }
}

//    MARK: - Methods
extension MapSearchVC{
    func setupData(){
        self.searchTF.becomeFirstResponder()
        self.objVM.controller = self
    }
}

//    MARK: - Table Methods
extension MapSearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Map_Cell) as! MapSearchTVC
        cell.lblLocation.text = self.objList[indexPath.row].description ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.objVM.callPlaceDetailApi(self.objList[indexPath.row].place_id ?? "") { model in
            self.delegate?.didSelectAddress(model)
            self.popToViewController()
        }
    }
}
