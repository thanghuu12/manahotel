package Model;

public class Room {
    public int id;
    public String number;
    public int room_type_id;
    public int utility_id;
    public int price;
    public boolean is_available;

    public Room(int id, String number, int room_type_id, int utility_id, int price, boolean is_available) {
        this.id = id;
        this.number = number;
        this.room_type_id = room_type_id;
        this.utility_id = utility_id;
        this.price = price;
        this.is_available = is_available;
    }
}
