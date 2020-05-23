package app.Booking;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
public class BookingController {
    @Autowired
    BookingClient bookingClient;

    @GetMapping("/bookings")
    public String getBookingsByUserId(@RequestParam(value = "userId", required = true) Integer userId) {
        return bookingClient.getBookingsByUserId(userId);
    }

    @PostMapping("/bookings")
    public Boolean addBooking(@RequestBody
                              @RequestParam(value = "apartmentId", required = true) Integer apartmentId,
                              @RequestParam(value = "userId", required = true) Integer userId,
                              @RequestParam(value = "date_from", required = true) String date_from,
                              @RequestParam(value = "date_to", required = true) String date_to) {
        return bookingClient.addBooking(apartmentId, userId, date_from, date_to);
    }

    @DeleteMapping("/bookings")
    public Boolean deleteBooking(@RequestParam(value = "id", required = true) Integer id) {
        return bookingClient.deleteBooking(id);
    }
}
