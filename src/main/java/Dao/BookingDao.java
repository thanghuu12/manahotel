package Dao;

import Model.Booking;
import Model.BookingStatus;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BookingDao {
    public static ArrayList<Booking> getBookingsOfCustomer(String customer_id) {
        try {
            String sql = "select bookings.*, room_types.price as temp_price, room_types.name as room_type_name, hotels.name as hotel_name, room_types.id as room_type_id, hotels.id as hotel_id from bookings inner join rooms on bookings.room_id = rooms.id inner join room_types on rooms.room_type_id = room_types.id inner join hotels on room_types.hotel_id = hotels.id where customer_id = ?;";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, customer_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Booking> bookings = new ArrayList<>();
            while (resultSet.next()) {
                bookings.add(new Booking(
                        resultSet.getInt("id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("room_id"),
                        resultSet.getInt("payment_id"),
                        resultSet.getTimestamp("check_in_date"),
                        resultSet.getTimestamp("check_out_date"),
                        resultSet.getInt("price"),
                        BookingStatus.valueOf(resultSet.getString("status")),
                        resultSet.getTimestamp("created_at"),
                        resultSet.getTimestamp("updated_at"),
                        resultSet.getString("room_type_name"),
                        resultSet.getString("hotel_name"),
                        resultSet.getString("room_type_id"),
                        resultSet.getString("hotel_id"),
                        resultSet.getInt("temp_price")
                ));
            }
            return bookings;
        }catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    public static Booking getBookingWithId(String booking_id){
        try {
            String sql = "select bookings.*, room_types.price as temp_price, room_types.name as room_type_name, hotels.name as hotel_name, room_types.id as room_type_id, hotels.id as hotel_id from bookings inner join rooms on bookings.room_id = rooms.id inner join room_types on rooms.room_type_id = room_types.id inner join hotels on room_types.hotel_id = hotels.id where bookings.id = ?;";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, booking_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return new Booking(
                        resultSet.getInt("id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("room_id"),
                        resultSet.getInt("payment_id"),
                        resultSet.getTimestamp("check_in_date"),
                        resultSet.getTimestamp("check_out_date"),
                        resultSet.getInt("price"),
                        BookingStatus.valueOf(resultSet.getString("status")),
                        resultSet.getTimestamp("created_at"),
                        resultSet.getTimestamp("updated_at"),
                        resultSet.getString("room_type_name"),
                        resultSet.getString("hotel_name"),
                        resultSet.getString("room_type_id"),
                        resultSet.getString("hotel_id"),
                        resultSet.getInt("temp_price")
                );
            }
            return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
