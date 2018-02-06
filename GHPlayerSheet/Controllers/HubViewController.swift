import UIKit

class HubViewController: UIViewController {

    struct Constant {
        static let segueToCharacterSheetID = "toCharacterSheetVC"
        static let partyScenarioLabelText = "Your party scenario:"
        static let characterCellID = "CharacterCollectionViewCell"
    }
    
    @IBOutlet weak var characterInfoLabel: UILabel!
    @IBOutlet weak var characterLevelLabel: UILabel!
    @IBOutlet weak var addCharacterSymbolImageView: UIImageView!
    @IBOutlet weak var characterSymbolImage: UIImageView!
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    @IBOutlet weak var numpadContainerView: UIView!
        {
        didSet {
            numpadContainerView.layer.cornerRadius = 4
            numpadContainerView.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var partyNameLabel: UILabel!
    
    private var viewModel: HubViewModel?
    private var newCharName: String?
    private var newCharClass: CharacterClass?
    private var newCharExperience: String?
    private var characters: [String]?
    
    private var width: CGFloat {
        return charactersCollectionView.bounds.width / 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = HubViewModel()
        
        self.numpadContainerView.isHidden = true

        partyNameLabel.text = viewModel?.partyName
        
        viewModel?.loadCharactersFromPList()
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        
        
        characters = viewModel?.charactersForDisplay()
    }
    
    
   
}

extension HubViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let characters = characters {
            return characters.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: width);
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.characterCellID, for: indexPath) as! CharacterCollectionViewCell
        guard let chars = characters else { return cell }
        cell.displayContent(image: UIImage(named: chars[indexPath.row])!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(characters![indexPath.row])
    }
    
}

