create database assignment;
use assignment


-----------------------------------------------------------
create table Supplier
(
	Sup_ID int primary key,
	Sup_Name nvarchar(255) not null,
	Sup_Phone char(12) Unique,
	Sup_Address nvarchar(255) not null
);

-------------------------------ADD-----------------------------

Insert into Supplier(Sup_ID, Sup_Name, Sup_Phone, Sup_Address)
Values
(1, 'Louis Vuitton', '+33144131111', 'France'),
(2, 'Inditex', '+34981182222', 'Spain'),
(3, 'Kering', '+33144133333', 'France'),
(4, 'H&M Group', '+33144134444', 'Sweden'),
(5, 'Uniqlo', '+33144135555', 'Japan'),
(6, 'Nike', '+33144136666', 'USA'),
(7, 'Adidas', '+33144137777', 'Germany'),
(8, 'Dior', '+33144138888', 'France');

-------------------------------END ADD-----------------------------
	

create Table Product
(
	Pro_Id int primary key,
	Pro_Name nvarchar(255) not null,
	Pro_Quantity int,
	Pro_Price decimal(10,2),
	Sup_ID int foreign key references Supplier(Sup_ID)
);


Insert into Product(Pro_Id, Pro_Name, Pro_Quantity, Pro_Price, Sup_ID)
Values
(1, N'Quần Dior', 30, 8000, 8),
(2, N'Giày Nike', 85, 2200, 6),
(3, N'Váy LV', 65, 1500, 1),
(4, N'Áo H&M', 45, 1600, 4)


--- Calculate Total Price :: Stock Receiving 
--  Add Column in Table
Alter Table Product
Add [Total Purchase] Decimal(10,2)
Update Product set [Total Purchase] = Pro_Quantity * Pro_Price;
select * from Product

-- Delete Column in Table
Alter Table Product
Drop column Total;



-------------------------------END ADD-----------------------------


create table [Product Type]
(
	ProType_ID Int primary key,
	ProType_Name nvarchar(255) not null,
	ProType_Unit nvarchar(25) not null,
	Pro_ID int foreign key references Product(Pro_ID)
	
);

--- Add information Product Type ---
Insert into [Product Type] (ProType_ID, ProType_Name, ProType_Unit, Pro_ID)
Values
(1, N'Quần Dài Nam Lacoste Men', N'Quần', 1),
(2, N'Quần Polo Nam', N'Quần', 1),
(3, N'Áo Hoodie Zip', N'Áo', 4),
(4, N'Áo sơ mi Regular Fit', N'Áo', 4),
(5, N'Giày nike Air Force 1', N'Giày', 3),
(6, N'Đầm ngắn Cocktail', N'Váy', 1);

----UPDATE----
Update [Product Type] set ProType_Unit = N'Đôi' where ProType_ID = 5;
select * from [Product Type]
-------------------------------END ADD-----------------------------


create table Customer 
(
	Cus_ID int identity(1,1) primary key,
	Cus_Name nvarchar(255) not null,
	Cus_Phone char(12) Unique,
	Cus_Address nvarchar(255)
);

Insert into Customer(Cus_Name, Cus_Phone, Cus_Address)
Values
(N'Nguyễn Văn Anh', '0357212148', N'Thanh Hoá'),
(N'Nguyễn Kiều Hoa', '0376644293', N'TPHCM'),
(N'Hoàng Ngọc Mai', '0389784725', N'Hà Nội'),
(N'Nguyễn Hồng Giang', '0394229160', N'Hà Nội'),
(N'Lê Thị Anh', '0392249160', N'Ninh Bình'),
(N'Ngô Thị Kiều Oanh', '0357898999', N'Bình Dương');

Insert into Customer(Cus_Name, Cus_Phone, Cus_Address)
Values
(N'Customer new 1', '0357999948', N'Thanh Hoá'),
(N'Customer new 2', '0897999948', N'TPHCM')


-------------------------------END ADD-----------------------------


create table Employee
(
	Emp_ID int primary key,
	Emp_Name nvarchar(255) not null,
	Emp_DOB date,
	Emp_Phone char(12) Unique,
	Emp_Address nvarchar(255)
);

