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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func unwindToStart(segue:UIStoryboardSegue) { }
}

