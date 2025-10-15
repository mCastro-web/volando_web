package org.utec.volandouy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan(basePackages = "org.utec.volandouy.web.servlets")
public class VolandouyApplication {
    public static void main(String[] args) {
        SpringApplication.run(VolandouyApplication.class, args);
    }
}
