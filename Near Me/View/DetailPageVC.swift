//
//  DetailPageVC.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import UIKit
import GoogleMaps

class DetailPageVC: UIViewController {

    //    MARK: - Outlets
    @IBOutlet weak var vwScroll: UIScrollView!
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var vwImages: UIView!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var vwDetail: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var stackDetail: UIStackView!
    @IBOutlet weak var vwPhone: UIView!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var vwWeb: UIView!
    @IBOutlet weak var lblWeb: UILabel!
    @IBOutlet weak var vwTimeSlot: UIView!
    @IBOutlet weak var lblModay: UILabel!
    @IBOutlet weak var lblTuesday: UILabel!
    @IBOutlet weak var lblWednesday: UILabel!
    @IBOutlet weak var lblThursday: UILabel!
    @IBOutlet weak var lblFriday: UILabel!
    @IBOutlet weak var lblSaturday: UILabel!
    @IBOutlet weak var lblSunday: UILabel!
    @IBOutlet weak var vwConatinerMap: UIView!
    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var vwReview: UIView!
    @IBOutlet weak var lblNoReview: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblReviewCount: UILabel!
    @IBOutlet weak var vwReviewData: UIView!
    
    
    //    MARK: - Variabels
    let Image_Cell = "ImageCVC"
    let objVM = DetailPageVM.sheard
    var objID = String()
    var objData : ResultModel?
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callDetailApi()
    }
    
    //    MARK: - Button Actions
    @IBAction func backBtnAtn(_ sender: Any) {
        self.popToViewController()
    }
    
    @IBAction func mapBtnAtn(_ sender: UITextField) {
        self.openWebPage(url: self.objData?.url ?? "")
    }
    
    @IBAction func phoneBtnAtn(_ sender: Any) {
        self.callMethod(number: self.objData?.international_phone_number ?? "")
    }
    
    @IBAction func websiteBtnAtn(_ sender: Any) {
        self.openWebPage(url: self.objData?.website ?? "")
    }
}

//    MARK: - Methods
extension DetailPageVC{
    func callDetailApi(){
        self.vwScroll.delegate = self
        self.objVM.controller = self
        self.vwScroll.isHidden = true
        self.objVM.callPlaceDetailApi(self.objID)
    }
    
    func setupData(){
        guard let place = self.objData else { return }
        self.lblTitle.text = place.name ?? ""
        self.lblAddress.text = place.formatted_address ?? ""
        self.lblPhone.text = place.international_phone_number ?? ""
        self.lblWeb.text = place.website ?? ""
        self.stackDetail.isHidden = true
        self.vwPhone.isHidden = true
        self.vwWeb.isHidden = true
    
        if !(place.international_phone_number?.isEmpty ?? true){
            self.stackDetail.isHidden = false
            self.vwPhone.isHidden = false
        }
        if !(place.website?.isEmpty ?? true){
            self.stackDetail.isHidden = false
            self.vwWeb.isHidden = false
        }
        
        let slot = [self.lblModay, self.lblTuesday, self.lblWednesday, self.lblThursday, self.lblFriday, self.lblSaturday, self.lblSunday ]
        if let timeSlot = place.opening_hours?.weekday_text{
            self.vwTimeSlot.isHidden = false
            for (key, value) in timeSlot.enumerated() {
                slot[key]?.text = value
            }
        }else{
            self.vwTimeSlot.isHidden = true
        }
        
        let latitude = place.geometry?.location?.lat ?? 0.0
        let longitude = place.geometry?.location?.lng ?? 0.0
        let position = GMSCameraPosition(latitude:  latitude, longitude: longitude, zoom: 12)
        self.vwMap.camera = position
        
        self.lblReview.text = String(format: "%.1f", (place.rating ?? 0)) + " Rating"
        self.lblReviewCount.text = "Review by \(place.user_ratings_total ?? 0) persons"
        if place.reviews?.isEmpty ?? true{
            self.lblNoReview.isHidden = false
            self.vwReviewData.isHidden = true
        }else{
            self.lblNoReview.isHidden = true
            self.vwReviewData.isHidden = false
        }
        self.imagesCollection.reloadData()
        self.vwScroll.isHidden = false
    }
}

extension DetailPageVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.vwScroll{
            if scrollView.contentOffset.y > 400{
                self.vwBack.backgroundColor = .themeWhite()
            }else{
                self.vwBack.backgroundColor = .themeWhite().withAlphaComponent(scrollView.contentOffset.y/200)
            }
        }
    }
}

//    MARK: - Collection Methods
extension DetailPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objData?.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: Image_Cell, for: indexPath) as! ImageCVC
        item.setupData(data: self.objData?.photos?[indexPath.item])
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.vwImages.bounds.height)
    }
}


