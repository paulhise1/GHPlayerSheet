import UIKit

class PerkToAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Constants {
        static let perkToAddCellID = "PerkToAddCell"
    }
    
    var perks: [PerkModel]?
    var previouslySelectedCellIndex: Int?
    var checkedPerks: [PerkModel]?
    var isDifferentCell = true
    
    @IBOutlet weak var addPerkButtonContainerView: UIView!{
        didSet {
            addPerkButtonContainerView.layer.cornerRadius = 18
            addPerkButtonContainerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(with perks: [PerkModel]) {
        self.perks = perks
    }
    
    @IBAction func addPerkTapped(_ sender: Any) {
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
                cell.perkToAddLabel.textColor = UIColor.flatWatermelon()
                cell.perksAvailable.textColor = UIColor.flatWatermelon()
            } else {
                cell.perkToAddLabel.textColor = UIColor.black
                cell.perksAvailable.textColor = UIColor.black
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let previouslySelectedCellIndex = previouslySelectedCellIndex, let perks = perks {
            if previouslySelectedCellIndex == indexPath.row{
                isDifferentCell = false
            } else {
                isDifferentCell = true
            }
            perks[previouslySelectedCellIndex].checked = !perks[previouslySelectedCellIndex].checked!
            self.previouslySelectedCellIndex = nil
        } else {
            isDifferentCell = true
        }
        
        if let perks = perks {
            if isDifferentCell{
            previouslySelectedCellIndex = indexPath.row
            perks[indexPath.row].checked = !perks[indexPath.row].checked!
            }
            
        }
        tableView.reloadData()
    }
    
}

