package Model;

public class Utility {
    public int id;
    public String name;

    public Utility(int id, String name) {
        this.id = id;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Utility{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}' + "\n";
    }
}
