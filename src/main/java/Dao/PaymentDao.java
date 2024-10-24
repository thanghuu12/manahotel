package Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class PaymentDao {
    public static boolean handleVNPayResult(String amount, String paid_at, String vnp_TransactionStatus, String vnp_TransactionNo, String vnp_BankTranNo, String vnp_CardType, String vnp_BankCode, String vnp_OrderInfo, String vnp_TxnRef, String customer_id){
        try {
            if (!checkPaymentExist(amount, vnp_TxnRef, vnp_OrderInfo)){
                String sql = "insert into payments(customer_id, amount, txnRef, orderInfo, bankCode, transactionNo, transactionStatus, cardType, bankTranNo, paid_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
                int payment_id = DBContext.insertGetLastId(sql, new String[]{customer_id, amount, vnp_TxnRef, vnp_OrderInfo, vnp_BankCode, vnp_TransactionNo, vnp_TransactionStatus, vnp_CardType, vnp_BankTranNo, paid_at});
                String booking_id = vnp_OrderInfo.split("\\|")[1];
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter sqlDateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                String formattedDateTime = now.format(sqlDateTimeFormatter);
                return DBContext.executeUpdate("update bookings set payment_id = ?, price = ?, updated_at = ? where id = ?", new String[]{String.valueOf(payment_id), amount, formattedDateTime, booking_id});
            } else {
                return false;
            }

        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public static boolean checkPaymentExist(String amount, String vnp_TxnRef, String vnp_OrderInfo){
        try {
            String sql = "select * from payments where amount = ? and txnRef = ? and orderInfo = ?;";
            PreparedStatement preparedStatement = DBContext.getConnection().prepareStatement(sql);
            preparedStatement.setString(1, amount);
            preparedStatement.setString(2, vnp_TxnRef);
            preparedStatement.setString(3, vnp_OrderInfo);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet.next();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
