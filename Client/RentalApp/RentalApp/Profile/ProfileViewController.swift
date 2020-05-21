import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text = user.name
        }
    }

    @IBOutlet var surnameLabel: UILabel! {
        didSet {
            surnameLabel.text = user.surname
        }
    }

    @IBOutlet var usernameLabel: UILabel! {
        didSet {
            usernameLabel.text = user.username
        }
    }

    @IBOutlet var phoneLabel: UILabel! {
        didSet {
            phoneLabel.text = user.phone
        }
    }

    @IBOutlet var emailLabel: UILabel! {
        didSet {
            emailLabel.text = user.email
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: false)
    }

    @objc private func editButtonTapped() {

    }
}
