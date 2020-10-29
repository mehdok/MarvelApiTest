//
//  OEventList.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

struct OEventList: BaseModel {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [OEventSummary]?
}
