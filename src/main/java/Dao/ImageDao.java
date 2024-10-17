package Dao;

import Model.Image;
import Model.Utility;
import com.google.gson.Gson;
import org.checkerframework.checker.units.qual.A;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ImageDao {
    public static boolean addImage(String hotel_id, String url){
        return DBContext.executeUpdate("insert into images(hotel_id, url) values (?, ?)", new String[]{hotel_id, url});
    }
    public static boolean updateImage(String id, String hotel_id, String new_url){
        return DBContext.executeUpdate("update images set url = ? where id = ? and hotel_id = ?", new String[]{new_url, id, hotel_id});
    }
    public static ArrayList<Image> getAllImagesOfHotel(String hotel_id){
        try {
            Connection connection = DBContext.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from utilities");
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Image> images = new ArrayList<>();
            while (resultSet.next()){
                images.add(new Image(
                        resultSet.getInt("id"),
                        resultSet.getString("url")
                ));
            }
            return images;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
