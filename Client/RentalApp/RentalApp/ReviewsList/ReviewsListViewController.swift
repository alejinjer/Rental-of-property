import UIKit
import Alamofire

class ReviewsListViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    var apartment: Apartment!
    var review: Review!
    private let cellId = String(describing: ReviewTableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getReviews()
    }

    private func getReviews() {
        let params: Parameters = [
            "apartmentId": "\(apartment.id)"
        ]

        Alamofire.request("http://localhost:8080/reviews", method: .get, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    reviews = try JSONDecoder().decode([Review].self, from: response.data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewReview" {
            guard let vc = segue.destination as? NewReviewViewController else {
                return
            }
            vc.apartment = apartment
        }
        if segue.identifier == "updateTheReview" {
            guard let vc = segue.destination as? NewReviewViewController else {
                return
            }
            vc.apartment = apartment
            vc.review = review
            vc.state = .editing
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addNewReview", sender: nil)
    }

}

extension ReviewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        review = reviews[indexPath.row]
        if review.username == user.username {
            performSegue(withIdentifier: "updateTheReview", sender: nil)
        }
    }
}

extension ReviewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReviewTableViewCell
        cell.configure(with: reviews[indexPath.row])
        return cell
    }


}
