create table customers
(
    id          int primary key identity,
    name        nvarchar(max),
    email       nvarchar(max),
    phone       nvarchar(max),
    dob         date,
    avatar      nvarchar(max),
    password    nvarchar(max),
    is_verified bit,
    token       nvarchar(max),
    created_at  datetime default current_timestamp,
);
create table admins
(
    id         int primary key identity,
    name       nvarchar(max),
    username   nvarchar(max),
    avatar     nvarchar(max),
    password   nvarchar(max),
    created_at datetime default current_timestamp,
);
insert into admins(name, username, password, avatar)
values (N'Admin đây :))', 'admin', '$2a$10$90GZEeepyVAEO93J0CO5Qu8A8.1p4N7ru1v14JBfFSHTM4Cxpwusa', 'assets/img/admin-avatar.jpg') -- password : Admin12345
create table hotels
(
    id         int primary key identity,
    name       nvarchar(max),
    email      nvarchar(max),
    avatar     nvarchar(max),
    password   nvarchar(max),
    created_at datetime default current_timestamp,
);
create table room_types
(
    id          int primary key identity,
    hotel_id    int foreign key references hotels (id),
    name        nvarchar(max),
    description nvarchar(max),
);
create table utilities
(
    id int primary key identity,
    name nvarchar(max),
);
create table rooms
(
    id           int primary key identity,
    number       int,
    name         nvarchar(max),
    room_type_id int foreign key references room_types (id),
    utility_id int foreign key references utilities (id),
    price        int,
    is_available bit,
);
create table images
(
    id         int primary key identity,
    hotel_id   int foreign key references hotels (id),
    url      nvarchar(max),
    created_at datetime default current_timestamp,
);
create table room_has_image
(
    id       int primary key identity,
    room_id  int foreign key references rooms (id),
    image_id int foreign key references images (id),
);
create table payments
(
    id                int primary key identity,
    amount            int,
    txnRef            nvarchar(max),
    orderInfo         nvarchar(max),
    bankCode          nvarchar(max),
    transactionNo     nvarchar(max),
    transactionStatus nvarchar(max),
    cardType          nvarchar(max),
    bankTranNo        nvarchar(max),
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
    comment     nvarchar(max),
    created_at  datetime default current_timestamp
);
-- use this to drop all tables
/*drop table reviews;
drop table orders;
drop table payments;
drop table room_has_image;
drop table rooms;
drop table utilities;
drop table room_types;
drop table images;
drop table hotels;
drop table admins;
drop table customers;*/