create table customers(
  id int primary key identity ,
  name nvarchar(max),
  email nvarchar(max),
  phone nvarchar(max),
  dob date,
  avatar nvarchar(max),
  password nvarchar(max),
  is_verified bit,
  token nvarchar(max)
);