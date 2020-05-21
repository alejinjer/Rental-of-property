import UIKit

class InitialViewController: UIViewController {
    @IBOutlet var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 10
        }
    }
}

