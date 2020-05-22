import UIKit
import Alamofire


class AdminViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private let cellId = String(describing: ApartmentTableViewCell.self)
    private var apartment: Apartment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: true);
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.register(UINib(nibName: "ApartmentTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)

        getApartments()
    }

    @IBAction func addNewApartmentButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToApartmentVC", sender: nil)
    }

    private func getApartments() {
        Alamofire.request("http://localhost:8080/apartments", method: .get)
            .response { response in
                do {
                    apartments = try JSONDecoder().decode([Apartment].self, from: response.data!)
                    self.tableView.reloadData()
                    print(apartments)
                }
                catch {
                    self.showAlert(message: "Username is already taken")
                }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToApartmentEditing" {
            guard let vc = segue.destination as? NewApartmentViewController else {
                return
            }
            vc.state = .editing
            vc.apartment = apartment
        }
    }
}

extension AdminViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apartment = apartments[indexPath.row]
        performSegue(withIdentifier: "goToApartmentEditing", sender: nil)
    }
}

extension AdminViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apartments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ApartmentTableViewCell
        cell.configure(with: apartments[indexPath.row])
        return cell
    }


}
