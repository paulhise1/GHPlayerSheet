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
    
    var characterImage: UIImage? {
        didSet {
            characterCellImage.image = characterImage
        }
    }
    
    
    
}
