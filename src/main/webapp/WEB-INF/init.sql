DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS room_has_images;
DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS room_has_utilities;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS utilities;
DROP TABLE IF EXISTS room_types;
DROP TABLE IF EXISTS hotels;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS customers;
create table customers
(
    id          int primary key identity,
    name        nvarchar( max),
    email       nvarchar( max),
    phone       nvarchar( max),
    dob         date,
    avatar      nvarchar( max),
    password    nvarchar( max),
    is_verified bit,
    token       nvarchar( max),
    created_at  datetime default current_timestamp,
);
insert into customers(name, email, phone, dob, avatar, password, is_verified)
values (N'Khách hàng', 'customer@gmail.com', '0123456789', '2002-08-05', 'assets/img/profile-img.jpg',
        '$2a$10$ldHKnLQQLDUy./8cXjzRhOwJ4VEwpDba77KD5otpxbflZivA7YFkW', 'true')
create table admins
(
    id         int primary key identity,
    name       nvarchar( max),
    username   nvarchar( max),
    avatar     nvarchar( max),
    password   nvarchar( max),
    created_at datetime default current_timestamp,
);
insert into admins(name, username, password, avatar)
values (N'Admin đây :))', 'admin', '$2a$10$90GZEeepyVAEO93J0CO5Qu8A8.1p4N7ru1v14JBfFSHTM4Cxpwusa',
        'assets/img/admin-avatar.jpg') -- password : Admin12345
create table hotels
(
    id          int primary key identity,
    name        nvarchar( max),
    email       nvarchar( max),
    address     nvarchar( max),
    gg_map_link nvarchar( max),
    avatar      nvarchar( max),
    password    nvarchar( max),
    created_at  datetime default current_timestamp,
);
insert into hotels(name, email, address, gg_map_link, avatar, password)
values ('Novotel', 'novotel@gmail.com', N'36 Bạch Đằng, Thạch Thang, Hải Châu, Đà Nẵng',
        '<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15335.072189020671!2d108.2237843!3d16.077522!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142183afab4a42d%3A0xd52dbe9e28e83835!2zS2jDoWNoIHPhuqFuIE5vdm90ZWwgxJDDoCBO4bq1bmc!5e0!3m2!1svi!2s!4v1728454675497!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>',
        'assets/uploads/novotel.jpg', '$2a$10$ldHKnLQQLDUy./8cXjzRhOwJ4VEwpDba77KD5otpxbflZivA7YFkW') -- password:123456
create table room_types
(
    id          int primary key identity,
    hotel_id    int foreign key references hotels (id),
    name        nvarchar( max),
    description nvarchar( max),
);

create table utilities
(
    id   int primary key identity,
    name nvarchar( max),
);
insert into utilities(name)
values ('free wifi');
insert into utilities(name)
values (N'nhà hàng');
insert into utilities(name)
values (N'bữa sáng miễn phí');
insert into utilities(name)
values (N'xe đưa đón sân bay');
insert into utilities(name)
values (N'gần biển');
insert into utilities(name)
values (N'gần trung tâm');

create table rooms
(
    id           int primary key identity,
    hotel_id     int foreign key references hotels(id),
    number       nvarchar( max),
    room_type_id int foreign key references room_types (id),
    beds int,
    area float,
    price        int,
    is_available bit,
);
create table room_has_utilities
(
    id int primary key identity,
    utility_id   int foreign key references utilities (id),
    room_id int foreign key references rooms(id)
);
create table images
(
    id         int primary key identity,
    url        nvarchar( max),
);
create table room_has_images
(
    id       int primary key identity,
    room_id  int foreign key references rooms (id),
    image_id int foreign key references images (id),
);
create table payments
(
    id                int primary key identity,
    amount            int,
    txnRef            nvarchar( max),
    orderInfo         nvarchar( max),
    bankCode          nvarchar( max),
    transactionNo     nvarchar( max),
    transactionStatus nvarchar( max),
    cardType          nvarchar( max),
    bankTranNo        nvarchar( max),
    created_at        datetime default current_timestamp,
    paid_at           datetime,
);
create table orders
(
    id             int primary key identity,
    customer_id    int foreign key references customers (id),
    room_id        int foreign key references rooms (id),
    payment_id     int foreign key references payments (id),
    check_in_date  date,
    check_out_date date,
    price          int,
    status         VARCHAR(20),
    created_at     datetime default current_timestamp,
    updated_at     datetime,
);
create table reviews
(
    id          int primary key identity,
    customer_id int foreign key references customers (id),
    order_id    int foreign key references orders (id),
    rating      int check (rating between 1 and 5),
    comment     nvarchar( max),
    created_at  datetime default current_timestamp
);
-- 123456:$2a$10$ldHKnLQQLDUy./8cXjzRhOwJ4VEwpDba77KD5otpxbflZivA7YFkW