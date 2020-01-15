package org.example.RushGarage.controller;

import org.example.RushGarage.domain.Car;
import org.example.RushGarage.domain.Message;
import org.example.RushGarage.domain.User;
import org.example.RushGarage.repos.CarRepo;
import org.example.RushGarage.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/car")
public class CarController {
    @Autowired
    CarRepo carRepo;
    @Autowired
    MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping
    public String carList(Model model) {
        model.addAttribute("cars", carRepo.findAll());

        return "carList";
    }

    @GetMapping("{car}")
    public String carEditForm(@PathVariable Car car, Model model) {
        model.addAttribute("car", car);

        return "carEdit";
    }

    @GetMapping("/order/{car}")
    public String carOrderForm(
            @AuthenticationPrincipal User user,
            @PathVariable Car car, Model model
    ){
        model.addAttribute("car", car);
        return "carOrder";
    }

    @PostMapping("/order/add")
    public String addMessage (
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam Integer carId,
            @RequestParam String datestart,
            @RequestParam int duration,
            @RequestParam Map<String, Object> model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        Optional<Car> car = carRepo.findById(carId);
        Message message =new Message(text, "considered", user, car.get(), datestart, duration);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            message.setFilename(resultFilename);
        }

        messageRepo.save(message);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);

        return "redirect:/main";
    }

    @PostMapping("/save")
    public String carSave(
            @RequestParam String carname,
            @RequestParam Map<String, String> form,
            @RequestParam("carId") Car car)
    {
        car.setCarname(carname);

        carRepo.save(car);

        return "redirect:/car";
    }

    @PostMapping
    public String addCar (
            @RequestParam String carname,
            @RequestParam String description,
            @RequestParam String cost, Map<String, Object> model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        Car car = new Car(carname, description, cost);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            car.setFilename(resultFilename);
        }

        carRepo.save(car);

        Iterable<Car> cars = carRepo.findAll();
        model.put("cars", cars);

        return "carList";
    }
}
