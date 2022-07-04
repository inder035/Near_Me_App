//
//  UIImageExtension.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation
import SDWebImage


extension UIImageView{
    func getPlaceImage(ref: String, height: Double, width: Double, placeholderImage:UIImage?) {
        let activity = SDWebImageActivityIndicator.gray
        activity.indicatorView.color = .themeColor()
        self.sd_imageIndicator = activity
        let imageUrl = Map_Base_URL + ApiPath.placePhoto + "?photoreference=\(ref)&sensor=false&maxheight=\(Int(height))&maxwidth=\(Int(width))&key=\(Google_Api_Key)"
        debugPrint("ImageURL: ",imageUrl)
        self.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholderImage)
    }
}
