# 🚀 dbt E-Commerce Analytics Pipeline

Modern ELT data pipeline built with **dbt Cloud** and **Google BigQuery** for e-commerce analytics.

![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=for-the-badge&logo=googlebigquery&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)

---

## 📊 Project Overview

This project demonstrates a **production-grade ELT pipeline** using dbt to transform raw e-commerce data into analytics-ready tables. It analyzes **125K orders** and **100K users** from the TheLook e-commerce public dataset.

**Key Features:**
- ✅ Layered architecture (Staging → Marts)
- ✅ 27 automated data quality tests (100% passing)
- ✅ Comprehensive documentation (auto-generated)
- ✅ Git-based version control workflow
- ✅ Production deployment with automated jobs

---

## 🏗️ Architecture
```
Sources (BigQuery Public Data)
├── thelook.orders (125K rows)
└── thelook.users (100K rows)
    ↓
Staging Layer (Data Cleaning)
├── stg_thelook__orders
└── stg_thelook__users
    ↓
Marts Layer (Business Logic)
├── mart_customer_orders (customer-level order metrics)
└── mart_user_behavior (demographics + order activity with LEFT JOIN)
```

---

## 📁 Project Structure
```
dbt-bigquery-ecommerce/
├── models/
│   ├── staging/
│   │   └── thelook/
│   │       ├── _thelook__sources.yml
│   │       ├── _thelook__models.yml
│   │       ├── stg_thelook__orders.sql
│   │       └── stg_thelook__users.sql
│   │
│   └── marts/
│       └── sales/
│           ├── _sales__models.yml
│           ├── mart_customer_orders.sql
│           └── mart_user_behavior.sql
│
├── dbt_project.yml
└── README.md
```

---

## 📊 Data Models

### Staging Models

#### `stg_thelook__orders`
- **Type:** View
- **Purpose:** Clean and standardize raw orders data
- **Transformations:** Column renaming, type casting
- **Tests:** 6 (unique, not_null, accepted_values)

#### `stg_thelook__users`
- **Type:** View
- **Purpose:** Clean and standardize raw users data
- **Transformations:** Column renaming, demographic data preparation
- **Tests:** 6 (unique, not_null, accepted_values)

---

### Mart Models

#### `mart_customer_orders`
- **Type:** Table (materialized)
- **Purpose:** Customer-level order metrics and behavioral segmentation
- **Key Metrics:**
  - Total orders by status (complete, cancelled, returned)
  - Completion/cancellation/return rates
  - Order date ranges (first/last order)
  - Customer behavior classification
- **Rows:** 80,014 customers
- **Tests:** 6

#### `mart_user_behavior`
- **Type:** Table (materialized)
- **Purpose:** Comprehensive user behavior analysis combining demographics and order metrics
- **Key Features:**
  - LEFT JOIN (includes users who never ordered)
  - Age segmentation (Young, Adult, Middle Age, Senior, Elder)
  - User classification (Never Ordered, One-Time Buyer, Occasional Buyer, Frequent Buyer)
  - Complete demographic profile (age, gender, country)
- **Rows:** 100,000 users
- **Tests:** 9

---

## 🧪 Data Quality

**Test Coverage:**
- **27 tests total** (100% passing rate)
- **Test types:**
  - Uniqueness constraints (primary keys)
  - Not-null constraints (required fields)
  - Accepted values (status enums, classifications)

**Automated testing in CI/CD:**
- Tests run on every production deployment
- Job fails if any test fails (data quality gate)

---

## 🛠️ Tech Stack

| Component | Technology |
|-----------|-----------|
| **Data Warehouse** | Google BigQuery |
| **Transformation** | dbt Cloud |
| **Language** | SQL |
| **Version Control** | Git / GitHub |
| **Orchestration** | dbt Cloud Jobs |
| **Documentation** | dbt Docs (auto-generated) |

---

## 🚀 Getting Started

### Prerequisites
- Google Cloud account with BigQuery access
- dbt Cloud account
- Git / GitHub account

### Setup
1. Clone this repository
2. Configure dbt Cloud connection to BigQuery
3. Set up development and production environments
4. Run `dbt deps` to install dependencies
5. Run `dbt build` to execute models and tests

---

## 📈 Key Insights

**Customer Behavior:**
- 80% of users have placed at least one order (activation rate)
- Average 1.5 orders per active customer
- 10-15% cancellation rate across customer segments

**Demographics:**
- Even gender split (50% M / 50% F)
- Adult segment (25-34) shows highest activation rate
- Geographic distribution across 100+ countries

---

## 📚 Documentation

Full interactive documentation available via **dbt Docs**:
- Lineage graphs (DAG visualization)
- Column-level descriptions
- Test results
- Source code

**Generated automatically with every production run.**

---

## 🔄 Development Workflow
```
1. Create feature branch (feature/xxx)
2. Develop models in dbt Cloud IDE (DEV environment)
3. Test locally (dbt run, dbt test)
4. Commit and push to GitHub
5. Create Pull Request
6. Code review
7. Merge to main
8. Automated production deployment via dbt Cloud job
```

---

## 👤 Author

**Sajeevan**
- GitHub: [@Sajeevan11](https://github.com/Sajeevan11)
---

## 📝 License

This project is for educational and portfolio purposes.

---

## 🎯 Future Enhancements

- [ ] Add product dimension (orders + products join)
- [ ] Implement incremental models for performance
- [ ] Add dbt macros for code reusability
- [ ] Set up CI/CD with GitHub Actions
- [ ] Add more advanced metrics (LTV, cohort analysis, churn)

---

**⭐ If you find this project useful, please star this repository!**
```

**5. Scrollez en bas et cliquez sur "Commit changes"**

**6. Message de commit :**
```
docs: Enrich README with comprehensive project documentation
