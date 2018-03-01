import UIKit
import DynamicBlurView


class CharacterSheetViewController: UIViewController {
    
    //MARK: - Constants
    struct Constants {
        static let nameDefaultText = "Enter Name"
        static let notesViewID =  "NotesNavStack"
        static let perksViewID = "PerksNavStack"
    }
    @IBOutlet weak var exitButton: UIButton! {
        didSet {
            exitButton.layer.cornerRadius = 4
            exitButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var perkSymbolListView: PerkSymbolListView?
    @IBOutlet weak var symbolListContainerView: UIView!
    @IBOutlet weak var perkSymbolListContainerLeadingConstraint: NSLayoutConstraint!
    
    private var statModifierView: StatModifierView?
    @IBOutlet weak var statModifierContainerView: UIView!
    @IBOutlet weak var statModifierContainerLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var perksContainerView: UIView!
    
    @IBOutlet weak var notesContainerView: UIView!
    
    private var viewModel: CharacterSheetViewModel?
    private var blurView: DynamicBlurView?
    private var textField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultNameLabelAppearance()
        setupChildViews()
    }

    func configure(characterDataSource: ModelDatasource<Character>) {
        self.viewModel = CharacterSheetViewModel(characterDatasource: characterDataSource)
    }
    
}

//MARK: - StatModifier View Methods
extension CharacterSheetViewController: StatModifierViewDelegate {
    
    func statModifierViewDidBeginModifying(sender: StatModifierView) {
        addBlurEffect()
        view.bringSubview(toFront: statModifierContainerView)
    }
    
    func statModifierViewDidEndModifying(sender: StatModifierView) {
        removeBlurEffect()
        view.bringSubview(toFront: perksContainerView)
    }
    
    func didUpdateGold(amount: Int) {
        if let statModifierView = statModifierView, let viewModel = viewModel {
            viewModel.updateGold(amount: amount)
            statModifierView.goldAmount = viewModel.character.gold
        }
    }
    
    func didUpdateExperience(amount: Int) {
        if let statModifierView = statModifierView, let viewModel = viewModel {
            viewModel.updateExperience(amount: amount)
            statModifierView.experienceAmount = viewModel.character.experience
        }
    }

}

//MARK: - Character Name Button and TextField Methods
extension CharacterSheetViewController: UITextFieldDelegate {
    
    func setupDefaultNameLabelAppearance() {
        if let viewModel = viewModel {
            if viewModel.character.name != "" {
                nameLabel.text = viewModel.character.name
                nameLabel.textColor = ColorConstants.characterNameText
                //need FontConstants file
                nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            } else {
                nameLabel.text = Constants.nameDefaultText
                nameLabel.textColor = ColorConstants.defaultEnterNameText
            }
        }
    }
    
    @IBAction func enterNameButtonTapped(_ sender: Any) {
        addBlurEffect()
        createNameEditingTextField()
    }
    
    func createNameEditingTextField() {
        textField = UITextField()
        let width: CGFloat = 100.0
        let frame = CGRect(x: view.frame.size.width/2-width/2, y: 100, width: width, height: 40)
        if let textField = textField {
            textField.frame = frame
            textField.delegate = self
            textField.backgroundColor = UIColor(white: 1, alpha: 0.4)
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            view.addSubview(textField)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nameLabel.text
        if nameLabel.text == Constants.nameDefaultText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textFieldText = textField.text, let viewModel = viewModel {
            viewModel.updateName(name: textFieldText)
            nameLabel.text = viewModel.character.name
        }
        nameLabel.textColor = ColorConstants.characterNameText
        if textField.text == "" {
            setupDefaultNameLabelAppearance()
        }
        textField.removeFromSuperview()
        removeBlurEffect()
        view.endEditing(true)
        return true
    }
    
}

extension CharacterSheetViewController {
    //MARK: - Helper Methods
    func addBlurEffect(){
        // Would like to animate, animation was stuttered
        blurView = nil
        blurView = DynamicBlurView(frame: view.bounds)
        blurView?.isUserInteractionEnabled = true
        blurView?.blurRadius = 2
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.dismissActiveView(sender:)))
        if let blurView = blurView {
            view.addSubview(blurView)
            blurView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func dismissActiveView(sender : UITapGestureRecognizer) {
        if let textField = textField {
            textField.removeFromSuperview()
            removeBlurEffect()
        }
        if let statModifierView = statModifierView {
            statModifierView.dismissNumpad()
            removeBlurEffect()
        }
    }
    
    func removeBlurEffect(){
        blurView?.blurRadius = 0
        blurView?.removeFromSuperview()
    }
    
    //MARK: - Setup Child Views methods
    func setupChildViews() {
        setupNotesView()
        setupPerksView()
        setupStatModifierView()
        setupPerksSymbolListView()
        symbolListContainerView.isHidden = true
        //setupCheckmarksView()
    }
    
    func setupStatModifierView() {
        statModifierView = Bundle.main.loadNibNamed(String(describing: StatModifierView.self), owner: self, options: nil)?.first as? StatModifierView
        if let statModifierView = statModifierView {
            statModifierContainerView.addSubview(statModifierView)
            statModifierContainerLeadingConstraint.constant = -(statModifierView.widthForAlignment())
            statModifierView.frame = statModifierContainerView.bounds
            statModifierView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            if let viewModel = viewModel {
                statModifierView.goldAmount = viewModel.character.gold
                statModifierView.experienceAmount = viewModel.character.experience
            }
            statModifierView.delegate = self
        }
    }
    
    func setupPerksSymbolListView() {
        perkSymbolListView = Bundle.main.loadNibNamed(String(describing: PerkSymbolListView.self), owner: self, options: nil)?.first as? PerkSymbolListView
        if let perkSymbolListView = perkSymbolListView {
            symbolListContainerView.addSubview(perkSymbolListView)
            perkSymbolListContainerLeadingConstraint.constant = -(perkSymbolListView.widthForAlignment())
            perksContainerView.frame = symbolListContainerView.bounds
            perksContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    
    
    func setupNotesView() {
        if let notesNavViewController = storyboard?.instantiateViewController(withIdentifier: Constants.notesViewID) {
            addChildViewController(notesNavViewController)
            notesNavViewController.view.frame = notesContainerView.bounds
            notesNavViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            notesContainerView.addSubview(notesNavViewController.view)
            notesNavViewController.didMove(toParentViewController: self)
        }
    }
    
    func setupPerksView() {
        if let perksNavController = storyboard?.instantiateViewController(withIdentifier: Constants.perksViewID) as? UINavigationController {
            addChildViewController(perksNavController)
            perksNavController.view.frame = perksContainerView.bounds
            perksContainerView.addSubview(perksNavController.view)
            perksNavController.didMove(toParentViewController: self)
//            if let viewModel = viewModel, let perksVC = perksNavController.topViewController as? PerksViewController {
//                perksVC.configure(with: viewModel.characterModel.characterClass)
//                perksVC.delegate = self
//            }
        }
    }
    
    func perkSymbolListRequested() {
        symbolListContainerView.isHidden = false
        view.bringSubview(toFront: symbolListContainerView)
        
    }
    
//    func setupCheckmarksView() {
//        var checkmarksView = Bundle.main.loadNibNamed(String(describing: CheckmarksView.self), owner: self, options: nil)?.first as? CheckmarksView
//        if let checkmarksView = checkmarksView {
//            checkmarksContainerView.addSubview(checkmarksView)
//            checkmarksView.frame = checkmarksContainerView.bounds
//            checkmarksView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            checkmarksView.configureColorBackground()
//        }
//    }
    
}







