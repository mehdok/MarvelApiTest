//
//  CharacterSection.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import DomainLayer
import RxDataSources

struct SectionOfCharacter {
    var header: String
    var items: [Character]
}

extension SectionOfCharacter: SectionModelType {
    typealias Item = Character
    
    init(original: SectionOfCharacter, items: [Character]) {
        self = original
        self.items = items
    }
}
