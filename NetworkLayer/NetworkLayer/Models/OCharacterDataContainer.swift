//
//  OCharacterDataContainer.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

struct OCharacterDataContainer: BaseModel {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [OCharacter]?
}
