import UIKit
import Foundation

class ApartmentTableViewCell: UITableViewCell {
    @IBOutlet private var apartmentImageView: UIImageView!
    @IBOutlet private var flatsNumberLabel: UILabel!
    @IBOutlet private var costLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with apartment: Apartment) {
        apartmentImageView.downloadImage(from: URL(string: apartment.imgUrl)!)
        flatsNumberLabel.text = "\(apartment.flatsNumber) flat(s)"
        costLabel.text = "\(apartment.cost)UAH per day"
        addressLabel.text = apartment.address
    }

}
