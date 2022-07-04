//
//  NearbyListVC.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import UIKit

class NearbyListVC: UIViewController {

    //    MARK: - Outlets
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var listTable: UITableView!
    
    //    MARK: - Variabels
    let Nearby_Cell = "NearbyTVC"
    let objVM = NearbyListVM.sheard
    var objLatitude : Double = 0
    var objLongitude : Double = 0
    var objList = [ResultModel]()
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    //    MARK: - Button Actions
    @IBAction func backBtnAtn(_ sender: Any) {
        self.popToViewController()
    }
    @IBAction func searchBtnAtn(_ sender: Any) {
        let vc = MapSearchVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//    MARK: - Methods
extension NearbyListVC{
    func setupData(){
        self.objVM.controller = self
        self.objVM.callNearbyListApi(self.objLatitude, longitude: self.objLongitude)
    }
}

//    MARK: - Place AutoComplete Methods
extension NearbyListVC : PlaceSearchDelegate{
    func didSelectAddress(_ result: ResultModel) {
        self.searchTF.text = result.name ?? ""
        self.objLatitude = result.geometry?.location?.lat ?? 0
        self.objLongitude = result.geometry?.location?.lng ?? 0
        self.objVM.callNearbyListApi(self.objLatitude, longitude: self.objLongitude)
    }
}


//    MARK: - Table Methods
extension NearbyListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nearby_Cell) as! NearbyTVC
        cell.setupData(self, data: self.objList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}
