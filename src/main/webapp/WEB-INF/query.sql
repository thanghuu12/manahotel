insert into customers(name, email, phone, dob, avatar, password, is_verified, token) values (?, ?, ?, ?, ?, ?, ?, ?)
update customers set is_verified = 'true', token = null where token = ?
select * from customers where email = ?
select * from customers where phone = ?
