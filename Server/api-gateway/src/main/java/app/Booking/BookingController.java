package app.Booking;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
public class BookingController {
    @Autowired
    BookingClient bookingClient;

    @GetMapping("/bookings")
    public String getBookingsByUserId(@RequestParam(value = "user_id", required = true) Integer user_id) {
        return bookingClient.getBookingsByUserId(user_id);
    }

    @PostMapping("/bookings")
    public Boolean addBooking(@RequestBody
                              @RequestParam(value = "apartment_id", required = true) Integer apartment_id,
                              @RequestParam(value = "user_id", required = true) Integer user_id,
                              @RequestParam(value = "date_from", required = true) String date_from,
                              @RequestParam(value = "date_to", required = true) String date_to) {
        return bookingClient.addBooking(apartment_id, user_id, date_from, date_to);
    }

    @DeleteMapping("/bookings")
    public Boolean deleteBooking(@RequestParam(value = "id", required = true) Integer id) {
        return bookingClient.deleteBooking(id);
    }
}
