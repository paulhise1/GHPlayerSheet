import UIKit

protocol AddCharactersViewDelegate: class {
    func didTapBackButton()
}

class AddCharactersView: UIView {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addCharactersCollectionView: UICollectionView!
    
    @IBOutlet weak var characterCreationWithButtonContainerView: UIView!
    @IBOutlet weak var characterCreationContainerView: UIView!
    var characterCreationView: UIView?
    
    weak var delegate: AddCharactersViewDelegate?
    
    func configure() {
        addCharactersCollectionView.delegate = self
        addCharactersCollectionView.dataSource = self
        addCharactersCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        addCharactersCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "addCharacterCell")
        characterCreationWithButtonContainerView.isHidden = true
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.delegate?.didTapBackButton()
    }
    
    @IBAction func dismissCharacterCreationButtonTapped(_ sender: Any) {
        characterCreationView?.removeFromSuperview()
        characterCreationWithButtonContainerView.isHidden = true
    }
    
    private func setupCharacterCreationView(classType: ClassType) {
        characterCreationWithButtonContainerView.isHidden = false
        if let ccView = Bundle.main.loadNibNamed(String(describing: CharacterCreationView.self), owner: self, options: nil)?.first as? CharacterCreationView {
            characterCreationContainerView.addSubview(ccView)
            ccView.frame = characterCreationContainerView.bounds
            ccView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            ccView.configure(classType: classType)
            characterCreationView = ccView
        }
    }
    
}

extension AddCharactersView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
        return ClassTypeData.allClasses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCharacterCell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let characterImageName = ClassTypeData.icon(for: ClassTypeData.allClasses[indexPath.row])
        cell.characterImage = UIImage(named: characterImageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let classType = ClassTypeData.allClasses[indexPath.row]
        setupCharacterCreationView(classType: classType)
    }
}
