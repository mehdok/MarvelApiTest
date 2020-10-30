//
//  CharacterCell.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import UIKit
import DomainLayer
import RxSwift

class CharacterCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
        
    var character: Character? {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        characterName.text = character?.name
        //TODO setImage
    }
}
