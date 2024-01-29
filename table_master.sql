WITH product_detail AS (
  SELECT
    p.ProdNumber,
    p.ProdName,
    p.Category,
    pc.CategoryName,
    p.Price
  FROM `pib-rakamin.final_task_rakamin.Products` AS p
  LEFT JOIN `pib-rakamin.final_task_rakamin.ProductCategory` as pc
  ON p.Category = pc.CategoryID
),

full_tabel AS (
  SELECT
    o.OrderID AS order_id,
    o.Date AS date,
    o.CustomerID AS customer_id,
    REGEXP_SUBSTR(c.CustomerEmail, '^([^#]+)#') AS email,
    c.CustomerCity AS city,
    c.CustomerState AS state,
    o.ProdNumber AS prod_number,
    pd.ProdName AS prod_name,
    pd.CategoryName AS prod_category,
    pd.Price AS price,
    o.Quantity AS qty,
    (o.Quantity * pd.Price) AS total_sales
  FROM `pib-rakamin.final_task_rakamin.Orders` AS o
  LEFT JOIN `pib-rakamin.final_task_rakamin.customer` AS c
  ON o.CustomerID = c.CustomerID
  LEFT JOIN product_detail AS pd
  ON o.ProdNumber = pd.ProdNumber
)

SELECT
  date AS order_date,
  prod_category AS category_name,
  prod_name AS product_name,
  price AS product_price,
  qty AS order_qty,
  total_sales,
  email AS cust_email,
  city AS cust_city
FROM full_tabel
ORDER BY date ASC;