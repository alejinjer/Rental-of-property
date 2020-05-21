package app.Apartment;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(value = "search-service")
public interface ApartmentClient {
    @GetMapping("/apartments")
    public String getApartments();

    @PostMapping("/apartments")
    public Boolean addApartment(@RequestBody
                           @RequestParam(value = "flats_number", required = true) Integer flats_number,
                           @RequestParam(value = "cost", required = true) Integer cost,
                           @RequestParam(value = "description", required = true) String description,
                           @RequestParam(value = "address", required = true) String address,
                           @RequestParam(value = "img_url", required = true) String img_url);

    @PutMapping("/apartments")
    public Boolean editApartment(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                                 @RequestParam(value = "flats_number", required = true) Integer flats_number,
                                 @RequestParam(value = "cost", required = true) Integer cost,
                                 @RequestParam(value = "description", required = true) String description,
                                 @RequestParam(value = "address", required = true) String address,
                                 @RequestParam(value = "img_url", required = true) String img_url);

    @DeleteMapping("/apartments")
    public Boolean deleteApartment(@RequestParam(value = "id", required = true) Integer id);
}
