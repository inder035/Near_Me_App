//
//  NearbyTVC.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import UIKit

class NearbyTVC: UITableViewCell {

//    MARK:- Outlets
    @IBOutlet weak var vwImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    //    MARK:- Variables
    var detailAtn : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func detailBtnAtn(_ sender: Any) {
        self.detailAtn?()
    }
    
    func setupData(_ controller: NearbyListVC, data: ResultModel){
        let ref = data.photos?.first?.photo_reference ?? ""
        let placeImg = UIImage(named: "Placeholder_Image")
        self.vwImage.getPlaceImage(ref: ref, height: 400, width: 400, placeholderImage: placeImg)
        self.lblName.text = data.name ?? ""
        self.lblLocation.text = data.vicinity ?? ""
        if data.opening_hours?.open_now ?? false{
            self.lblStatus.text = "Open"
            self.lblStatus.textColor = .green
        }else{
            self.lblStatus.text = "Closed"
            self.lblStatus.textColor = .red
        }
        
        self.detailAtn = {
            let vc = DetailPageVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            vc.objID = data.place_id ?? ""
            controller.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
