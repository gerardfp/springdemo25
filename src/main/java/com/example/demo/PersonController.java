package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@RestController
@RequestMapping("/person")
public class PersonController {
    @Autowired private PersonRepository personRepository;

    @GetMapping("/")
    public List<Person> findAll(){
        return personRepository.findAll();
    }

    @GetMapping("/create/")
    public List<Person> create(){
        personRepository.save(new Person("anonymous-" + ThreadLocalRandom.current().nextInt()));
        return personRepository.findAll();
    }
}
