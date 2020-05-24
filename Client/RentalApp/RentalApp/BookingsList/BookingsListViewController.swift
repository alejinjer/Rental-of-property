import UIKit
import Alamofire

class BookingsListViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private let cellId = String(describing: BookingTableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBookings()
    }

    private func getBookings() {
        let params: Parameters = [
            "userId": "\(user.id)"
        ]
        Alamofire.request("http://localhost:8080/bookings", method: .get, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    bookings = try JSONDecoder().decode([Booking].self, from: response.data!)
                    self.tableView.reloadData()
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }
}

extension BookingsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                let params: Parameters = [
                    "id": "\(bookings[indexPath.row].id)"
        ]
        Alamofire.request("http://localhost:8080/bookings", method: .delete, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let result = try JSONDecoder().decode(Bool.self, from: response.data!)
                    DispatchQueue.main.async {
                        if result {
                            self.getBookings()
                            self.tableView.reloadData()
                        }
                        else {
                            self.showAlert(message: "Something bad happened")
                        }
                    }
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }
}

extension BookingsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookingTableViewCell
        cell.configure(with: bookings[indexPath.row])
        return cell
    }
}
