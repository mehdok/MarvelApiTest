//
//  OComicList.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

struct OComicList: BaseModel {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [OComicSummary]?
}
