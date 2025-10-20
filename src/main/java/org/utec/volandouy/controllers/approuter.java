package org.utec.volandouy.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class approuter {
    
    @GetMapping("/")
    public String index() {
        return "index"; 
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/login")
    public String loginPost() {
        return "index"; 
    }

    @GetMapping("/listUser") 
    public String listUser() {
        return "listUser"; 
    }

    @GetMapping("/modUser") 
    public String modUser() {
        return "modUser"; 
    }


    @GetMapping("/altavuelo") 
    public String altavuelo() {
        return "altavuelo"; 
    }

    @GetMapping("/consultaVuelo") 
    public String consultaVuelo() {
        return "consultaVuelo"; 
    }

        @PostMapping("/altaRutaVuelo")
    public String AltaRutaVuelo() {
        return "altaRutaVuelo"; 
    }

    @GetMapping("/registerindex")
    public String registerindex() {
        return "registerindex";
    }

    @GetMapping("/registeraerolinea")
    public String registeraerolinea() {
        return "registeraerolinea";
    }

    @GetMapping("/registercliente")
    public String registercliente() {
        return "registercliente";
    }

    @GetMapping("/testServlet")
    public String testServlet() {
        return "testServlet";
    }
}