import UIKit

protocol PerkToAddTableViewCellDelegate: class {
    func perkSelectedForActive(perkAt: Int)
    func symbolListShouldShow(sender: PerkToAddViewController)
}

class PerkToAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Constants {
        static let perkToAddCellID = "PerkToAddCell"
    }
    
    weak var delegate: PerkToAddTableViewCellDelegate?
    
    var perks: [PerkModel]?
    var previouslySelectedCellIndex: Int?
    var checkedPerks: [PerkModel]?
    var isDifferentCell = true
    
    
    @IBOutlet weak var perkToAddLabel: UILabel!
    @IBOutlet weak var addPerkButtonBorderView: UIView!
    @IBOutlet weak var addPerkButtonContainerView: UIView!{
        didSet {
            addPerkButtonContainerView.layer.cornerRadius = 10
            addPerkButtonContainerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var addPerksButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        addPerkButtonContainerView.isHidden = true
        addPerksButton.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(with perks: [PerkModel]) {
        self.perks = perks
    }
    
    @IBAction func addPerkTapped(_ sender: Any) {
        if let previouslySelectedCellIndex = previouslySelectedCellIndex {
            delegate?.perkSelectedForActive(perkAt: previouslySelectedCellIndex)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func toSymbolList(_ sender: Any) {
        delegate?.symbolListShouldShow(sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var listCount = Int()
        if let perks = perks {
            listCount = perks.count
        }
        return listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 75
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.perkToAddCellID, for: indexPath) as! PerkToAddTableViewCell
        
        if let perks = perks {
            cell.perkToAddLabel.text = perks[indexPath.row].perkText
            cell.perksAvailable.text = String(perks[indexPath.row].perkAvailable)
            if perks[indexPath.row].checked! {
                cell.perkToAddLabel.textColor = UIColor.flatWatermelonColorDark()
                cell.perksAvailable.textColor = UIColor.flatWatermelon()
            } else {
                cell.perkToAddLabel.textColor = UIColor.black
                cell.perksAvailable.textColor = UIColor.black
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let previouslySelectedCellIndex = previouslySelectedCellIndex, let perks = perks {
            if previouslySelectedCellIndex == indexPath.row{
                isDifferentCell = false
            } else {
                isDifferentCell = true
            }
            perks[previouslySelectedCellIndex].checked = false
            addPerkButtonContainerView.isHidden = true
            addPerksButton.isHidden = true
            perkToAddLabel.isHidden = false
            self.previouslySelectedCellIndex = nil
        } else {
            isDifferentCell = true
        }
        
        if let perks = perks {
            if perks[indexPath.row].perkAvailable > 0 {
                if isDifferentCell{
                    previouslySelectedCellIndex = indexPath.row
                    perks[indexPath.row].checked = true
                    addPerkButtonContainerView.isHidden = false
                    addPerksButton.isHidden = false
                    perkToAddLabel.isHidden = true
                }
            }
        }
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
            if self.isMovingFromParentViewController {
                if let perks = perks, let previouslySelectedCellIndex = previouslySelectedCellIndex {
                    perks[previouslySelectedCellIndex].checked = false
                }
        }
    }

}

