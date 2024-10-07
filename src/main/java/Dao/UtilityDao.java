package Dao;

import Model.Utility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UtilityDao {
    public static boolean addUtility(String name){
        return DBContext.executeUpdate("insert into utilities(name) values (?)", new String[]{name});
    }
    public static boolean deleteUtility(String id){
        return DBContext.executeUpdate("delete from utilities where id = ?", new String[]{id});
    }
    public static boolean updateUtility(String name, String id){
        return DBContext.executeUpdate("update utilities set name = ? where id = ?", new String[]{name, id});
    }
    public static ArrayList<Utility> getAllUtilities(){
        try {
            Connection connection = DBContext.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from utilities");
            ResultSet resultSet = preparedStatement.executeQuery();
            ArrayList<Utility> utilities = new ArrayList<>();
            while (resultSet.next()){
                utilities.add(new Utility(
                    resultSet.getInt("id"),
                    resultSet.getString("name")
                ));
            }
            return utilities;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
