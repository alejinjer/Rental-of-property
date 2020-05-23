package app.Booking;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@FeignClient(value = "booking-service")
public interface BookingClient {
    @GetMapping("/bookings")
    public String getBookingsByUserId(@RequestParam(value = "user_id", required = true) Integer user_id);

    @PostMapping("/bookings")
    public Boolean addBooking(@RequestBody
                              @RequestParam(value = "apartment_id", required = true) Integer apartment_id,
                              @RequestParam(value = "user_id", required = true) Integer user_id,
                              @RequestParam(value = "date_from", required = true) String date_from,
                              @RequestParam(value = "date_to", required = true) String date_to);

    @DeleteMapping("/bookings")
    public Boolean deleteBooking(@RequestParam(value = "id", required = true) Integer id);
}
