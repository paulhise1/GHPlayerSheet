import UIKit

class HubViewController: UIViewController {

    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let partyScenarioLabelText = "Your party scenario:"
        static let characterCellID = "CharacterCollectionViewCell"
    }
    
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var characterLevelLabel: UILabel!
    @IBOutlet weak var characterSymbolImage: UIImageView!
    
    @IBOutlet weak var unlockCharacterButton: UIButton!
    @IBOutlet weak var unlockButtonBackgroundImage: UIImageView!
    @IBOutlet weak var addCharacterButton: UIButton!
    
    @IBOutlet weak var unlockCharacterContainerView: UIView!
    @IBOutlet weak var unlockCharacterImageView: UIImageView!
    @IBOutlet weak var acceptUnlockButton: UIButton!
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    @IBOutlet weak var addCharacterContainerView: UIView! {
        didSet {
            addCharacterContainerView.layer.cornerRadius = 4
            addCharacterContainerView.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var partyNameLabel: UILabel!
    
    private var viewModel: HubViewModel?
//    private var newCharName: String?
//    private var newCharClass: CharacterClass?
//    private var newCharExperience: String?
    private var selectedCharacter: Character?
    private var selectedClass: CharacterClass?
    private var selectedIndex: IndexPath?
    
    private var width: CGFloat {
        return charactersCollectionView.bounds.width / 6
    }
    
    private var height: CGFloat {
        return charactersCollectionView.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()

        partyNameLabel.text = viewModel?.partyName
        
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        
        setupDisplay()
        }
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        charactersCollectionView.isUserInteractionEnabled = false
        unlockButtonBackgroundImage.isHidden = true
        unlockCharacterButton.isHidden = true
        unlockCharacterContainerView.isHidden = false
        view.bringSubview(toFront: unlockCharacterContainerView)
        if let selected = selectedClass {
            unlockCharacterImageView.image = UIImage(named: CharacterClass.characterUnlockedImageForClass(charClass: selected.classOf))
        }
        
    }
    @IBAction func cancelUnlockButtonTapped(_ sender: Any) {
        unlockButtonBackgroundImage.isHidden = false
        unlockCharacterButton.isHidden = false
        unlockCharacterContainerView.isHidden = true
        charactersCollectionView.isUserInteractionEnabled = true
    }
    
    @IBAction func acceptUnlockButtonTapped(_ sender: Any) {
        if let selected = selectedClass {
            viewModel?.unlockCharacterClass(charClass: selected)
            unlockCharacterContainerView.isHidden = true
            resetCollectionViewWithItemMove()
        }
    }
    
    @IBAction func addCharacterButtonTApped(_ sender: Any) {
        addCharacterButton.isHidden = true
        addCharacterContainerView.isHidden = false
        view.bringSubview(toFront: addCharacterContainerView)
        loadAddCharacterView()
        charactersCollectionView.isUserInteractionEnabled = false
    }
    
    private func setupDisplay() {
        addCharacterContainerView.isHidden = true
        characterInfoLabel.isHidden = true
        characterLevelLabel.isHidden = true
        characterSymbolImage.isHidden = true
        unlockCharacterButton.isHidden = true
        unlockButtonBackgroundImage.isHidden = true
        addCharacterButton.isHidden = true
        unlockCharacterContainerView.isHidden = true
    }
    
    func displayCharacterInfo(character: Character) {
        if let info = viewModel?.infoForCharacter(character: character) {
            unlockButtonBackgroundImage.isHidden = true
            unlockCharacterButton.isHidden = true
            addCharacterButton.isHidden = true
            characterInfoLabel.isHidden = false
            characterSymbolImage.isHidden = false
            characterLevelLabel.isHidden = false
            characterInfoLabel.text = info[0]
            characterLevelLabel.text = info[1]
            characterSymbolImage.image = UIImage(named: info[2])
        }
    }
    
    func displayAddCharacter(charClass: CharacterClass.charClass) {
        characterInfoLabel.isHidden = true
        characterSymbolImage.isHidden = true
        characterLevelLabel.isHidden = true
        unlockButtonBackgroundImage.isHidden = true
        unlockCharacterButton.isHidden = true
        addCharacterButton.isHidden = false
        addCharacterButton.setImage(UIImage(named: CharacterClass.characterLockedImageForClass(charClass: charClass)), for: .normal)
    }

    func displayUnlockCharacter(charClass: CharacterClass.charClass) {
        characterInfoLabel.isHidden = true
        characterSymbolImage.isHidden = true
        characterLevelLabel.isHidden = true
        addCharacterButton.isHidden = true
        unlockButtonBackgroundImage.isHidden = false
        unlockCharacterButton.isHidden = false
        unlockCharacterButton.setImage(UIImage(named: "lockedIcon"), for: .normal)
        unlockButtonBackgroundImage.image = UIImage(named: CharacterClass.characterLockedImageForClass(charClass: charClass))
    }
    
    func resetCollectionViewWithItemMove() {
        charactersCollectionView.isUserInteractionEnabled = true
        if let selectedIndex = selectedIndex {
        let firstItemPath = IndexPath(row: 0, section: 0)
        charactersCollectionView.moveItem(at: selectedIndex, to: firstItemPath)
        let indices: IndexSet = [0]
        charactersCollectionView.reloadSections(indices)
        charactersCollectionView.scrollToItem(at: firstItemPath, at: .left, animated: true)
        }
    }
    
}

