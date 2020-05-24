package app.Review;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
public class ReviewController {
    @Autowired
    ReviewClient reviewClient;

    @GetMapping("/reviews")
    public String getReviewsByApartmentId(@RequestParam(value = "apartmentId", required = true) Integer apartmentId) {
        return reviewClient.getReviewsByApartmentId(apartmentId);
    }

    @PostMapping("/reviews")
    public String createReview(@RequestBody
                               @RequestParam(value = "username", required = true) String username,
                               @RequestParam(value = "apartmentId", required = true) Integer apartmentId,
                               @RequestParam(value = "text", required = true) String text) {
        return reviewClient.createReview(username, apartmentId, text);
    }

    @PutMapping("/reviews")
    public String editReview(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "text", required = true) String text) {

        return reviewClient.editReview(id, text);
    }

    @DeleteMapping("/reviews")
    public Boolean deleteReview(@RequestParam(value = "id") Integer id) {
        return reviewClient.deleteReview(id);
    }
}
