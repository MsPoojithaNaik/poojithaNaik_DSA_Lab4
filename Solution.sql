-- Question 4
select C_O.CUS_GENDER as 'Gender', count(C_O.CUS_GENDER) as 'NoOfCustomers' from (
select c.cus_id, c.cus_name, c.cus_gender from customer c inner join
`order` o on c.cus_id = o.cus_id
where o.ORD_AMOUNT >= 3000
group by c.cus_id
) as C_O
group by C_O.cus_gender;

-- Question 5

select o.cus_id, o.ord_id, o.ORD_AMOUNT, o.ORD_DATE, sp.SUPP_PRICE,
p.PRO_NAME from `order` o
	inner join supplier_pricing sp
    inner join product p
on (o.PRICING_ID = sp.PRICING_ID AND sp.PRO_ID = p.PRO_ID)
where o.CUS_Id = 2;

-- Question 6

select s.*, NoOfProducts_Supplied from supplier s 
inner join (
select supp_id, count(pro_id) as NoOfProducts_Supplied from supplier_pricing
group by supp_id
HAVING NoOfProducts_Supplied > 1
) as sp
on s.supp_id = sp.supp_id;

-- Question 7

select P_SP.* from category C
inner join (
select P.cat_id, P.pro_id, P.pro_name, Minimal_Product_Price from product P inner join (
select pro_id, min(SUPP_PRICE) Minimal_Product_Price from supplier_pricing
group by pro_id
) as SP
on p.PRO_ID = SP.PRO_ID
) as P_SP 
ON (C.CAT_ID = P_SP.CAT_ID);

-- Question 8

select p.pro_id, p.pro_name
-- o.ord_id, o.ORD_AMOUNT, o.ORD_DATE, sp.SUPP_PRICE 
from `order` o
	inner join supplier_pricing sp
    inner join product p
on (o.PRICING_ID = sp.PRICING_ID AND sp.PRO_ID = p.PRO_ID)
where o.ORD_DATE >= "2021-10-05"
group by p.PRO_ID;

-- Question 9

SELECT cus_id, cus_name FROM ecommerce.customer where 
	cus_name like 'A%' 
		OR 
    cus_name like '%A';
    
   
-- Question 10

SELECT SUPP_ID, SUPP_NAME, AverageRating, 
	CASE
		WHEN AverageRating = 5 THEN 'Excellent Service'
        WHEN AverageRating > 4 THEN 'Good Service'
        WHEN AverageRating > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END As ServiceType
 FROM (
select s.SUPP_ID, s.SUPP_NAME, avg(r.RAT_RATSTARS) AverageRating
from rating r
	inner join `order` o
    inner join supplier_pricing sp
    inner join supplier s
on (
r.ORD_ID = o.ORD_ID AND
o.PRICING_ID = sp.PRICING_ID AND
sp.SUPP_ID = s.SUPP_ID
)
group by supp_id
) as R_O_SP_S;

-- Procedure
CREATE DEFINER=`root`@`localhost` PROCEDURE `Dispaly_SupplierRatingDetails`()
BEGIN
-- Question 10

SELECT SUPP_ID, SUPP_NAME, AverageRating, 
	CASE
		WHEN AverageRating = 5 THEN 'Excellent Service'
        WHEN AverageRating > 4 THEN 'Good Service'
        WHEN AverageRating > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END As ServiceType
 FROM (
select s.SUPP_ID, s.SUPP_NAME, avg(r.RAT_RATSTARS) AverageRating
from rating r
	inner join `order` o
    inner join supplier_pricing sp
    inner join supplier s
on (
r.ORD_ID = o.ORD_ID AND
o.PRICING_ID = sp.PRICING_ID AND
sp.SUPP_ID = s.SUPP_ID
)
group by supp_id
) as R_O_SP_S;

END



--Procedure_Call
call Dispaly_SupplierRatingDetails();





 



