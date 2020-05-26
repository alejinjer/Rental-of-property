import UIKit
import Alamofire

class ApartmentsViewController: UIViewController {
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

        tableView.register(UINib(nibName: "ApartmentTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)

        getApartments()
    }

    private func getApartments() {
        Alamofire.request("http://localhost:8080/apartments", method: .get)
            .response { response in
                do {
                    apartments = try JSONDecoder().decode([Apartment].self, from: response.data!)
                    self.tableView.reloadData()
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToApartment" {
            guard let vc = segue.destination as? ApartmentViewController else {
                return
            }
            vc.apartment = apartment
        }
    }
}

extension ApartmentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apartment = apartments[indexPath.row]
        performSegue(withIdentifier: "goToApartment", sender: nil)
    }
}

extension ApartmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apartments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ApartmentTableViewCell
        cell.configure(with: apartments[indexPath.row])
        return cell
    }
}
