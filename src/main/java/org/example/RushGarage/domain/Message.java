package org.example.RushGarage.domain;

import javax.persistence.*;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    private String cost;
    private String text;
    private String tag;
    private String datestart;
    private int duration;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_id")
    private Car car;

    private String filename;

    public Message() {
    }

    public Message(String text, String tag, User user, Car car, String datestart, int duration) {
        this.author = user;
        this.text = text;
        this.tag = tag;
        this.car = car;
        this.datestart = datestart;
        this.duration = duration;
    }

    //public Message(String text, String tag, User user) {
    //    this.author = user;
    //    this.text = text;
    //    this.tag = tag;
    //    this.car = car;
    //}


    public String getAuthorName (){
        return author != null ? author.getUsername() : "<none>";
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
        this.cost = car.getCost();
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getDatestart() {
        return datestart;
    }

    public void setDatestart(String datestart) {
        this.datestart = datestart;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getCost() {
        cost = car.getCost();
        return cost;
    }
}
