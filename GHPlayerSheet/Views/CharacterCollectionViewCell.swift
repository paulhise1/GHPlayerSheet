//
//  CharacterCollectionViewCell.swift
//  GHPlayerSheet
//
//  Created by Paul Hise on 2/6/18.
//  Copyright © 2018 Paul Hise. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var characterImage: UIImageView!
    
    func displayContent(image: UIImage){
        characterImage.image = image
    }
    
}
