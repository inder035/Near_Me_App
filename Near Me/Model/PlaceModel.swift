//
//  PlaceModel.swift
//  Near Me
//
//  Created by Inder Singh on 26/06/22.
//

import Foundation

class PlaceModel : Codable {
    var predictions : [Predictions]?
    var status : String?
    enum CodingKeys: String, CodingKey {
        case predictions = "predictions"
        case status = "status"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        predictions = try values.decodeIfPresent([Predictions].self, forKey: .predictions)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

class Predictions : Codable {
    let description : String?
    let place_id : String?
    let reference : String?
    let terms : [Terms]?
    let types : [String]?
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case place_id = "place_id"
        case reference = "reference"
        case terms = "terms"
        case types = "types"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        reference = try values.decodeIfPresent(String.self, forKey: .reference)
        terms = try values.decodeIfPresent([Terms].self, forKey: .terms)
        types = try values.decodeIfPresent([String].self, forKey: .types)
    }
}

class Terms : Codable {
    let offset : Int?
    let value : String?
    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case value = "value"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}
