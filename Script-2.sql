SELECT c.doc_type AS Doc_type , c.doc_number AS Doc_Number, p.product_name AS Product, s.sales_id AS Sales_id
FROM sold_product sd
	JOIN sales s ON sd.id_sales = s.sales_id
	JOIN client c ON s.id_client = c.client_id
	JOIN product p ON sd.id_product = p.product_id
WHERE c.doc_type = 'CC' AND c.doc_number = '97531';
