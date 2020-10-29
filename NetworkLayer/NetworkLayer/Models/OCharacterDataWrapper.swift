//
//  OCharacterDataWrapper.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

struct OCharacterDataWrapper: BaseModel {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: OCharacterDataContainer?
    let etag: String?
}
