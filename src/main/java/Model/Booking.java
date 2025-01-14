package Model;

import java.util.Date;

public class Booking {
    public int id;
    public int customer_id;
    public int room_id;
    public int payment_id;
    public Date check_in_date;
    public Date check_out_date;
    public int price;
    public BookingStatus status;
    public Date created_at;
    public Date updated_at;
    public String room_type_name;
    public String room_type_id;
    public String hotel_name;
    public String hotel_id;
    public int temp_price;
    public Review review;

    public Booking(int id, int customer_id, int room_id, int payment_id, Date check_in_date, Date check_out_date, int price, BookingStatus status, Date created_at, Date updated_at) {
        this.id = id;
        this.customer_id = customer_id;
        this.room_id = room_id;
        this.payment_id = payment_id;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.price = price;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public Booking(int id, int customer_id, int room_id, int payment_id, Date check_in_date, Date check_out_date, int price, BookingStatus status, Date created_at, Date updated_at, String room_type_name, String room_type_id, String hotel_name, String hotel_id, int temp_price) {
        this.id = id;
        this.customer_id = customer_id;
        this.room_id = room_id;
        this.payment_id = payment_id;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.price = price;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.room_type_name = room_type_name;
        this.room_type_id = room_type_id;
        this.hotel_name = hotel_name;
        this.hotel_id = hotel_id;
        this.temp_price = temp_price;
    }

    public Booking(int id, int customer_id, int room_id, int payment_id, Date check_in_date, Date check_out_date, int price, BookingStatus status, Date created_at, Date updated_at, String room_type_name, String room_type_id, String hotel_name, String hotel_id, int temp_price, Review review) {
        this.id = id;
        this.customer_id = customer_id;
        this.room_id = room_id;
        this.payment_id = payment_id;
        this.check_in_date = check_in_date;
        this.check_out_date = check_out_date;
        this.price = price;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.room_type_name = room_type_name;
        this.room_type_id = room_type_id;
        this.hotel_name = hotel_name;
        this.hotel_id = hotel_id;
        this.temp_price = temp_price;
        this.review = review;
    }
}
