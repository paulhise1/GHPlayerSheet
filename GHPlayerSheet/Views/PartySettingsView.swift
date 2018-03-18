import UIKit

protocol PartySettingsViewDelegate: class {
    func didChooseCreateParty()
    func didJoinParty(partyName: String)
    func didDeleteParty(party: Party)
    func didSelectParty(_ party: Party)
}

class PartySettingsView: UIView {

    struct Constant {
        static let tableViewCellHeight: CGFloat = 45
        static let singleLabelTextViewCell = "singleLabelTextViewCell"
        static let tableViewNibName = String(describing: SingleLabelTableViewCell.self)
    }
    
    @IBOutlet weak var partiesListContainer: UIView!
    @IBOutlet weak var partyInviteContainer: UIView!
    @IBOutlet weak var settingsButtonsStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changePartyButton: UIButton!
    
    weak var delegate: PartySettingsViewDelegate?
    
    private var partyInviteView: PartyInviteView?
    private var parties = [Party]()
    
    func configure(parties: [Party]?) {
        partiesListContainer.isHidden = true
        guard let parties = parties else { return }
        changePartyButton.isEnabled = true
        self.parties = parties
    }
    
    func updateParties(parties: [Party]) {
        self.parties = parties
    }
    
    func endPartyServiceConnections() {
        partyInviteView?.removePartyService()
    }
    
    @IBAction func changePartyButtonTapped(_ sender: Any) {
        showpartiesTableView()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        setupPartyInviteView()
    }
    
    @IBAction func createPartyButtonTapped(_ sender: Any) {
        delegate?.didChooseCreateParty()
    }
    
    private func showpartiesTableView() {
        setupTableView()
        settingsButtonsStack.isHidden = true
        partiesListContainer.isHidden = false
        bringSubview(toFront: partiesListContainer)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: Constant.tableViewNibName, bundle: nil), forCellReuseIdentifier: Constant.singleLabelTextViewCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = Constant.tableViewCellHeight
        tableView.reloadData()
    }
    
    private func removePartiesTableView() {
        settingsButtonsStack.isHidden = false
        partiesListContainer.isHidden = true
        bringSubview(toFront: settingsButtonsStack)
    }
    
    private func activePartyFromParties(parties: [Party]) -> Party? {
        for party in parties {
            if party.active {
                return party
            }
        }
        return nil
    }
    
    private func partiesWithoutActiveParty() -> [Party] {
        return parties.filter{ $0.active == false }
    }
    
    private func setupPartyInviteView() {
        settingsButtonsStack.isHidden = true
        bringSubview(toFront: partyInviteContainer)
        partyInviteView = Bundle.main.loadNibNamed(String(describing: PartyInviteView.self), owner: self, options: nil)?.first as? PartyInviteView
        guard let partyInviteView = self.partyInviteView else { return }
        partyInviteView.frame = partyInviteContainer.bounds
        partyInviteView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        partyInviteContainer.addSubview(partyInviteView)
        partyInviteView.delegate = self
        let activePartyName = activePartyFromParties(parties: parties)?.name
        partyInviteView.configure(partyName: activePartyName)
        guard activePartyName == "Default" && activePartyName != nil else { return }
        partyInviteView.shareButton.isEnabled = false
    }
}

extension PartySettingsView: PartyInviteViewDelegate {
    func didJoinParty(partyName: String) {
        delegate?.didJoinParty(partyName: partyName)
    }
    
    func finishedWithPartyInviteView() {
        settingsButtonsStack.isHidden = false
        bringSubview(toFront: settingsButtonsStack)
        partyInviteView?.removeFromSuperview()
    }
}

extension PartySettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partiesWithoutActiveParty().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.singleLabelTextViewCell, for: indexPath) as! SingleLabelTableViewCell
        let parties = partiesWithoutActiveParty()
        cell.configureLabel(text: parties[indexPath.row].name)
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let party = parties[indexPath.row]
        delegate?.didSelectParty(party)
        removePartiesTableView()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let party = parties[indexPath.row]
            delegate?.didDeleteParty(party: party)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
