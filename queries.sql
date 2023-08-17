--AVG_Business_Order_Value:
select 
business_id,  
sum(gross_revenue)/count(distinct order_id) as AVG_Business_Order_Value	
from business_order_lineitem 
group by 1;


--Total Business Revenue 
select 
business_id,  
sum(gross_revenue) as Total_Business_Revenue
from business_order_lineitem 
group by 1;

--AVG Monthly Revenue
select 
boi.business_id,  
count(distinct date_trunc('year', bo.created_at)) as number_years,
sum(gross_revenue)/count(distinct date_trunc('year', bo.created_at))/12 as Avg_Monthly_Revenue
from business_order_lineitem as boi
Left join business_order as bo 
on bo.business_id = boi.business_id and 
Bo.order_id = boi.order_id
group by 1;


--Revenue By Year
select 
boi.business_id,  
date_part('year', bo.created_at) as date_year,
sum(gross_revenue) as Avg_Yearly_Revenue
from business_order_lineitem as boi
Left join business_order as bo 
on bo.business_id = boi.business_id and 
Bo.order_id = boi.order_id
group by 1, 2;