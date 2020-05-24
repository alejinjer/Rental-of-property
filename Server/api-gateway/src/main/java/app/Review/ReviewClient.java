package app.Review;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(value = "review-service")
public interface ReviewClient {
    @GetMapping("/reviews")
    public String getReviewsByApartmentId(@RequestParam(value = "apartmentId", required = true) Integer apartmentId);

    @PostMapping("/reviews")
    public String createReview(@RequestBody
                               @RequestParam(value = "userId", required = true) String username,
                               @RequestParam(value = "apartmentId", required = true) Integer apartmentId,
                               @RequestParam(value = "text", required = true) String text);

    @PutMapping("/reviews")
    public String editReview(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "text", required = true) String text);

    @DeleteMapping("/reviews")
    public Boolean deleteReview(@RequestParam(value = "id") Integer id);
}
