import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private var submitButton: UIButton! {
        didSet {
            submitButton.layer.cornerRadius = 10
            submitButton.layer.borderWidth = 2
            submitButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.disableAutoFill()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }


    // MARK: - IBActions
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let surname = surnameTextField.text, !surname.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                showAlert(message: "Fields can not be empty!")
                return
        }

        let params: Parameters = [
            "username": username,
            "password": password,
            "name": name,
            "surname": surname,
            "email": email,
            "phone": phone
        ]

        Alamofire.request("http://localhost:8080/auth", method: .post, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let users = try JSONDecoder().decode([User].self, from: response.data!)
                    user = users.first!
                    self.performSegue(withIdentifier: "gotoMenu", sender: nil)
                }
                catch {
                    self.showAlert(message: "Username is already taken")
                }
        }
    }
}
