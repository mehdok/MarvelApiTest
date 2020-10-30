//
//  DetailScreenVM.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import DomainLayer

class DetailScreenVM: BaseViewModel {
    let character: Character
    
    init(character: Character) {
        self.character = character
    }

}
