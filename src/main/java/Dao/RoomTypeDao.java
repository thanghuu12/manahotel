package Dao;

import Model.RoomType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RoomTypeDao {
    public static ArrayList<RoomType> getAllRoomTypesOfAHotel(int id){
        try {
            Connection connection = DBContext.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from room_types where hotel_id = ?");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<RoomType> roomTypes = new ArrayList<>();
            while (resultSet.next()){
                roomTypes.add(new RoomType(
                        resultSet.getInt("id"),
                        resultSet.getInt("hotel_id"),
                        resultSet.getString("name"),
                        resultSet.getString("description")
                ));
            }
            return roomTypes;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public static boolean updateRoomType(String name, String description, String hotel_id, String id){
        return DBContext.executeUpdate("update room_types set name = ?, description = ? where hotel_id = ? and id = ?", new String[]{name, description, hotel_id, id});
    }
    public static boolean addRoomType(String name, String description, String hotel_id){
        return DBContext.executeUpdate("insert into room_types(hotel_id, name, description) values (?, ?, ?)", new String[]{hotel_id, name, description});
    }
}
