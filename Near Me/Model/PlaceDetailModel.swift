//
//  PlaceDetailModel.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation

class PlaceListModel : Codable {
    var results : [ResultModel]?
    var status : String?
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case status = "status"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([ResultModel].self, forKey: .results)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
class PlaceDetailModel : Codable {
    var result : ResultModel?
    var status : String?
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case status = "status"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResultModel.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

class ResultModel : Codable {
    var address_components : [Address_Components]?
    var business_status : String?
    var formatted_address: String?
    var formatted_phone_number : String?
    var geometry: Geometry?
    var opening_hours : Opening_Hours?
    var icon : String?
    var icon_background_color : String?
    var icon_mask_base_uri : String?
    var international_phone_number : String?
    var website : String?
    var photos : [Photos_List]?
    var plus_code : Plus_Code?
    var name : String?
    var place_id : String?
    var rating : Double?
    var reference : String?
    var reviews: [Reviews]?
    var url : String?
    var user_ratings_total : Int?
    var utc_offset : Int?
    var vicinity : String?
    var types : [String]?
    enum CodingKeys: String, CodingKey {
        case address_components = "address_components"
        case business_status = "business_status"
        case formatted_address = "formatted_address"
        case formatted_phone_number = "formatted_phone_number"
        case icon = "icon"
        case icon_background_color = "icon_background_color"
        case icon_mask_base_uri = "icon_mask_base_uri"
        case international_phone_number = "international_phone_number"
        case website = "website"
        case geometry = "geometry"
        case opening_hours = "opening_hours"
        case name = "name"
        case place_id = "place_id"
        case rating = "rating"
        case reference = "reference"
        case plus_code = "plus_code"
        case photos = "photos"
        case url = "url"
        case user_ratings_total = "user_ratings_total"
        case utc_offset = "utc_offset"
        case vicinity = "vicinity"
        case types = "types"
        case reviews = "reviews"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address_components = try values.decodeIfPresent([Address_Components].self, forKey: .address_components)
        business_status = try values.decodeIfPresent(String.self, forKey: .business_status)
        formatted_address = try values.decodeIfPresent(String.self, forKey: .formatted_address)
        formatted_phone_number = try values.decodeIfPresent(String.self, forKey: .formatted_phone_number)
        icon_background_color = try values.decodeIfPresent(String.self, forKey: .icon_background_color)
        icon_mask_base_uri = try values.decodeIfPresent(String.self, forKey: .icon_mask_base_uri)
        international_phone_number = try values.decodeIfPresent(String.self, forKey: .international_phone_number)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
        opening_hours = try values.decodeIfPresent(Opening_Hours.self, forKey: .opening_hours)
        user_ratings_total = try values.decodeIfPresent(Int.self, forKey: .user_ratings_total)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        utc_offset = try values.decodeIfPresent(Int.self, forKey: .utc_offset)
        vicinity = try values.decodeIfPresent(String.self, forKey: .vicinity)
        photos = try values.decodeIfPresent([Photos_List].self, forKey: .photos)
        plus_code = try values.decodeIfPresent(Plus_Code.self, forKey: .plus_code)
        types = try values.decodeIfPresent([String].self, forKey: .types)
        reviews = try values.decodeIfPresent([Reviews].self, forKey: .reviews)
    }
}

class Address_Components : Codable {
    var long_name : String?
    var short_name : String?
    var types : [String]?
    enum CodingKeys: String, CodingKey {
        case long_name = "long_name"
        case short_name = "short_name"
        case types = "types"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        long_name = try values.decodeIfPresent(String.self, forKey: .long_name)
        short_name = try values.decodeIfPresent(String.self, forKey: .short_name)
        types = try values.decodeIfPresent([String].self, forKey: .types)
    }
}

class Geometry : Codable {
    var location : Location?
    enum CodingKeys: String, CodingKey {
        case location = "location"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
    }
}

class Location : Codable {
    var lat : Double?
    var lng : Double?
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
}

class Opening_Hours : Codable {
    var open_now : Bool?
    var weekday_text : [String]?
    enum CodingKeys: String, CodingKey {
        case open_now = "open_now"
        case weekday_text = "weekday_text"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        open_now = try values.decodeIfPresent(Bool.self, forKey: .open_now)
        weekday_text = try values.decodeIfPresent([String].self, forKey: .weekday_text)
    }
}

class Plus_Code : Codable {
    var compound_code : String?
    var global_code : String?
    enum CodingKeys: String, CodingKey {
        case compound_code = "compound_code"
        case global_code = "global_code"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        compound_code = try values.decodeIfPresent(String.self, forKey: .compound_code)
        global_code = try values.decodeIfPresent(String.self, forKey: .global_code)
    }
}

class Photos_List : Codable {
    var height : Double?
    var width : Double?
    var photo_reference : String?
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case width = "width"
        case photo_reference = "photo_reference"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Double.self, forKey: .height)
        width = try values.decodeIfPresent(Double.self, forKey: .width)
        photo_reference = try values.decodeIfPresent(String.self, forKey: .photo_reference)
    }
}

class Reviews : Codable {
    var author_name : String?
    var author_url : String?
    var language : String?
    var profile_photo_url : String?
    var rating : Double?
    var relative_time_description : String?
    var text : String?
    var time : Double?
    enum CodingKeys: String, CodingKey {
        case author_name = "author_name"
        case author_url = "author_url"
        case language = "language"
        case profile_photo_url = "height"
        case rating = "rating"
        case relative_time_description = "relative_time_description"
        case text = "text"
        case time = "time"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author_name = try values.decodeIfPresent(String.self, forKey: .author_name)
        author_url = try values.decodeIfPresent(String.self, forKey: .author_url)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        profile_photo_url = try values.decodeIfPresent(String.self, forKey: .profile_photo_url)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        relative_time_description = try values.decodeIfPresent(String.self, forKey: .relative_time_description)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        time = try values.decodeIfPresent(Double.self, forKey: .time)
    }
}
