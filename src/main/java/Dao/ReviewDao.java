package Dao;

import Model.Review;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDao {
    public static boolean addReview(String booking_id, String customer_id, String rate, String comment){
        return DBContext.executeUpdate("insert into reviews(customer_id, booking_id, rating, comment) VALUES (?, ?, ?, ?);", new String[]{customer_id, booking_id, rate, comment});
    }
    public static boolean updateReview(String booking_id, String customer_id, String rate, String comment, String review_id){
        return DBContext.executeUpdate("update reviews set rating = ?, comment = ? where booking_id = ? and customer_id = ? and id = ?;", new String[]{rate, comment, booking_id, customer_id, review_id});
    }
    public static ArrayList<Review> getAllReviewsOfARoomType(String room_type_id){
        try {
            String sql = "select reviews.*, customers.name as customer_name, customers.avatar as customer_avatar\n" +
                    "from reviews\n" +
                    "         inner join bookings on reviews.booking_id = bookings.id\n" +
                    "         inner join rooms on bookings.room_id = rooms.id\n" +
                    "         inner join customers on bookings.customer_id = customers.id\n" +
                    "where rooms.room_type_id = ?";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, room_type_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Review> reviews = new ArrayList<>();
            while (resultSet.next()) {
                reviews.add(new Review(
                        resultSet.getInt("id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("booking_id"),
                        resultSet.getInt("rating"),
                        resultSet.getString("comment"),
                        resultSet.getTimestamp("created_at"),
                        resultSet.getString("customer_name"),
                        resultSet.getString("customer_avatar")
                ));
            }
            return reviews;
        } catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public static ArrayList<Review> getAllReviewOfAHotel(String hotelId) {
        try {
            String sql = "select reviews.*, customers.name as customer_name, customers.avatar as customer_avatar\n" +
                    "from reviews\n" +
                    "         inner join bookings on reviews.booking_id = bookings.id\n" +
                    "         inner join rooms on bookings.room_id = rooms.id\n" +
                    "         inner join customers on bookings.customer_id = customers.id\n" +
                    "where rooms.hotel_id = ?";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, hotelId);
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Review> reviews = new ArrayList<>();
            while (resultSet.next()) {
                reviews.add(new Review(
                        resultSet.getInt("id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("booking_id"),
                        resultSet.getInt("rating"),
                        resultSet.getString("comment"),
                        resultSet.getTimestamp("created_at"),
                        resultSet.getString("customer_name"),
                        resultSet.getString("customer_avatar")
                ));
            }
            return reviews;
        } catch (Exception e){
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
