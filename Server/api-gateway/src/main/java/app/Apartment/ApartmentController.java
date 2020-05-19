package app.Apartment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class ApartmentController {
    @Autowired
    ApartmentClient apartmentClient;

    @GetMapping("/apartments")
    public String getApartments() {
        return apartmentClient.getApartments();
    }

    @PostMapping("/apartments")
    public Boolean addApartment(@RequestBody
                                @RequestParam(value = "flats_number", required = true) Integer flats_number,
                                @RequestParam(value = "cost", required = true) Integer cost,
                                @RequestParam(value = "description", required = true) String description,
                                @RequestParam(value = "address", required = true) String address,
                                @RequestParam(value = "img_url", required = true) String img_url) {
        return apartmentClient.addApartment(flats_number, cost, description, address, img_url);
    }

    @PutMapping("/apartments")
    public Boolean editApartment(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                                 @RequestParam(value = "flats_number", required = true) Integer flats_number,
                                 @RequestParam(value = "cost", required = true) Integer cost,
                                 @RequestParam(value = "description", required = true) String description,
                                 @RequestParam(value = "address", required = true) String address,
                                 @RequestParam(value = "img_url", required = true) String img_url) {
        return apartmentClient.editApartment(id, flats_number, cost, description, address, img_url);
    }

    @DeleteMapping("/apartments")
    public Boolean deleteApartment(@RequestParam(value = "id", required = true) Integer id) {
        return apartmentClient.deleteApartment(id);
    }
}
