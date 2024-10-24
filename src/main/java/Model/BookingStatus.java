package Model;

public enum BookingStatus {
    NOT_PAID("NOT_PAID"),
    CANCELED("CANCELED"),
    PAID("PAID");

    public final String text;
    BookingStatus(String s) {
        this.text = s;
    }
    public String toString() {
        switch (this.text){
            case "NOT_PAID":
                return "Chưa thanh toán";
            case "CANCELED":
                return "Đã hủy";
            case "PAID":
                return "Đã thanh toán";
            default:
                return null;
        }
    }
}
