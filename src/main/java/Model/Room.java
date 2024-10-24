package Model;

public class Room {
    public int id;
    public int hotel_id;
    public String number;
    public int room_type_id;
    public String room_type_name;
    public boolean is_available;

    public Room(int id, int hotel_id, String number, int room_type_id, String room_type_name, boolean is_available) {
        this.id = id;
        this.hotel_id = hotel_id;
        this.number = number;
        this.room_type_id = room_type_id;
        this.room_type_name = room_type_name;
        this.is_available = is_available;
    }

    public Room(int id, int hotel_id, String number, int room_type_id, boolean is_available) {
        this.id = id;
        this.hotel_id = hotel_id;
        this.number = number;
        this.room_type_id = room_type_id;
        this.is_available = is_available;
    }
}
