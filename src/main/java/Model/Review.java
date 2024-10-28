package Model;

import java.util.Date;

public class Review {
    public int id;
    public int customer_id;
    public int booking_id;
    public int rating;
    public String comment;
    public Date created_at;
    public String customer_name;
    public String customer_avatar;

    public Review(int id, int customer_id, int booking_id, int rating, String comment, Date created_at) {
        this.id = id;
        this.customer_id = customer_id;
        this.booking_id = booking_id;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
    }

    public Review(int id, int customer_id, int booking_id, int rating, String comment, Date created_at, String customer_name, String customer_avatar) {
        this.id = id;
        this.customer_id = customer_id;
        this.booking_id = booking_id;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
        this.customer_name = customer_name;
        this.customer_avatar = customer_avatar;
    }
}
