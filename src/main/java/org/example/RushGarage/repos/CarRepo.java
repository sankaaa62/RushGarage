package org.example.RushGarage.repos;

import org.example.RushGarage.domain.Car;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CarRepo extends CrudRepository<Car, Integer> {

    //List<Car> findByNumber(String number);
}
