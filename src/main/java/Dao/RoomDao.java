package Dao;

import Model.BookingStatus;
import Model.Room;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RoomDao {
    public static ArrayList<String> generateRange(String x, String y) {
        int start = Integer.parseInt(x);
        int end = Integer.parseInt(y);
        ArrayList<String> range = new ArrayList<>();
        for (int i = start; i <= end; i++) {
            range.add(String.valueOf(i));
        }
        return range;
    }

    public static boolean addRoom(String room_type_id, String from, String to, String hotel_id) {
        if (to == null) {
            DBContext.executeUpdate("insert into rooms(hotel_id, number, room_type_id, is_available) VALUES (?, ?, ?, ?);", new String[]{hotel_id, from, room_type_id, "true"});
        } else {
            ArrayList<String> range = generateRange(from, to);
            for (int i = 0; i < range.size(); i++) {
                DBContext.executeUpdate("insert into rooms(hotel_id, number, room_type_id, is_available) VALUES (?, ?, ?, ?);", new String[]{hotel_id, range.get(i), room_type_id, "true"});
            }
        }
        return true;
    }

    public static String[] convert2array(String input) {
        if (input == null || input.isEmpty()) {
            return new String[0];
        }
        String[] result = input.split(",");
        for (int i = 0; i < result.length; i++) {
            result[i] = result[i].trim();
        }
        return result;
    }

    public static ArrayList<Room> getAllRoomsOfAHotel(String hotel_id) {
        try {
            String sql = "select rooms.*, room_types.name as room_type_name from rooms inner join room_types on rooms.room_type_id = room_types.id where rooms.hotel_id = ?";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, hotel_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Room> rooms = new ArrayList<>();
            while (resultSet.next()) {
                rooms.add(new Room(
                        resultSet.getInt("id"),
                        resultSet.getInt("hotel_id"),
                        resultSet.getString("number"),
                        resultSet.getInt("room_type_id"),
                        resultSet.getString("room_type_name"),
                        resultSet.getBoolean("is_available")
                ));
            }
            return rooms;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public static boolean updateRoom(String room_id, String room_type_id, String number, String hotel_id) {
        return DBContext.executeUpdate("update rooms set number = ?, room_type_id = ? where id = ? and hotel_id = ?;", new String[]{number, room_type_id, room_id, hotel_id});
    }
    public static ArrayList<Room> getAvailableRoom(String from_date, String to_date, String room_type_id) {
        try {
            String sql = "select rooms.* from rooms inner join room_types on rooms.room_type_id = room_types.id where room_type_id = ? and rooms.id not in (select bookings.room_id from bookings where payment_id is not null and check_in_date >= ? and check_out_date <= ?);";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, room_type_id);
            preparedStatement.setString(2, from_date);
            preparedStatement.setString(3, to_date);
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Room> rooms = new ArrayList<>();
            while (resultSet.next()) {
                rooms.add(new Room(
                        resultSet.getInt("id"),
                        resultSet.getInt("hotel_id"),
                        resultSet.getString("number"),
                        resultSet.getInt("room_type_id"),
                        resultSet.getBoolean("is_available")
                ));
            }
            return rooms;
        } catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    public static boolean bookARoom(String room_id, String from_date, String to_date, String room_type_id, String customer_id){
        try {
            ArrayList<Room> rooms = getAvailableRoom(from_date, to_date, room_type_id);
            boolean result = false;
            for (int i = 0; i < rooms.size(); i++) {
                if (rooms.get(i).id == Integer.parseInt(room_id)) {
                    result = true;
                }
            }
            if (result){
                String sql = "insert into bookings(customer_id, room_id, payment_id, check_in_date, check_out_date, price, status) VALUES (?, ?, null, ?, ?,null, ?);";
                return DBContext.executeUpdate(sql, new String[]{customer_id, room_id, from_date, to_date, BookingStatus.NOT_PAID.text});
            }
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
