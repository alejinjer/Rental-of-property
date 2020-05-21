package app.Apartment;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "apartments")
@Data
public class Apartment {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;
    private Integer flats_number;
    private Integer cost;
    private String description;
    private String address;
    private String img_url;

    public Apartment() {
    }

    public Apartment(Integer flats_number, Integer cost, String description, String address, String img_url) {
        this.flats_number = flats_number;
        this.cost = cost;
        this.description = description;
        this.address = address;
        this.img_url = img_url;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFlats_number() {
        return flats_number;
    }

    public void setFlats_number(Integer flats_number) {
        this.flats_number = flats_number;
    }

    public Integer getCost() {
        return cost;
    }

    public void setCost(Integer cost) {
        this.cost = cost;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }
}
