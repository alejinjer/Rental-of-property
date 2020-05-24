import UIKit

class BookingTableViewCell: UITableViewCell {

    @IBOutlet var dateFromLabel: UILabel!
    @IBOutlet var dateToLabel: UILabel!

    func configure(with booking: Booking) {
        dateFromLabel.text = "From: \(booking.dateFrom)"
        dateToLabel.text = "To: \(booking.dateTo)"
    }
}
