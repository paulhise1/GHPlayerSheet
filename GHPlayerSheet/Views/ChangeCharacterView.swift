import UIKit

protocol ChangeCharacterViewDelegate: class {
    func didTapChangeCharacterBackButton()
    func didSelectChangeActiveCharacter(character: Character)
}

class ChangeCharacterView: UIView {

    @IBOutlet weak var ownedCharacterCollectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIButton!
    
    weak var delegate: ChangeCharacterViewDelegate?
    
    private var inactiveCharacters: [Character]?
 
    func configure(ownedCharacters: [Character], activeCharacter: Character) {
        buildInactiveCharacterList(ownedCharacters: ownedCharacters, activeCharacter: activeCharacter)
        ownedCharacterCollectionView.delegate = self
        ownedCharacterCollectionView.dataSource = self
        ownedCharacterCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        ownedCharacterCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "characterCell")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.didTapChangeCharacterBackButton()
    }
    
    func buildInactiveCharacterList(ownedCharacters: [Character], activeCharacter: Character) {
        inactiveCharacters = ownedCharacters.filter{ $0 != activeCharacter }
    }
    
}

extension ChangeCharacterView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func refreshData(ownedCharacters: [Character], activeCharacter: Character) {
        buildInactiveCharacterList(ownedCharacters: ownedCharacters, activeCharacter: activeCharacter)
        ownedCharacterCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        guard let inactiveCharacters = inactiveCharacters else { return 0 }
        return inactiveCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let characters = inactiveCharacters else { return UICollectionViewCell() }
        let classType = characters[indexPath.row].classType
        let characterImageName = ClassTypeData.colorIcon(for: classType)
        cell.characterImage = UIImage(named: characterImageName)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let inactiveCharacters = inactiveCharacters else { return }
        delegate?.didSelectChangeActiveCharacter(character: inactiveCharacters[indexPath.row])
    }
}
