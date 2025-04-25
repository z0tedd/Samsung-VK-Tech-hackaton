# TPC-H Query Optimization Project

## Overview

This repository contains solutions for optimizing TPC-H benchmark queries using Trino (formerly PrestoSQL) with data stored in Parquet format in S3. The project focuses on improving query performance through various optimization techniques including partitioning, indexing, and query rewriting.

## Project Structure

```
samsung_vk_tech_hackaton/
├── q1-q22/                # Individual query folders
│   ├── Student10176-Qxx-prepare.sql  # Data preparation scripts
│   └── Student10176-Qxx-run.sql      # Optimized query execution scripts
├── trash/                 # Experimental and temporary files
│   ├── Scripts/           # Various script versions
│   ├── q11-skibidi/       # Q11 specific optimizations
│   └── plan.md            # Optimization plan documentation
├── prepare/               # General preparation scripts
├── run/                   # Final execution scripts
└── LICENSE                # Project license information
```

## Key Features

- **Query Optimization**: Contains optimized versions of TPC-H queries Q1-Q22
- **Data Preparation**: Scripts for creating optimized tables and partitions
- **Performance Improvements**: Demonstrates significant performance gains through:
  - Partitioning strategies
  - Predicate pushdown techniques
  - Batch processing for large datasets
  - Indexing and filtering optimizations

## Example Optimizations

### Q20 Optimization Strategy

Implemented batch processing to handle large datasets efficiently:

```sql
-- Process in explicit batches (adjust ranges as needed)
-- Batch 1: First million
INSERT INTO filtered_predcalc_q20
WITH batch_lineitems AS (
    SELECT partkey, suppkey, 0.5 * SUM(quantity) AS batch_threshold
    FROM lineitem
    WHERE shipdate BETWEEN DATE '1994-01-01' AND DATE '1995-01-01'
)
...
```

### Q12 Shipping Modes Analysis

Optimized shipping mode analysis query:

```sql
SELECT
    l.shipmode,
    SUM(CASE WHEN o.orderpriority IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS high_line_count,
    SUM(CASE WHEN o.orderpriority NOT IN ('1-URGENT', '2-HIGH') THEN 1 ELSE 0 END) AS low_line_count
FROM orders o
JOIN lineitem_1994_receipt l ON o.orderkey = l.orderkey
GROUP BY l.shipmode
ORDER BY l.shipmode;
```

## Performance Results

Read slides from presentation

## Usage

1. Clone the repository
2. Set up your Trino environment
3. Run preparation scripts from `/prepare/` directory
4. Execute optimized queries from respective `qX/` folders, or from `/run/` directory

## License

This project is licensed under the GNU General Public License v3.0 -
see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## Contact

For any questions or suggestions, please contact [t.me/z0tedd]

## Acknowledgments

- Based on TPC-H benchmark queries
- Utilizes Trino (formerly PrestoSQL) query engine
- Data stored in Parquet format in S3
