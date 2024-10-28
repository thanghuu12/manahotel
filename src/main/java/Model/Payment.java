package Model;

import java.util.Date;

public class Payment {
    public int id;
    public int customer_id;
    public long amount;
    public String txnRef;
    public String orderInfo;
    public String bankCode;
    public String transactionNo;
    public TransactionStatus transactionStatus;
    public String cardType;
    public String bankTranNo;
    public Date created_at;
    public Date paid_at;
    public int room_id;
    public int room_type_id;

    public Payment(int id, int customer_id, long amount, String txnRef, String orderInfo, String bankCode, String transactionNo, TransactionStatus transactionStatus, String cardType, String bankTranNo, Date created_at, Date paid_at) {
        this.id = id;
        this.customer_id = customer_id;
        this.amount = amount;
        this.txnRef = txnRef;
        this.orderInfo = orderInfo;
        this.bankCode = bankCode;
        this.transactionNo = transactionNo;
        this.transactionStatus = transactionStatus;
        this.cardType = cardType;
        this.bankTranNo = bankTranNo;
        this.created_at = created_at;
        this.paid_at = paid_at;
    }

    public Payment(int id, int customer_id, long amount, String txnRef, String orderInfo, String bankCode, String transactionNo, TransactionStatus transactionStatus, String cardType, String bankTranNo, Date created_at, Date paid_at, int room_id, int room_type_id) {
        this.id = id;
        this.customer_id = customer_id;
        this.amount = amount;
        this.txnRef = txnRef;
        this.orderInfo = orderInfo;
        this.bankCode = bankCode;
        this.transactionNo = transactionNo;
        this.transactionStatus = transactionStatus;
        this.cardType = cardType;
        this.bankTranNo = bankTranNo;
        this.created_at = created_at;
        this.paid_at = paid_at;
        this.room_id = room_id;
        this.room_type_id = room_type_id;
    }
}
