import UIKit
import Alamofire

class SignInViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField! {
           didSet {
               passwordTextField.disableAutoFill()
           }
       }

    @IBOutlet private var submitButton: UIButton! {
        didSet {
            submitButton.layer.cornerRadius = 10
            submitButton.layer.borderWidth = 2
            submitButton.layer.borderColor = UIColor.white.cgColor
        }
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                self.showAlert(message: "Fields can not be empty!")
                return
        }

        let params: Parameters = [
            "username": username,
            "password": password,
        ]

        Alamofire.request("http://localhost:8080/auth", method: .get, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let users = try JSONDecoder().decode([User].self, from: response.data!)
                    user = users.first!
                    DispatchQueue.main.async {
                        if user.username == "admin" {
                            self.performSegue(withIdentifier: "goToAdmin", sender: nil)
                        }
                        else {
                            self.performSegue(withIdentifier: "goToMenu", sender: nil)
                        }
                    }

                }
                catch {
                    self.showAlert(message: "Incorrect username and/or password")
                }
        }
    }
}
