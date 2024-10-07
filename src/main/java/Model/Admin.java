package Model;

import java.util.Date;

public class Admin {
    public int id;
    public String username;
    public String name;
    public String avatar;
    public String password;
    public Date created_at;

    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    public Admin(int id, String username, String name, String avatar, Date created_at) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.avatar = avatar;
        this.created_at = created_at;
    }
}
