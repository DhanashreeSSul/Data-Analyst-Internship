# 🧠 Task 3: SQL for Data Analysis – Data Analyst Internship

This project demonstrates the use of **MySQL** to extract insights from an e-commerce system database. The task includes writing queries involving joins, subqueries, aggregation, and filtering.

---

## 📁 Database: `ecommercesystem_273`

### Tables Created:
- `Customers(customer_id, name, email, city)`
- `Orders(order_id, customer_id, order_date, total_amount)`
- `Products(product_id, product_name, category, price)`
- `Order_Items(order_item_id, order_id, product_id, quantity, subtotal)`
- `Sellers(seller_id, seller_name, city)`

---

## 📌 SQL Concepts Used

- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `HAVING`
- `INNER JOIN`, `LEFT JOIN`, `UNION`, `INTERSECT`
- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`
- Subqueries and derived tables
- Filtering with `NOT IN`, `EXISTS`
- Year-wise grouping, filtering with `CURDATE()`, date intervals

---

## 📊 Key Insights & Sample Queries

| 🔍 Query Objective | ✅ SQL Feature Used |
|-------------------|--------------------|
| Show all customers with/without orders | `LEFT JOIN` |
| Orders with products & quantities | `JOIN` |
| Total products per category | `GROUP BY` |
| Sellers who sell 'Laptop' | `JOIN`, `WHERE` |
| Customers without orders | `NOT IN` subquery |
| High-value orders | Subquery with `AVG()` |
| Top 3 most ordered products | `SUM()`, `ORDER BY`, `LIMIT` |
| Products sold by multiple sellers but never ordered | `GROUP BY`, `NOT EXISTS` |
| Customers placing orders in every year | `GROUP BY`, nested subquery |

---



