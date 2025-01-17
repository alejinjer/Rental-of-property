package app.Review;

import org.springframework.data.repository.CrudRepository;

public interface ReviewRepository extends CrudRepository<Review, Integer> {
    Iterable<Review> findByApartmentId(Integer apartmentId);
}
