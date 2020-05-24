package app.Review;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequestMapping
@RestController
public class ReviewController {
    @Autowired
    ReviewRepository reviewRepository;

    @GetMapping("/reviews")
    public String getReviewsByApartmentId(@RequestParam(value = "apartmentId", required = true) Integer apartmentId) {
        List<Review> resultList = new ArrayList<>();
        Iterable<Review> result = reviewRepository.findByApartmentId(apartmentId);
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/reviews")
    public String createReview(@RequestBody
                             @RequestParam(value = "userId", required = true) String username,
                             @RequestParam(value = "apartmentId", required = true) Integer apartmentId,
                             @RequestParam(value = "text", required = true) String text) {
        List<Review> resultList = new ArrayList<>();
        Review review = new Review(username, apartmentId, text);
        reviewRepository.save(review);
        resultList.add(review);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PutMapping("/reviews")
    public String editReview(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "text", required = true) String text) {

        Optional<Review> test = reviewRepository.findById(id);
        if (!test.isPresent()) {
            return "{}";
        }
        List<Review> resultList = new ArrayList<>();
        Review review = test.get();
        review.setText(text);
        reviewRepository.save(review);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @DeleteMapping("/reviews")
    public Boolean deleteReview(@RequestParam(value = "id") Integer id) {
        try {
            Optional<Review> test = reviewRepository.findById(id);
            if (!test.isPresent()) {
                return false;
            }
            reviewRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
