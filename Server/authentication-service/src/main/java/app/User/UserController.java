package app.User;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class UserController {
    @Autowired
    UserRepository userRepository;

    @GetMapping("/auth")
    public String sign_in(@RequestParam(value = "username", required = true) String username,
                              @RequestParam(value = "password", required = true) String password) {

        List<User> resultList = new ArrayList<>();
        Optional<User> user = userRepository.findByUsername(username);
        if (user.isPresent() && user.get().getPassword().equals(password)) {
            resultList.add(user.get());
        }
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/auth")
    public ResponseEntity<String> sign_up(@RequestBody @RequestParam(value = "id", required = true) String id,
                                          @RequestParam(value = "username", required = true) String username,
                                          @RequestParam(value = "password", required = true) String password,
                                          @RequestParam(value = "name", required = true) String name,
                                          @RequestParam(value = "surname", required = true) String surname,
                                          @RequestParam(value = "email", required = true) String email,
                                          @RequestParam(value = "phone", required = true) String phone) {
        Optional<User> test = userRepository.findByUsername(username);
        if (test.isPresent()) {
            return ResponseEntity.ok("{}");
        }
        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setSurname(surname);
        user.setEmail(email);
        user.setPhone(phone);
        userRepository.save(user);
        return ResponseEntity.ok(user.toString());
    }
}