package app.Apartment;

import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface ApartmentRepository extends CrudRepository<Apartment, Integer> {
}
