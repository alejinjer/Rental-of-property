import UIKit
import Alamofire

class NewReviewViewController: UIViewController {

    var state: State = .adding
    var apartment: Apartment!
    var review: Review!

    @IBOutlet var textTextField: UITextField!
    @IBOutlet var deleteReviewButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        deleteReviewButton.isHidden = state == .adding
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        switch state {
        case .adding:
            addTheReview()
        case .editing:
            updateTheReview()
        }
    }

    private func addTheReview() {
        guard let text = textTextField.text, !text.isEmpty else {
            showAlert(message: "Fields can not be empty")
            return
        }

        let params: Parameters = [
            "username": user.username,
            "apartmentId": "\(apartment.id)",
            "text": text
        ]

        Alamofire.request("http://localhost:8080/reviews", method: .post, parameters: params, encoding: URLEncoding.default)
        .response { response in
            do {
                let reviews = try JSONDecoder().decode([Review].self, from: response.data!)
                guard let _ = reviews.first else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Something bad happened")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.showSuccess(message: "Review has been added")
                }
            }
            catch {
                self.showAlert(message: "Server error")
            }
        }
    }

    private func updateTheReview() {
        guard let text = textTextField.text, !text.isEmpty else {
            showAlert(message: "Fields can not be empty")
            return
        }

        let params: Parameters = [
            "id": "\(review.id)",
            "text": text
        ]

        Alamofire.request("http://localhost:8080/reviews", method: .put, parameters: params, encoding: URLEncoding.default)
            .response { _ in
                DispatchQueue.main.async {
                    self.showSuccess(message: "Review has been updated")
                }
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        let params: Parameters = [
            "id": "\(review.id)"
        ]

        Alamofire.request("http://localhost:8080/reviews", method: .delete, parameters: params, encoding: URLEncoding.default)
        .response { response in
            do {
                let result = try JSONDecoder().decode(Bool.self, from: response.data!)
                DispatchQueue.main.async {
                    if result {
                        self.navigationController?.popViewController(animated: true)
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
