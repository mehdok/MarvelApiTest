//
//  CharacterCell.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import UIKit
import DomainLayer
import RxSwift
import Kingfisher

class CharacterCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
        
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        bag = DisposeBag()
    }

    var character: Character? {
        didSet {
            updateCell()
        }
    }
    
    private func updateCell() {
        characterName.text = character?.name
        characterImage.kf.indicatorType = .activity
        if let imagePath = character?.thumbnail?.path, let imageExt = character?.thumbnail?.ext {
            characterImage.kf.setImage(with: URL(string: "\(imagePath).\(imageExt)")!)
        }
    }
}