Insert into Employee(Emp_ID, Emp_Name, Emp_DOB, Emp_Phone, Emp_Address)
values
(1, N'Nguyễn Nhật Nam', '2004-06-15', '0398212180', N'Thanh Hoá'),
(2, N'Nguyễn Thị Thuỳ Dung', '2004-06-15', '0399229066', N'TPHCM'),
(3, N'Nguyễn Thu Phương', '2004-09-18', '0388212188', N'Bình Dương');

-------------------------------END ADD-----------------------------



create table [Bill Order] 
(
	Bill_ID int identity(1,1) primary key,
	Date_Order date,
	Emp_ID int foreign key references Employee(Emp_ID),
	Cus_ID int foreign key references Customer(Cus_ID)
);

Insert into [Bill Order] (Emp_ID, Cus_ID, Date_Order)
Values
(1, 1, '2024-06-14'),
(1, 2, '2024-06-14'),
(2, 3, '2024-06-15'),
(2, 4, '2024-06-16'),
(3, 5, '2024-06-16'),
(3, 6, '2024-06-18');

-------------------------------END ADD-----------------------------


create table [Detail Order]
(
	ProType_ID int foreign key references [Product Type](ProType_ID),
	Bill_ID int foreign key references [Bill Order](Bill_ID),
	Price decimal(10,2) not null,
	Quantity int not null,
	Constraint PK_Detail_Order primary key(ProType_ID, Bill_ID)
);

--- Price Stock delivering 
Insert into [Detail Order] (Bill_ID, ProType_ID, Price, Quantity)
Values
(1, 1, 9000, 2),
(2, 3, 2000, 4), -- Ao
(3, 5, 2500, 3), -- Giay
(4, 6, 1900, 1), -- Vay
(5, 3, 2000, 2), 
(6, 5, 2500, 3);

-------------------------------
--- ADD Column Total Price ----
ALTER TABLE [Detail Order]
ADD [Total Sales] DECIMAL(10, 2);
--- UPDATE Total Price ---
update [Detail Order] Set [Total Sales] = Quantity * Price;
select * from [Detail Order]


--- DELETE Column ---
ALTER TABLE [Detail Order]
Drop column Total;




-------------------------------END ADD-----------------------------



--------------------------------------------------------------------
--------------------------------------------------------------------


--------------------------------------------------------------------
----------------------------SELECT----------------------------------

--1 Different Address of Customer table
Select Cus_Address from Customer;
Select distinct Cus_Address from Customer;

--2 Select all customer from Hà Nội
Select * from Customer where Cus_Address = N'Hà Nội';

--3 Lists the number of customers in each place
Select Cus_Address, Count(Cus_ID) NumbersOfCustomers
From Customer
Group by Cus_Address;

--4 Lists the number of customers in each place
-- But Include Place with more than 1 customer

Select Cus_Address, Count(Cus_ID) NumbersOfCustomers
From Customer
Group by Cus_Address
Having Count(Cus_ID) > 1; 

--5 Sort the customer follow Name by alphabet
Select * from Customer
Order By Cus_Name;

--6 Take the |Bill Order| has the highest Total Sales
Select * from [Detail Order]
Order by [Total Sales] desc;
select top 2 * from [Detail Order]


------------------------------ JOIN -----------------------------------

						--- INNER JOIN ---

--- Create the most detail order table:: We Have: Customer -> Phone -> Name Product Type - Price 
--- Quantity -- Total -- Order Date -- Employee Implement

select c.Cus_Name, c.Cus_Phone, pt.ProType_Name, do.Price, do.Quantity, do.[Total Sales], b.Date_Order, e.Emp_Name
from [Detail Order] as do		

-- join |order detail| with Product Type
inner join [Product Type] as pt
On do.ProType_ID = pt.ProType_ID

-- join |order detail| with bill order
inner join [Bill Order] as b
On do.Bill_ID = b.Bill_ID

-- join :: Bill with Customer
inner join Customer as c
on b.Cus_ID = c.Cus_ID

-- join :: Bill with Employee
inner join Employee as e
on b.Emp_ID = e.Emp_ID

						--- LEFT JOIN ---

