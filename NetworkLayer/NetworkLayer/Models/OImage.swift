//
//  OImage.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

struct OImage: BaseModel {
    let path: String?
    let ext: String?

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
