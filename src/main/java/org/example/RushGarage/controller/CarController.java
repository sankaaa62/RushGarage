package org.example.RushGarage.controller;

import org.example.RushGarage.domain.Car;
import org.example.RushGarage.repos.CarRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/car")
public class CarController {
    @Autowired
    CarRepo carRepo;

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
    public String add (
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