--- Tôi vẫn dư ra những khách hàng chưa mua và tôi muốn in ra để sau này có thể dùng để quảng cáo ?
select Cus_Name, c.Cus_Phone, c.Cus_Address
from Customer as c
left join [Bill Order] as b 
On c.Cus_ID = b.Cus_ID
where b.Bill_ID is Null

						--- SELF JOIN ---

--- CASE 1: Tôi muốn in ra những khách hàng có cùng khu vực là Thanh Hoá

select a.Cus_ID, a.Cus_Name, a.Cus_Phone, a.Cus_Address
from Customer a inner join Customer b
on a.Cus_ID <> b.Cus_ID and a.Cus_Address = b.Cus_Address
-- Điều kiện join để đảm bảo rằng chỉ những khách hàng khác nhau
-- (không trùng Cus_ID) và có cùng địa chỉ được chọn.
-- denote:  <> : Not equal
where a.Cus_Address = N'Thanh Hoá'
select * from Customer


							--- SUB QUERIES ---
-- FIX "where"
--- CASE 1: In ra |name and phone| khách hàng mua sản phẩm cao hơn aver -> (Trong thực tế như tri ân khách hàng)
select c.Cus_Name, c.Cus_Phone, od.[Total Sales] as [Total bought]
from [Detail Order] as od
inner join [Bill Order] as bo
on od.Bill_ID = bo.Bill_ID
--- Inner join between bill with customer to take name customer 
inner join Customer as c
on bo.Cus_ID = c.Cus_ID

where 
	[Total Sales] > (select AVG([Total Sales]) from [Detail Order]);

select * from [Detail Order]

--- CASE 2:  In ra những khách hàng đã mua hàng ( không dùng join)
Select *
from Customer
where Cus_ID In (Select Cus_ID from [Bill Order]);


--- Not involted sub query!

--- CASE 3: In ra Top 3 - 2 - 1 Customer buy product
select  TOP 3 c.Cus_Name, c.Cus_Phone, bo.Date_Order, od.[Total Sales] 
from [Detail Order] as od
inner join [Bill Order] as bo
On od.Bill_ID = bo.Bill_ID
inner join Customer as c
On bo.Cus_ID = c.Cus_ID
--where od.[Total Sales] > (Select AVG([Total Sales]) from [Detail Order])
Order by od.[Total Sales] desc;
---

--- Using Join ---
--- CASE 4: In ra vị khách đã chi tổng bao nhiêu tiền cho cửa hàng
select c.Cus_Name, c.Cus_Phone, SUM(do.[Total Sales]) as TotalSpent
from [Detail Order] as do
inner join [Bill Order] as bo
on do.Bill_ID = bo.Bill_ID
inner join Customer as c
on bo.Cus_ID = c.Cus_ID

group by c.Cus_Name, c.Cus_Phone -- select gì thì group by vậy
order by TotalSpent desc;


--- Using Sub Query ---
--- CASE 4: Using Sub queries
SELECT Cus_Name, Cus_Phone, 
    (SELECT SUM(do.[Total Sales])
     FROM [Detail Order] do
     INNER JOIN [Bill Order] bo 
	 ON do.Bill_ID = bo.Bill_ID
     WHERE bo.Cus_ID = c.Cus_ID) AS TotalSpent
FROM Customer c
--- Check customers just do not order yet then next! ---
WHERE EXISTS (SELECT *
              FROM [Bill Order] bo
              WHERE bo.Cus_ID = c.Cus_ID)
ORDER BY TotalSpent DESC;


--- CASE 5: in ra những khách hàng chưa mua (same case 4) but set total sales is 0 thì sử dụng coalesce
SELECT 
    Cus_Name, 
    Cus_Phone,
-- total sales ---
    COALESCE((SELECT SUM(do.[Total Sales])
              FROM [Detail Order] do
              INNER JOIN [Bill Order] bo ON do.Bill_ID = bo.Bill_ID
              WHERE bo.Cus_ID = c.Cus_ID), 0) AS TotalSpent
FROM Customer c


--------------------------------------------------------------------------
--								FUNCTION
--------------------------------------------------------------------------

-- Q1 :: Print out list customer bought at 2024-06-16
create function getCusFromDate(@Date_Order date)
returns table as
return
	select c.Cus_Name, c.Cus_Phone, c.Cus_Address
	from [Bill Order] as bo 
	inner join Customer as c
	on bo.Cus_ID = c.Cus_ID

	where bo.Date_Order = @Date_Order
