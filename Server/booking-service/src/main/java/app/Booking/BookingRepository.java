package app.Booking;

import org.springframework.data.repository.CrudRepository;

public interface BookingRepository extends CrudRepository<Booking, Integer> {
    Iterable<Booking> findByUserId(Integer userId);
}
