# 🛍️ dbt E-Commerce Analytics Pipeline

**Professional data transformation pipeline built with dbt Cloud and BigQuery**

## 📊 Project Overview

This project implements a complete analytics pipeline for the TheLook e-commerce dataset, following dbt best practices with a staging → marts architecture.

**Stack:**
- **dbt Cloud** - Data transformation orchestration
- **Google BigQuery** - Data warehouse
- **Git/GitHub** - Version control
- **TheLook E-commerce** - Sample dataset (BigQuery public data)

## 🏗️ Architecture

### Data Flow
```
Sources (BigQuery public data)
    ↓
Staging Layer (cleaning, renaming)
    ↓
Marts Layer (business logic, aggregations)
```
### Lineage Graph

<img width="1390" height="571" alt="image" src="https://github.com/user-attachments/assets/b0d800fa-2499-4e7d-9e5e-cc0a4aa3bc11" />

*Visual representation of data flow from sources to marts*

### Models Overview

#### 📥 **Sources** (4 tables)
- `thelook.orders` - Customer orders
- `thelook.users` - Customer profiles
- `thelook.products` - Product catalog
- `thelook.order_items` - Order line items (bridge table)

#### 🔄 **Staging Models** (4 models)
- `stg_thelook__orders` - Cleaned orders data
- `stg_thelook__users` - Cleaned users data
- `stg_thelook__products` - Cleaned products (handles NULL names/brands)
- `stg_thelook__order_items` - Cleaned order items (links orders ↔ products)

#### 📈 **Marts** (3 business models)

**1. mart_customer_orders**
- Customer-level order metrics
- Order counts by status
- Completion/cancellation/return rates
- Customer behavior segmentation

**2. mart_user_behavior**
- User demographics + order activity
- Age group segmentation
- User classification (Never Ordered, One-Time, Occasional, Frequent)
- LEFT JOIN to include all users

**3. mart_product_performance** ✨ *New!*
- Product-level performance metrics
- Total orders & completed orders per product
- Average retail price
- 3-table JOIN (products ← order_items → orders)
- Handles products never ordered (LEFT JOIN)

## 🧪 Data Quality

**Total tests: 27+ passing ✅**

- Primary keys: `unique` + `not_null`
- Foreign keys: `not_null`
- Business rules: `accepted_values` (order status, user classification)
- Data cleaning: NULL handling with `coalesce()`

**Known data quality issues (handled):**
- 2 products with NULL names → replaced with "Unknown Product"
- 24 products with NULL brands → replaced with "Unknown Brand"

## 📂 Project Structure
```
dbt-bigquery-ecommerce/
├── models/
│   ├── staging/
│   │   └── thelook/
│   │       ├── _thelook__sources.yml
│   │       ├── _thelook__models.yml
│   │       ├── stg_thelook__orders.sql
│   │       ├── stg_thelook__users.sql
│   │       ├── stg_thelook__products.sql
│   │       └── stg_thelook__order_items.sql
│   └── marts/
│       └── sales/
│           ├── _sales__models.yml
│           ├── mart_customer_orders.sql
│           ├── mart_user_behavior.sql
│           └── mart_product_performance.sql
├── dbt_project.yml
└── README.md
```

## 🚀 How to Run

### Prerequisites
- dbt Cloud account (or dbt Core installed)
- Google Cloud Platform account with BigQuery enabled
- Access to `bigquery-public-data.thelook_ecommerce`

### Commands
```bash
# Install dependencies (if using dbt Core)
dbt deps

# Run all models
dbt run

# Run specific model and downstream dependencies
dbt run --select stg_thelook__products+

# Run tests
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```

## 📊 Key Metrics Available

From `mart_product_performance`:
- Which products are top sellers?
- What's the completion rate by product?
- Which products have never been ordered?

From `mart_customer_orders`:
- Who are our VIP customers?
- What's the average completion rate?
- Customer behavior patterns

From `mart_user_behavior`:
- Age demographics
- User activity classification
- First-time vs repeat customers

## 🔗 Links

- **GitHub Repository:** [github.com/Sajeevan11/dbt-bigquery-ecommerce](https://github.com/Sajeevan11/dbt-bigquery-ecommerce)
- **dbt Documentation:** Available in dbt Cloud Catalog after running job
- **Dataset Source:** [BigQuery Public Data - TheLook E-commerce]

## 👤 Author

**Sajeevan**
- Data Analyst

## 📝 License

This project is for educational purposes.
