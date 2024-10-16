package Dao;

import Model.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Stream;

public class RoomDao {
    public static boolean addRoom() {
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
            String sql = "WITH Utilities_CTE AS (\n" +
                    "    SELECT\n" +
                    "        r.id AS room_id,\n" +
                    "        STRING_AGG(CAST(u.id AS NVARCHAR), ', ') AS utility_ids,\n" +
                    "        STRING_AGG(u.name, ', ') AS utility_names\n" +
                    "    FROM\n" +
                    "        rooms r\n" +
                    "            JOIN\n" +
                    "        room_has_utilities rhu ON r.id = rhu.room_id\n" +
                    "            JOIN\n" +
                    "        utilities u ON rhu.utility_id = u.id\n" +
                    "    GROUP BY\n" +
                    "        r.id\n" +
                    "),\n" +
                    "     Images_CTE AS (\n" +
                    "         SELECT\n" +
                    "             r.id AS room_id,\n" +
                    "             STRING_AGG(CAST(i.id AS NVARCHAR), ', ') AS image_ids,\n" +
                    "             STRING_AGG(i.url, ', ') AS image_urls\n" +
                    "         FROM\n" +
                    "             rooms r\n" +
                    "                 JOIN\n" +
                    "             room_has_images rhi ON r.id = rhi.room_id\n" +
                    "                 JOIN\n" +
                    "             images i ON rhi.image_id = i.id\n" +
                    "         GROUP BY\n" +
                    "             r.id\n" +
                    "     )\n" +
                    "SELECT\n" +
                    "    r.id,\n" +
                    "    r.hotel_id,\n" +
                    "    r.room_type_id,\n" +
                    "    r.number,\n" +
                    "    r.beds,\n" +
                    "    r.area,\n" +
                    "    r.price,\n" +
                    "    r.is_available,\n" +
                    "    u.utility_ids,\n" +
                    "    u.utility_names,\n" +
                    "    i.image_ids,\n" +
                    "    i.image_urls,\n" +
                    "    room_types.name as room_type_name\n" +
                    "FROM\n" +
                    "    rooms r\n" +
                    "        LEFT JOIN\n" +
                    "    Utilities_CTE u ON r.id = u.room_id\n" +
                    "        LEFT JOIN\n" +
                    "    Images_CTE i ON r.id = i.room_id\n" +
                    "    inner join room_types on r.room_type_id = room_types.id\n" +
                    "WHERE\n" +
                    "        r.hotel_id = ?;";
            Connection connection = DBContext.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
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
                        resultSet.getInt("price"),
                        resultSet.getInt("beds"),
                        resultSet.getFloat("area"),
                        resultSet.getBoolean("is_available"),
                        convert2array(resultSet.getString("utility_ids")),
                        convert2array(resultSet.getString("utility_names")),
                        convert2array(resultSet.getString("image_ids")),
                        convert2array(resultSet.getString("image_urls"))
                ));
            }
            return rooms;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public static boolean updateRoom(String number, String room_type_id, String beds, String area, String price, String id, String hotel_id) {
        return DBContext.executeUpdate("update rooms set number = ?, room_type_id = ?, beds = ?, area = ?, price = ? where id = ? and hotel_id = ?;", new String[]{number, room_type_id, beds, area, price, id, hotel_id});
    }

    public static boolean updateUtilities(String[] utility_ids, String room_id, String hotel_id) {
        StringBuilder sql = new StringBuilder("delete from room_has_utilities where room_id = ? and room_id in (select id from rooms where hotel_id = ?);");
        String[] value1 = new String[]{room_id, hotel_id};
        String[] value2 = new String[utility_ids.length * 2];
        for (int i = 0; i < utility_ids.length; i++) {
            value2[i * 2] = utility_ids[i];
            value2[i * 2 + 1] = room_id;
            sql.append("insert into room_has_utilities(utility_id, room_id) values (?, ?);");
        }
        String[] values = Stream.concat(Arrays.stream(value1), Arrays.stream(value2)).toArray(String[]::new);
        return DBContext.executeUpdate(String.valueOf(sql), values);
    }
    public static boolean updateImagesOfRoom(ArrayList<Integer> images_ids, String images_to_delete, String hotel_id, String room_id){
        try {
            StringBuilder sql;
            if (!images_to_delete.isEmpty()){
                String[] images_to_delete_arr = convert2array(images_to_delete);
                sql = new StringBuilder("delete from room_has_images where image_id in xxx and room_id = ? and room_id in (select id from rooms where hotel_id = ?);");
                StringBuilder replace = new StringBuilder("(");
                for (int i = 0; i < images_to_delete_arr.length; i++) {
                    if (i == images_to_delete_arr.length -1 ){
                        replace.append("?");
                    } else {
                        replace.append("?").append(", ");
                    }
                }
                replace.append(")");
                sql = new StringBuilder(sql.toString().replace("xxx", replace.toString()));
                String[] value2 = new String[]{room_id, hotel_id};
                DBContext.executeUpdate(sql.toString(), Stream.concat(Arrays.stream(images_to_delete_arr), Arrays.stream(value2)).toArray(String[]::new));
            }
            if (!images_ids.isEmpty()){
                sql = new StringBuilder();
                String[] value = new String[images_ids.size()*2];
                for (int i = 0; i < images_ids.size(); i++) {
                    sql.append("insert into room_has_images(room_id, image_id) values (?, ?);");
                    value[i*2] = room_id;
                    value[i*2+1] = String.valueOf(images_ids.get(i));
                }
                DBContext.executeUpdate(String.valueOf(sql), value);
            }
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public static ArrayList<Room> search(String query, String[] utility_ids, String price_from, String price_to){
        return new ArrayList<>();
    }
}
