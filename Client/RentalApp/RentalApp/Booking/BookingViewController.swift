import UIKit
import Alamofire

class BookingViewController: UIViewController {
    @IBOutlet var dateFromTextField: UITextField!
    @IBOutlet var dateToTextField: UITextField!

    private var dateFrom: Date?
    private var dateTo: Date?

    var state: State = .adding

    var apartment: Apartment!

    override func viewDidLoad() {
        super.viewDidLoad()

        let fromDatePicker = UIDatePicker()
        let toDatePicker = UIDatePicker()

        fromDatePicker.datePickerMode = .date
        toDatePicker.datePickerMode = .date

        fromDatePicker.addTarget(self, action: #selector(fromDatePickerChangedValue(sender:)), for: .valueChanged)
        toDatePicker.addTarget(self, action: #selector(toDatePickerChangedValue(sender:)), for: .valueChanged)

        dateFromTextField.inputView = fromDatePicker
        dateToTextField.inputView = toDatePicker

        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    @objc private func fromDatePickerChangedValue(sender: UIDatePicker) {
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        dateFrom = sender.date

        dateFromTextField.text = formatter.string(from: sender.date)
    }

    @objc private func toDatePickerChangedValue(sender: UIDatePicker) {
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        dateTo = sender.date

        dateToTextField.text = formatter.string(from: sender.date)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let dateFrom = dateFrom,
        let dateTo = dateTo,
            dateTo > dateFrom else {
                showAlert(message: "Incorrect dates!")
                return
        }

        let params: Parameters = [
            "apartmentId": "\(apartment.id)",
            "userId": "\(user.id)",
            "date_from": dateFromTextField.text!,
            "date_to": dateToTextField.text!
        ]

        Alamofire.request("http://localhost:8080/bookings", method: .post, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let result = try JSONDecoder().decode(Bool.self, from: response.data!)
                    DispatchQueue.main.async {
                        result ? self.showSuccess(message: "Booking was created") : self.showAlert(message: "Something bad occured")
                    }
                }
                catch {
                    self.showAlert(message: "Server error")
                }
        }
    }
}
