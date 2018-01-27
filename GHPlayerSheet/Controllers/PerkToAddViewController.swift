import UIKit

class PerkToAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct Constants {
        static let perkToAddCellID = "PerkToAddCell"
    }
    
    var perks: [PerkModel]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
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
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    
}

