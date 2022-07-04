//
//  ImageCVC.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import UIKit

class ImageCVC: UICollectionViewCell {
    @IBOutlet weak var vwImage: UIImageView!
    
    func setupData(data: Photos_List?){
        let ref = data?.photo_reference ?? ""
        let height = data?.height ?? 0
        let width = data?.width ?? 0
        let placeImg = UIImage(named: "Placeholder_Image")
        self.vwImage.getPlaceImage(ref: ref, height: height, width: width, placeholderImage: placeImg)
    }
}
