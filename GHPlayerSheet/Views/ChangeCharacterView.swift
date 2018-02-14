import UIKit

protocol ChangeCharacterViewDelegate: class {
    func didTapChangeCharacterBackButton()
    func didSelectChangeActiveCharacter(character: Character)
}

class ChangeCharacterView: UIView {

    @IBOutlet weak var ownedCharacterCollectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIButton!
    
    weak var delegate: ChangeCharacterViewDelegate?
    
    private var ownedCharacters: [Character]?
 
    func configure(ownedCharacters: [Character]) {
        self.ownedCharacters = ownedCharacters
        ownedCharacterCollectionView.delegate = self
        ownedCharacterCollectionView.dataSource = self
        ownedCharacterCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        ownedCharacterCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "characterCell")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.didTapChangeCharacterBackButton()
    }
    
}

extension ChangeCharacterView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: 150, height: 150)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 500.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let characters = ownedCharacters else { return 0 }
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let owned = ownedCharacters else { return UICollectionViewCell() }
        let classType = owned[indexPath.row].classType
        let characterImageName = ClassTypeData.icon(for: classType)
        cell.characterImage = UIImage(named: characterImageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
