//
//  DetailScreenVM.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import DomainLayer
import RxSwift
import RxCocoa

class DetailScreenVM: BaseViewModel {
    let character: Character
    
    var characterName: Driver<String?>?
    var characterImage: Driver<String?>?
    var characterDescription: Driver<String?>?

    init(character: Character) {
        self.character = character
        
        characterName = Driver.just(character.name)
        if let imagePath = character.thumbnail?.path, let imageExt = character.thumbnail?.ext {
            characterImage = Driver.just("\(imagePath).\(imageExt)")
        }
        characterDescription = Driver.just(character.description)
    }

}
