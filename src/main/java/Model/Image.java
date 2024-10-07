package Model;

import java.util.Date;

public class Image {
    public int id;
    public int hotel_id;
    public String url;
    public Date created_at;

    public Image(int id, int hotel_id, String url, Date created_at) {
        this.id = id;
        this.hotel_id = hotel_id;
        this.url = url;
        this.created_at = created_at;
    }
}
