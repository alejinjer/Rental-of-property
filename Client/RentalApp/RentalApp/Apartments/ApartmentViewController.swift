import UIKit

class ApartmentViewController: UIViewController {
    @IBOutlet var apartmentImageView: UIImageView!
    @IBOutlet var flatsCountLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var viewReviewsButton: UIButton! {
        didSet {
            viewReviewsButton.setTitleColor(.black, for: .normal)
            viewReviewsButton.layer.borderWidth = 2
            viewReviewsButton.layer.cornerRadius = 10
            viewReviewsButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    @IBOutlet var bookButton: UIButton! {
        didSet {
            bookButton.setTitleColor(.black, for: .normal)
            bookButton.layer.borderWidth = 2
            bookButton.layer.cornerRadius = 10
            bookButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    var apartment: Apartment!

    private let layer = CAGradientLayer()
    private let colors = [UIColor(red: 0.78, green: 1.00, blue: 0.87, alpha: 1.00).cgColor, UIColor(red: 0.98, green: 0.84, blue: 0.53, alpha: 1.00).cgColor, UIColor(red: 0.97, green: 0.47, blue: 0.49, alpha: 1.00).cgColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layer.frame = view.bounds
        layer.colors = colors
        view.layer.insertSublayer(layer, at: 0)

        apartmentImageView.downloadImage(from: URL(string: apartment.imgUrl)!)
        flatsCountLabel.text = "\(apartment.flatsNumber) flat(s)"
        costLabel.text = "\(apartment.cost)UAH per day"
        descriptionLabel.text = apartment.description
        addressLabel.text = apartment.address
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BookingViewController {
            vc.apartment = apartment
        }

        if let vc = segue.destination as? ReviewsListViewController {
            vc.apartment = apartment
        }
    }

    @IBAction func bookingButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToBooking", sender: nil)
    }

    @IBAction func viewReviewsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToReviews", sender: nil)
    }
}
