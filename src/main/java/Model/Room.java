package Model;

public class Room {
    public int id;
    public int hotel_id;
    public String number;
    public int room_type_id;
    public String room_type_name;
    public int price;
    public int beds;
    public float area;
    public boolean is_available;
    public String[] utility_ids;
    public String[] utility_names;
    public String[] image_ids;
    public String[] image_urls;

    public Room(int id, int hotel_id, String number, int room_type_id, String room_type_name, int price, int beds, float area, boolean is_available, String[] utility_ids, String[] utility_names, String[] image_ids, String[] image_urls) {
        this.id = id;
        this.hotel_id = hotel_id;
        this.number = number;
        this.room_type_id = room_type_id;
        this.room_type_name = room_type_name;
        this.price = price;
        this.beds = beds;
        this.area = area;
        this.is_available = is_available;
        this.utility_ids = utility_ids;
        this.utility_names = utility_names;
        this.image_ids = image_ids;
        this.image_urls = image_urls;
    }
}
