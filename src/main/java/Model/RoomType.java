package Model;

public class RoomType {
    public int id;
    public int hotel_id;
    public String name;
    public String description;

    public RoomType(int id, int hotel_id, String name, String description) {
        this.id = id;
        this.hotel_id = hotel_id;
        this.name = name;
        this.description = description;
    }
}
