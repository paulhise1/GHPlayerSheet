//
//  CharacterCollectionViewCell.swift
//  GHPlayerSheet
//
//  Created by Paul Hise on 2/11/18.
//  Copyright © 2018 Paul Hise. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var characterCellImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    var characterImage: UIImage? {
        didSet {
            characterCellImage.image = characterImage
        }
    }
    var characterName: String? {
        didSet {
            characterNameLabel.text = characterName
        }
    }
    
    func setNameLabelColor(color: UIColor) {
        characterNameLabel.textColor = color
    }
}