extension HubViewController: AddCharacterViewDelegate {
    
    func didCancelCharacterCreation() {
        addCharacterContainerView.isHidden = true
        charactersCollectionView.isUserInteractionEnabled = true
        if let selected = selectedClass {
            displayAddCharacter(charClass: selected.classOf)
        }
    }
    
    func didCreateCharacter(name: String, experience: Int) {
        addCharacterContainerView.isHidden = true
        if let selected = selectedClass {
            viewModel?.createCharacter(charClass: selected.classOf, name: name, experience: experience)
        }
        resetCollectionViewWithItemMove()
    }
    
    func loadAddCharacterView() {
        let addCharacterView = Bundle.main.loadNibNamed(String(describing: AddCharacterView.self), owner: self, options: nil)?.first as? AddCharacterView
        if let view = addCharacterView, let selectedClass = selectedClass {
            addCharacterContainerView.addSubview(view)
            view.frame = addCharacterContainerView.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.configure(charClass: selectedClass.classOf)
            view.delegate = self
        }
    }
}

extension HubViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let characters = viewModel?.classesDatasource?.count() {
            return characters
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.characterCellID, for: indexPath) as! CharacterCollectionViewCell
       
        guard let classesStrings = viewModel?.classImages() else { return cell }
        cell.displayContent(image: UIImage(named: classesStrings[indexPath.row])!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let charClasses = viewModel?.classesList() else { return }
        if charClasses[indexPath.row].owned {
            if let charCount = viewModel?.characterDatasource?.count() {
                for i in stride(from: 0, to: charCount, by: 1) {
                    if let character = viewModel?.characterDatasource?.modelAt(index: i) {
                        if character.characterClass == charClasses[indexPath.row].classOf {
                            selectedCharacter = character
                            selectedIndex = indexPath
                            if let selected = selectedCharacter {
                                displayCharacterInfo(character: selected)
                            }
                        }
                    }
                }
                
            }
        } else if charClasses[indexPath.row].unlocked {
            selectedClass = charClasses[indexPath.row]
            selectedIndex = indexPath
            if let selected = selectedClass {
                displayAddCharacter(charClass: selected.classOf)
            }
        } else {
            selectedClass = charClasses[indexPath.row]
            selectedIndex = indexPath
            if let selected = selectedClass {
                displayUnlockCharacter(charClass: selected.classOf)
            }
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }

}

