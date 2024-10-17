package Util;

import com.google.gson.Gson;

public class Json {
    public static String toJson(Object o){
        Gson gson = new Gson();
        return gson.toJson(o);
    }
}
