import UIKit

class ApartmentViewController: UIViewController {
    @IBOutlet var apartmentImageView: UIImageView!
    @IBOutlet var flatsCountLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var viewReviewsButton: UIButton!
    @IBOutlet var bookButton: UIButton!

    var apartment: Apartment!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }

    @IBAction func bookingButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToBooking", sender: nil)
    }
}
