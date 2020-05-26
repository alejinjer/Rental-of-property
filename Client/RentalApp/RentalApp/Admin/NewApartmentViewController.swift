import UIKit
import Alamofire

enum State {
    case editing
    case adding
}

class NewApartmentViewController: UIViewController {

    @IBOutlet var flatsNumberTextField: UITextField!
    @IBOutlet var costTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var deleteButton: UIBarButtonItem!

    var state = State.adding
    var apartment: Apartment?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureElements()
    }

    private func configureElements() {
        switch state {
        case .editing:
            guard let apartment = apartment else {
                return
            }
            deleteButton.title = "Delete"
            flatsNumberTextField.text = "\(apartment.flatsNumber)"
            costTextField.text = "\(apartment.cost)"
            descriptionTextField.text = apartment.description
            addressTextField.text = apartment.address
            urlTextField.text = apartment.imgUrl
        case .adding:
            deleteButton.title = "Cancel"
            flatsNumberTextField.placeholder = "flats numbet"
            costTextField.placeholder = "cost per day"
            descriptionTextField.placeholder = "description"
            addressTextField.placeholder = "address"
            urlTextField.placeholder = "img url"
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        switch state {
        case .adding:
            navigationController?.popViewController(animated: true)
        case .editing:
            deleteApartment()
        }
    }

    @IBAction func acceptButtonTapped(_ sender: Any) {
        switch state {
        case .editing:
            updateApartment()
        case .adding:
            addApartment()
        }
    }

    func addApartment() {
        guard let flatsNumberText = flatsNumberTextField.text,
            let flatsNumber = Int(flatsNumberText),
            let costText = costTextField.text,
            let cost = Int(costText),
            let description = descriptionTextField.text, !description.isEmpty,
            let address = addressTextField.text, !address.isEmpty,
            let url = urlTextField.text, !url.isEmpty else {
                showAlert(message: "Fields can not be empty")
                return
        }

        let params: Parameters = [
            "flats_number": flatsNumber,
            "cost": cost,
            "description": description,
            "address": address,
            "img_url": url
        ]

        Alamofire.request("http://localhost:8080/apartments", method: .post, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let result = try JSONDecoder().decode(Bool.self, from: response.data!)
                    DispatchQueue.main.async {
                        if result {
                            self.navigationController?.popViewController(animated: true)
                        }
                        else {
                            self.showAlert(message: "Error occured")
                        }
                    }
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }

    func updateApartment() {
        guard let id = apartment?.id,
            let flatsNumberText = flatsNumberTextField.text,
            let flatsNumber = Int(flatsNumberText),
            let costText = costTextField.text,
            let cost = Int(costText),
            let description = descriptionTextField.text, !description.isEmpty,
            let address = addressTextField.text, !address.isEmpty,
            let url = urlTextField.text, !url.isEmpty else {
                showAlert(message: "Fields can not be empty")
                return
        }

        let params: Parameters = [
            "id": "\(id)",
            "flats_number": flatsNumber,
            "cost": cost,
            "description": description,
            "address": address,
            "img_url": url
        ]

        Alamofire.request("http://localhost:8080/apartments", method: .put, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let result = try JSONDecoder().decode(Bool.self, from: response.data!)
                    DispatchQueue.main.async {
                        if result {
                            self.navigationController?.popViewController(animated: true)
                        }
                        else {
                            self.showAlert(message: "Error occured")
                        }
                    }
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }

    private func deleteApartment() {
        guard let id = apartment?.id else {
                showAlert(message: "Error occured")
                return
        }

        let params: Parameters = [
            "id": "\(id)",
        ]

        Alamofire.request("http://localhost:8080/apartments", method: .delete, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let result = try JSONDecoder().decode(Bool.self, from: response.data!)
                    DispatchQueue.main.async {
                        if result {
                            self.navigationController?.popViewController(animated: true)
                        }
                        else {
                            self.showAlert(message: "Error occured")
                        }
                    }
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }
}