select * from getCusFromDate('2024-06-16')
----------------------------------------------------------------

----------------------------------------------------------------

--- Q2: Nhập ID hiện ra tên người đăt hàng - ngày đặt 
alter function doQ4Fun(@Cus_Id int)
returns table as
return
	select c.Cus_Name, c.Cus_Phone, bo.Date_Order
	from [Detail Order] as do inner join [Bill Order] as bo
	On do.Bill_ID = bo.Bill_ID
	inner join Customer as c
	On bo.Cus_ID = c.Cus_ID
	where c.Cus_ID = @Cus_Id
select * from doQ4Fun(3)

--- Q3: Nhập ID khách hàng in ra tổng tiền người đó đã mua
alter function getTotal(@id int)
returns money as
begin
	declare @total money
	select @total = Sum(do.[Total Sales])
	from [Detail Order] as do
	inner join [Bill Order] as bo
	On do.Bill_ID = bo.Bill_ID
	inner join Customer as c
	On bo.Cus_ID = c.Cus_ID
	where c.Cus_ID = @id
	group by c.Cus_Name
	return @total
end
select [dbo].[getTotal](3) as [Total Sales]

-----------------------------------------------------------------
--							PROCEDURE
-----------------------------------------------------------------

--- Lấy thông tin của khác hàng bằng tên được cung cấp
create procedure getFullInfo @name nvarchar(255)
as begin
	select * from Customer as c
	where c.Cus_Name = @name
end
exec getFullInfo N'Hoàng Ngọc Mai'
---


---  --- Insert --- ---
-- Add new customer 3 for customer table
create procedure addCus 
@Name nvarchar(255),
@Phone char(12),
@Address nvarchar(255)
as begin
	insert into Customer(Cus_Name, Cus_Phone, Cus_Address)
	values
	(@Name, @Phone, @Address)
end
exec addCus 'Customer new 3', '0394949489', N'Bắc Ninh'
select * from Customer
---

---  --- Update --- ---
--- 
--- Bây giờ tôi cho một mã id product và tôi muốn tăng giá nó.
create procedure IncreasePrice
@id int
,@bonus money
as begin
	update Product
	set Pro_Price = Pro_Price + @bonus
	where Pro_Id = @id
end
exec IncreasePrice 2, 3000

--- Bây giờ tôi cho một mã bill id và tôi muốn change quantity.
create procedure ChangeQuantity 
@Bill_ID int,
@Quantity int
as begin
	update [Detail Order]
	set Quantity = @Quantity
	where Bill_ID = @Bill_ID
end
exec ChangeQuantity 1, 3
----


---  --- Delete --- ---
-- DEL 'new customer 3' from customer table follow id
create procedure delCus
@id int
as begin
	Delete from Customer
	where Cus_ID = @id
end
exec delCus 9

--------------------------------------------------------------
--------------------------------------------------------------

--- End by: Code một hàm nhập thông tin của khách hàng:  
-- full info cus - bill id  - product name - unit - quantity - price - cal total- date buy 

create procedure GetFullContent @id int
as begin
	select c.Cus_Name, c.Cus_Phone, c.Cus_Address, bo.Bill_ID, pt.ProType_Name,
	pt.ProType_Unit, do.Quantity, do.Price, do.[Total Sales], bo.Date_Order        
	from [Detail Order] as do
	inner join [Bill Order] as bo
	On do.Bill_ID = bo.Bill_ID
	inner join Customer as c
	On bo.Cus_ID = c.Cus_ID
	inner join [Product Type] as pt
	On do.ProType_ID = pt.ProType_ID

	where c.Cus_ID = @id
end

exec GetFullContent 3

--------------------------------TRIGGERS-----------------------------------------
---------------------------------------------------------------------------------

--- Q1 Case 1: If I change price / quantity  of product  then total is also to change
create trigger UpdateTotalPricePr on [dbo].[Product]
after insert, update as
begin
	update [dbo].[Product]
	set Product.[Total Purchase] = i.[Pro_Quantity] * i.[Pro_Price]
	from inserted i
	where Product.Pro_Id = i.Pro_Id
end

