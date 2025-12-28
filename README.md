# SuperRides Transportation & Fleet Management System (STFMS)

## Project Overview
This project implements a comprehensive database system for SuperRides, a ride-hailing and logistics company operating across major UK cities. The STFMS database manages:

- Customer registrations and ride bookings
- Driver management and assignments
- Vehicle fleet tracking and maintenance
- Payment processing
- Customer feedback and ratings
- Operational analytics

## System Architecture
The database is designed to handle:
- 200,000+ registered users
- 2,000+ vehicles
- Daily transaction volumes
- Real-time operational data

## Components

### 1. Database Design (`docs/`)
- ERD Diagram
- USE CASE Diagram
- Normalized Schema (3NF)
- Data Dictionary

### 2. SQL Implementation (`sql/`)
- `01_create_tables.sql` - DDL scripts for table creation
- `02_insert_data.sql` - Sample data population
- `03_queries.sql` - Business intelligence queries
- `04_triggers.sql` - Automated triggers
- `05_procedures.sql` - Stored procedures

### 3. Documentation (`docs/`)
- Design decisions and assumptions
- Reflection report
- Gantt chart

## Technologies Used
- Database: Oracle SQL / PostgreSQL compatible
- Design Tools: For ERD and USE CASE diagrams
- Documentation: Markdown and diagrams

## Business Objectives
The STFMS automates:
- Ride booking and driver assignment workflows
- Vehicle status and maintenance tracking
- Driver performance and availability monitoring
- Customer feedback collection
- Data analytics and reporting

## Getting Started

### Prerequisites
- Oracle Database or PostgreSQL
- SQL client (SQL*Plus, pgAdmin, or similar)

### Installation
1. Execute DDL scripts: `sql/01_create_tables.sql`
2. Populate sample data: `sql/02_insert_data.sql`
3. Test queries: `sql/03_queries.sql`
4. Deploy triggers: `sql/04_triggers.sql`
5. Deploy procedures: `sql/05_procedures.sql`

## Project Team
Group coursework for CN5000 Database Systems module at University of East London.

## License
Academic project for educational purposes.
