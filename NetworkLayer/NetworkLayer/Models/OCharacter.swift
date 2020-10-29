//
//  OCharacter.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

struct OCharacter: BaseModel {
    let id: Int?
    let name: String?
    let description: String?
    let modified: Date?
    let resourceURI: String
    let urls: [OUrl]?
    let thumbnail: OImage?
    let comics: OComicList?
    let stories: OStoryList?
    let events: OEventList?
    let series: OSeriesList?
}
