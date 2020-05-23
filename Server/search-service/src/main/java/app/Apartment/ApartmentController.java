package app.Apartment;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class ApartmentController {

    @Autowired
    ApartmentRepository apartmentRepository;

    @GetMapping("/apartments")
    public String getApartments() {
        List<Apartment> resultList = new ArrayList<>();
        Iterable<Apartment> result = apartmentRepository.findAll();
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/apartments")
    public Boolean addApartment(@RequestBody
                           @RequestParam(value = "flats_number", required = true) Integer flats_number,
                           @RequestParam(value = "cost", required = true) Integer cost,
                           @RequestParam(value = "description", required = true) String description,
                           @RequestParam(value = "address", required = true) String address,
                           @RequestParam(value = "img_url", required = true) String img_url) {
        try {
            Apartment apartment = new Apartment(flats_number, cost, description, address, img_url);
            apartmentRepository.save(apartment);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @PutMapping("/apartments")
    public Boolean editApartment(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                                 @RequestParam(value = "flats_number", required = true) Integer flats_number,
                                 @RequestParam(value = "cost", required = true) Integer cost,
                                 @RequestParam(value = "description", required = true) String description,
                                 @RequestParam(value = "address", required = true) String address,
                                 @RequestParam(value = "img_url", required = true) String img_url) {
        try {
            Optional<Apartment> test = apartmentRepository.findById(id);
            if (!test.isPresent())
                return false;
            Apartment apartment = test.get();
            apartment.setFlats_number(flats_number);
            apartment.setCost(cost);
            apartment.setDescription(description);
            apartment.setAddress(address);
            apartment.setImg_url(img_url);
            apartmentRepository.save(apartment);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/apartments")
    public Boolean deleteApartment(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Apartment> test = apartmentRepository.findById(id);
            if (!test.isPresent())
                return false;
            apartmentRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
