import UIKit
import Alamofire

enum ProfileState {
    case display
    case edit
}

class ProfileViewController: UIViewController {
    @IBOutlet var avatar: UIImageView!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.isHidden = true
        }
    }

    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var surnameTextField: UITextField! {
        didSet {
            surnameTextField.isHidden = true
        }
    }

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField! {
        didSet {
            usernameTextField.isHidden = true
        }
    }

    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var phoneTextField: UITextField! {
        didSet {
            phoneTextField.isHidden = true
        }
    }

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField! {
        didSet {
            emailTextField.isHidden = true
        }
    }

    @IBOutlet var passwordLabel: UILabel! {
        didSet {
            passwordLabel.isHidden = true
        }
    }

    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isHidden = true
        }
    }

    @IBOutlet var stackViewToTopConstraint: NSLayoutConstraint!
    @IBOutlet var stackViewToAvatarConstraint: NSLayoutConstraint!

    @IBOutlet var leftBarButton: UIBarButtonItem!
    @IBOutlet var rightBarButton: UIBarButtonItem!

    private var state: ProfileState = .display

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showUserInfo()
    }

    private func showUserInfo() {
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        usernameLabel.text = user.username
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }

    @IBAction func rightButtonTapped(_ sender: Any) {
        switch state {
        case .display:
            showEditingElements()
            state = .edit
        case .edit:
            updateUser()
        }

    }

    @IBAction func leftButtonTapped(_ sender: Any) {
        switch state {
        case.display:
            user = nil
            performSegue(withIdentifier: "unwindToStart", sender: nil)
        case .edit:
            showDisplayElements()
            state = .display
        }     
    }

    private func hide(_ isHidden: Bool, _ elements: [UIView]) {
        elements.forEach {
            $0.isHidden = isHidden
        }
    }

    private func showEditingElements() {
        hide(true, [nameLabel, surnameLabel, usernameLabel, phoneLabel, emailLabel, avatar])
        stackViewToTopConstraint.isActive = true
        stackViewToAvatarConstraint.isActive = false
        hide(false, [nameTextField, surnameTextField, usernameTextField, phoneTextField, emailTextField, passwordTextField, passwordLabel])
        leftBarButton.title = "Cancel"
        rightBarButton.title = "Done"
        state = .edit
    }

    private func showDisplayElements() {
        hide(false, [nameLabel, surnameLabel, usernameLabel, phoneLabel, emailLabel, avatar])
        stackViewToTopConstraint.isActive = false
        stackViewToAvatarConstraint.isActive = true
        hide(true, [nameTextField, surnameTextField, usernameTextField, phoneTextField, emailTextField, passwordTextField, passwordLabel])
        leftBarButton.title = "Log out"
        rightBarButton.title = "Edit"
    }

    private func updateUser() {
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
            "id": "\(user.id)",
            "username": username,
            "password": password,
            "name": name,
            "surname": surname,
            "email": email,
            "phone": phone
        ]

        Alamofire.request("http://localhost:8080/auth", method: .put, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let users = try JSONDecoder().decode([User].self, from: response.data!)
                    guard let parsedUser = users.first else {
                        DispatchQueue.main.async {
                            self.showAlert(message: "Username is already taken")
                        }
                        return
                    }
                    user = parsedUser
                    DispatchQueue.main.async {
                        self.showUserInfo()
                        self.view.endEditing(true)
                        self.showDisplayElements()
                        self.state = .display
                    }
                }
                catch {
                    self.showAlert(message: "Username is already taken")
                }
        }
    }
}
