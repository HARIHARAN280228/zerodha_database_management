create schema nextstep
use nextstep  

create table my_profile
(
surename varchar(100) not null,
pan_number varchar(100) not null,
demat_accountnumber varchar(100) primary key,
phonenumber varchar(20) not null,
email_id varchar(100) not null,
nominee_id int,
bank_accountname varchar(99),
bank_accountnumber varchar(99)
);

INSERT INTO my_profile 
(surename, pan_number, demat_accountnumber, phonenumber, email_id, nominee_id, bank_accountname, bank_accountnumber) 
VALUES 
('hariharan', 'xxxxxx', 'aa11', '9361617984', 'hari22@gmail.com', NULL, 'tmb','7989'),
('sujith','yyyyyy','aa22','7869434934','sriram22@gmail.com',null,'tmb','70987'),
('venkat','cccccc','aa33','8874434899','venkat33@gmail.com',2343,'cub','87696'),
('sarathi','vvvvv','aa44','9579289527','sarathi33@gmail.com',null,'iob','97767'),
('jagan','bbbbb','aa55','9693937865','jagan33@gmail.com',2445,'iob','96380'),
('kavidas','ddddd','aa66','9675765663','priya43@gmail.com',null,'sbi','78643'),
('monica','fffff','aa77','794694789','moni33025@gmail.com',null,'cub','99473'),
('nathra','ggggg','aa88','790645833','nethra23@gmail.com',null,'tmb','97586'),
('vasu','hhhh','aa99','8789078688','vasu23@gamil.com',null,'sbi','86756'),
('kalai','kkkkk','aa00','8664576833','aarthi33@gmail.com',4565,'tmb','88608');

 create table fund
(
  account_value decimal(15,3),
  available_margin int,
  added_fund int,
  withdraw_fund int,
  demat_accountnumber varchar(100) primary key,
  foreign key (demat_accountnumber) references my_profile(demat_accountnumber)
);



insert into fund 
(account_value,available_margin,added_fund,withdraw_fund,demat_accountnumber)
values
(200000,10000,200000,null,'aa11'),
(100000,20000,100000,null,'aa22'),
(40000,3000,40000,null,'aa33'),
(20000,2000,20000,18000,'aa44'),
(400000,80000,30000,50000,'aa55'),                                             
(20000,10000,1000,1000,'aa66'),
(30000,25000,20000,500,'aa77'),
(9000,1000,4000,1000,'aa88'),
(80000,null,5000,2000,'aa99'),
(33000,null,2000,4000,'aa00'); 

create table console
(
current_value int,
invested int,
profit_and_loss int,
demat_accountnumber varchar(99),
foreign key(demat_accountnumber)references my_profile(demat_accountnumber)
);
   
insert into console (current_value,invested,profit_and_loss,demat_accountnumber)
values
(210000,190000,20000,'aa11'),
(120000,80000,22000,'aa22'),   
(37600,37000,600,'aa33'),
(17500,18000,-500,'aa44'),
(370000,320000,50000,'aa55'),
(10800,10000,800,'aa66'),
(5120,5000,120,'aa77'),
(8550,8000,550,'aa88'),
(83000,80000,3000,'aa99'),
(32700,30000,-300,'aa00');   
   
create table stock
(stock varchar(50),
sector varchar(50),
indexname varchar(50),
demat_accountnumber varchar(99),
foreign key (demat_accountnumber) references my_profile(demat_accountnumber)
);


insert into stock
(demat_accountnumber,stock,sector,indexname)
values
('aa11','infy','it','largecap'),
('aa11','natco','pharma','largecap'),
('aa11','manapuram','finance','smallcap'),
('aa11','irfc','finance','midcap'),
('aa11','zydaslife','lifestyle','midcap'),
('aa11','tcs','it','largecap'),
('aa22','venus','pipes','largecap'),
('aa22','aarthi','pipes','midcap'),
('aa22','hdfc','bank','largecap'),
('aa22','axis','bank','largecap'),
('aa33','irctc','railway','largecap'),
('aa33','iron','railway','midcap'),
('aa44','suntv','telecommunication','smallcap'),
('aa44','icici','bank','largecap'),
('aa55','manapuram','finance','largecap'),
('aa55','iron','railway','midcap'),
('aa55','bandhan','bank','midcap'),
('aa66','irctc','railway','midcap'),
('aa66','venus','pipes','largecap'),
('aa77','irfc','railway','midcap'),
('aa77','tatapower','energy','midcap'),
('aa88','tatastell','stell','midcap'),
('aa88','irfc','railway','mdicap'),
('aa99','irfc','railway','midcap'),
('aa99','itc','hotal','largecap'),
('aa00','bandhan','bank','midcap'),
('aa00','tatastell','stell','midcap');

SELECT mp.surename, mp.email_id, f.account_value, c.current_value
FROM my_profile mp
INNER JOIN fund f ON mp.demat_accountnumber = f.demat_accountnumber
INNER JOIN console c ON mp.demat_accountnumber = c.demat_accountnumber;

SELECT mp.surename, mp.email_id, f.account_value, c.current_value
FROM my_profile mp
LEFT JOIN fund f ON mp.demat_accountnumber = f.demat_accountnumber
LEFT JOIN console c ON mp.demat_accountnumber = c.demat_accountnumber;

SELECT mp.surename, f.account_value, c.current_value
FROM fund f
RIGHT JOIN my_profile mp ON f.demat_accountnumber = mp.demat_accountnumber
RIGHT JOIN console c ON mp.demat_accountnumber = c.demat_accountnumber;


SELECT mp.surename, s.stock
FROM my_profile mp
CROSS JOIN stock s;

SELECT mp.surename, mp.email_id, f.account_value, c.current_value
FROM my_profile mp
LEFT JOIN fund f ON mp.demat_accountnumber = f.demat_accountnumber
LEFT JOIN console c ON mp.demat_accountnumber = c.demat_accountnumber

UNION

SELECT mp.surename, mp.email_id, f.account_value, c.current_value
FROM my_profile mp
RIGHT JOIN fund f ON mp.demat_accountnumber = f.demat_accountnumber
RIGHT JOIN console c ON mp.demat_accountnumber = c.demat_accountnumber;


SELECT sector, COUNT(*)AS total_stocks
FROM stock
group by sector;


SET sql_safe_updates = 1;


UPDATE my_profile
SET email_id = 'kavidas43@gamil.com'
WHERE email_id= 'priya43@gmail.com';
 
update my_profile
set nominee_id ='4544'
where demat_accountnumber ='aa88'

SET sql_safe_updates = 0;

select * FROM my_profile

delimiter //

create procedure profile_details()
begin
    select mp.surename,
           mp.pan_number,
           mp.demat_accountnumber,
           f.account_value,
           c.current_value,
           s.stock
    from my_profile mp
    join fund f ON mp.demat_accountnumber = f.demat_accountnumber
    join console c ON mp.demat_accountnumber = c.demat_accountnumber
    join stock s ON mp.demat_accountnumber = s.demat_accountnumber;
end //

delimiter ;

call  profile_details();
