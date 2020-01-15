package org.example.RushGarage.controller;

import org.example.RushGarage.domain.Message;
import org.example.RushGarage.domain.User;
import org.example.RushGarage.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    public Iterable<Message> FilterMessagesForUser(User user, Iterable<Message> messages) {
        ArrayList<Message> filtredMessages = new ArrayList<Message>();
        for (Message message : messages) {
            if (message.getAuthor().getUsername().equals(user.getUsername())){
                filtredMessages.add(message);
            }
        }
        return filtredMessages;
    }

    @GetMapping("/main")
    public String main(
            @AuthenticationPrincipal User user,
            @RequestParam(required = false, defaultValue = "") String filter, Model model
            ){
        Iterable<Message> messages;

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        }else {
            messages = messageRepo.findAll();
        }
        if (!user.isAdmin()){
            messages = FilterMessagesForUser(user, messages);
        }
        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        return "main";
    }

    @GetMapping("approve/{message}")
    public String messageApprove(@PathVariable Message message, Model model) {
        model.addAttribute("message", message);

        if (messageRepo.existsById(message.getId())) {
            Optional<Message> m = messageRepo.findById(message.getId());
            Message curentMessage = m.get();
            curentMessage.setTag("approve");
            messageRepo.save(curentMessage);
        }

        return "redirect:/main";
    }

    @GetMapping("reject/{message}")
    public String rejectApprove(@PathVariable Message message, Model model) {
        model.addAttribute("message", message);

        if (messageRepo.existsById(message.getId())) {
            Optional<Message> m = messageRepo.findById(message.getId());
            Message curentMessage = m.get();
            curentMessage.setTag("rejected");
            messageRepo.save(curentMessage);
        }

        return "redirect:/main";
    }

    @GetMapping("cancel/{message}")
    public String messageCancel(@PathVariable Message message, Model model) {
        model.addAttribute("message", message);

        Optional<Message> m = messageRepo.findById(message.getId());
        Message curentMessage = m.get();
        curentMessage.setTag("canceled");
        messageRepo.save(curentMessage);

        return "redirect:/main";
    }

    @GetMapping("delete/{message}")
    public String messageDelete(@PathVariable Message message, Model model) {
        model.addAttribute("message", message);

        messageRepo.deleteById(message.getId());

        return "redirect:/main";
    }

}