update [dbo].[Product] 
set [Pro_Price] = 2000
where [Pro_Id] = 4
select * from Product
---

--- Q1 Case 2: If I change price / quantity  of detail order then total is also to change
create trigger UpdateTotalPriceDetailOrder on [dbo].[Detail Order]
after insert, update as
begin
	update [dbo].[Detail Order]
	set [dbo].[Detail Order].[Total Sales] = i.Price * i.Quantity
	from inserted i
	where [dbo].[Detail Order].Bill_ID = i.Bill_ID
end

update [Detail Order]
set [Price] = 10000
where [Bill_ID] = 1
select * from [dbo].[Detail Order]
------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
--- Q2:  Khi một đơn hàng được tạo thì số lượng sản phẩm đó cũng giảm và tổng tiền cũng thay đổi
-------------------------------------------------------------------------------------------------


---- Case 1: Only Insert (nếu dùng "after insert, update as" thì một lần insert vào detail order
--> Nó trừ double Sản phẩm
---
create trigger updatestock On [dbo].[Detail Order]  
-- On: là nơi mà bạn dùng tới update / insert : Khi bạn chạy nó ở đâu thì trigger sẽ hoạt động
-- Vd: Bạn thêm đơn hàng mới thì nó nằm ở [dbo].[Detail Order]
after insert as  --- Only insert
begin
	-- Update the product quantity based on the inserted order
    update p
	set p.Pro_Quantity = p.Pro_Quantity - i.[Quantity]
	from Product as p
	inner join [dbo].[Product Type] as pt
	On p.Pro_Id = pt.Pro_ID
	inner join inserted i
	On i.ProType_ID = pt.ProType_ID
end
---

				--- DATA using in Trigger Q2 ---

--- Muốn insert vào detail order cần insert vào Bill Order trước
Insert into [Bill Order] (Emp_ID, Cus_ID, Date_Order)
Values
(2, 1, '2025-1-8')
select * from [Bill Order]

Insert into [Detail Order] (Bill_ID, ProType_ID, Price, Quantity)
Values
(28, 1, 5555, 10)
--------------------------------------------------------------------

--- Q3: Nếu giá mua trong detail order < giá trong Product thì không được

Create trigger CheckPrice on [dbo].[Detail Order]
for insert as
begin
	SET NOCOUNT ON; 
	if exists (select * from inserted i
	inner join [dbo].[Product Type] as pt
	On  i.ProType_ID = pt.ProType_ID
	inner join [dbo].[Product] as p
	On pt.Pro_ID = p.Pro_Id
	where i.Price < p.Pro_Price )  -- Tồn tại : Giá mua < Giá gốc 
	begin
		RAISERROR ('CANNOT INSERT PRICE < PRICE ORIGINAL', 16, 1);
		ROLLBACK;
	end
end

--- Q3: case 2:: Nếu số lượng trong kho hết (quantity of product) thì không cho mua sản phẩm đó

create trigger CheckQuantity On [dbo].[Detail Order]
for insert as
begin
	SET NOCOUNT ON; 
	if exists (select * from inserted i
	inner join [dbo].[Product Type] as pt
	On i.ProType_ID = pt.ProType_ID
	inner join [dbo].[Product] as p
	On pt.Pro_ID = p.Pro_Id
	where i.Quantity > p.Pro_Quantity ) -- Tồn tại :: Số lượng mua > Số lượng còn trong stock
	begin
		RAISERROR ('QUANTITY PURCHASED > QUANTITY IN STOCK', 16, 1);
		ROLLBACK;
	end
end


				--- DATA using in Trigger Q3 ---

--- Muốn insert vào detail order cần insert vào Bill Order trước
Insert into [Bill Order] (Emp_ID, Cus_ID, Date_Order)
Values
(1, 2, '2025-1-20')
select * from [Bill Order]

Insert into [Detail Order] (Bill_ID, ProType_ID, Price, Quantity)
Values
(28, 1, 9999, 2)
---

select * from Product
select * from [Product Type]
select * from  [Detail Order]
order by [Bill_ID] desc


--- SYNTAX PRINT OUT ---
select * from Supplier
select * from Product
select * from [Product Type]
select * from [Bill Order]
select * from [Detail Order]
select * from Customer
Select * from Employee

