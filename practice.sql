use demo;

create table Products(
	Id int primary key auto_increment,
    productCode varchar(50) not null,
    productName varchar(50) not null,
    productPrice decimal(10,2) not null,
    productAmount int not null,
    productDescription varchar(100),
    productStatus bit not null
);

insert into Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
values
('P1', 'M16', 2000, 20, 'No description', 1),
('P2', 'Car-15', 2000, 20, 'No description', 1),
('P3', 'M18', 4000, 20, 'No description', 1),
('P4', 'M4A1', 5000, 20, 'No description', 1),
('P5', 'M4A4', 8000, 20, 'No description', 1);

-- Tao unique index tren bang Product o cot productCode
create unique index idx_productCode on Products(productCode);

-- Tao composite index tren bang Product o 2 cot ProductName va ProductPrice
create index idx_productName_Price on Products(productName, productPrice);

-- Su dung cau lenh explain de kiem tra hoat dong cua cau lenh SQL
explain select * from Products where productCode = 'P1';
explain select * from Products where productName = 'M16' and productPrice = 2000;

-- Tao view
create view ProductView as
select productCode, productName, productPrice, productStatus
from Products;

-- Xem du lieu tu view
select * from ProductView;

-- Sua doi view (su dung create or replace)
create or replace view ProductView as
select productCode, productName, productPrice, productStatus, productAmount
from Products;

-- Xoa view
drop view ProductView;

-- Tao Store Procedure
delimiter $$
create procedure GetAllProduct()
begin
	select * from Products;
end $$
delimiter ;

-- Goi Procedure
call GetAllProduct();

-- Procedure them san pham moi
delimiter $$
create procedure AddProduct(
	in p_productCode varchar(50),
    in p_productName varchar(100), 
    in p_productPrice decimal(10,2),
    in p_productAmount int,
    in p_productDescription varchar(100),
    in p_productStatus bit
)
begin
	insert into Products(productCode, productName, productPrice, productAmount,
    productDescription, productStatus)
    values
    (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription,
    p_productStatus);
end$$
delimiter ;

-- Goi procedure
call AddProduct('P06', 'M14', 2000, 20, 'No description', 1);

-- Procedure sua san pham theo Id
delimiter $$
create procedure UpdateProduct(
	in p_Id int,
    in p_productName varchar(50),
    in p_productPrice decimal(10,2),
    in p_productAmount int, 
    in p_productDescription varchar(100),
    in p_productStatus bit
)
begin
	update Products
    set
		productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
	where Id = p_Id;
end$$
delimiter ;

-- call Proc
call UpdateProduct(1, 'M1 carbine', 1000, 50, 'Old weapon', 0);

-- Proc Xoa san pham theo ID
delimiter $$
create procedure DeleteProduct(
	in p_Id int
)
begin
	delete from Products where Id = p_Id;
end $$
delimiter ;

-- call Proc
call DeleteProduct(5);

-- Kiem tra index da tao
show indexes from Products;




