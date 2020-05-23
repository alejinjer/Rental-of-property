package app.Booking;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class BookingController {
    @Autowired
    BookingRepository bookingRepository;

    @GetMapping("/bookings")
    public String getBookingsByUserId(@RequestParam(value = "userId", required = true) Integer userId) {
        List<Booking> resultList = new ArrayList<>();
        Iterable<Booking> result = bookingRepository.findByUserId(userId);
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/bookings")
    public Boolean addBooking(@RequestBody
                              @RequestParam(value = "apartmentId", required = true) Integer apartmentId,
                              @RequestParam(value = "userId", required = true) Integer userId,
                              @RequestParam(value = "date_from", required = true) String date_from,
                              @RequestParam(value = "date_to", required = true) String date_to) {
        try {
            Booking booking = new Booking(apartmentId, userId, date_from, date_to);
            bookingRepository.save(booking);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/bookings")
    public Boolean deleteBooking(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Booking> test = bookingRepository.findById(id);
            if (!test.isPresent())
                return false;
            bookingRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
