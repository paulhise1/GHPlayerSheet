import UIKit

class PerkToAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct Constants {
        static let perkToAddCellID = "PerkToAddCell"
    }
    
    var perkManager: PerkManager?
    var perkListType: PerkListType?
    var perkList: [PerkModel]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        perkManager = PerkManager()
        configureTableView()
        
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        getListForTableView()
    }
    
    func getListForTableView() {
        if let perkListType = perkListType, let perkManager = perkManager {
            switch perkListType {
            case .brute:
                perkList = perkManager.getPerkList(perksFor: .brute)
            case .cragheart:
                perkList = perkManager.getPerkList(perksFor: .cragheart)
            case .mindthief:
                perkList = perkManager.getPerkList(perksFor: .mindthief)
            case .spellweaver:
                perkList = perkManager.getPerkList(perksFor: .spellweaver)
            case .scoundrel:
                perkList = perkManager.getPerkList(perksFor: .scoundrel)
            case .tinkerer:
                perkList = perkManager.getPerkList(perksFor: .tinkerer)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var listCount = Int()
        if let perkList = perkList {
            listCount = perkList.count
        }
        return listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.perkToAddCellID, for: indexPath) as! PerkToAddTableViewCell
        if let perkList = perkList {
            cell.perkToAddLabel.text = perkList[indexPath.row].perkText
        }
        return cell
    }


    
}

