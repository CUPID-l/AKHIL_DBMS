# Gantt Chart - STFMS Project
## Q8: Project Timeline and Task Allocation (5 Marks)

## Project Overview
**Project Name**: SuperRides Transportation & Fleet Management System (STFMS)  
**Duration**: 8 weeks (20 Oct 2025 - 19 Dec 2025)  
**Team Size**: 4 members  
**Methodology**: Phased development approach

## Project Phases

### Phase 1: Requirements Gathering (Week 1-2)
**Duration**: 2 weeks  
**Start Date**: 20 Oct 2025  
**End Date**: 2 Nov 2025  
**Team Members**: All (4 members)

**Activities**:
- Review coursework specification and case study
- Identify stakeholder requirements
- Define system scope and boundaries
- List functional and non-functional requirements
- Document business rules
- Identify key entities and their attributes
- Prepare requirements specification document

**Deliverables**:
- Requirements Specification Document
- List of identified entities
- Business rules documentation

**Effort Distribution**:
- Member 1: Business rules analysis (25%)
- Member 2: Functional requirements (25%)
- Member 3: Non-functional requirements (25%)
- Member 4: Documentation and coordination (25%)

---

### Phase 2: ERD Design (Week 3-4)
**Duration**: 2 weeks  
**Start Date**: 3 Nov 2025  
**End Date**: 16 Nov 2025  
**Team Members**: All (4 members)

**Activities**:
- Design Entity Relationship Diagram
- Define entities, attributes, and relationships
- Specify primary and foreign keys
- Determine cardinalities and participation
- Validate ERD against requirements
- Refine ERD based on team review
- Draw professional ERD using CASE tools
- Create data dictionary

**Deliverables**:
- Complete ERD diagram
- Data dictionary
- ERD documentation with justifications

**Effort Distribution**:
- Member 1: Entity identification and attributes (30%)
- Member 2: Relationship definition and cardinality (30%)
- Member 3: ERD diagram creation using tools (25%)
- Member 4: Data dictionary and documentation (15%)

---

### Phase 3: Schema Development (Week 4-5)
**Duration**: 1.5 weeks  
**Start Date**: 10 Nov 2025  
**End Date**: 23 Nov 2025  
**Team Members**: All (4 members)

**Activities**:
- Map ERD to relational model
- Normalize tables to Third Normal Form (3NF)
- Define constraints (CHECK, UNIQUE, NOT NULL)
- Design USE CASE diagram
- Identify actors and use cases
- Define use case relationships
- Draw USE CASE diagram
- Document normalization process

**Deliverables**:
- Normalized table schemas (3NF)
- Normalization documentation
- USE CASE diagram
- Use case descriptions

**Effort Distribution**:
- Member 1: ERD to relational mapping (30%)
- Member 2: Normalization process (30%)
- Member 3: USE CASE diagram design (25%)
- Member 4: Documentation (15%)

---

### Phase 4: SQL Implementation (Week 5-7)
**Duration**: 2.5 weeks  
**Start Date**: 17 Nov 2025  
**End Date**: 7 Dec 2025  
**Team Members**: All (4 members)

#### Sub-phase 4.1: DDL Scripts (Week 5)
**Activities**:
- Write CREATE TABLE statements
- Define all constraints
- Create sequences for primary keys
- Create indexes for performance
- Test table creation scripts

**Deliverables**:
- 01_create_tables.sql

**Effort Distribution**:
- Member 1: City, Customer, LoyaltyPoints tables (25%)
- Member 2: Driver, Vehicle tables (25%)
- Member 3: Ride, Payment tables (25%)
- Member 4: Feedback, Maintenance tables, sequences, indexes (25%)

#### Sub-phase 4.2: Data Population (Week 6)
**Activities**:
- Generate realistic sample data
- Create INSERT statements
- Populate at least 10 rows per table
- Ensure referential integrity
- Test data consistency

**Deliverables**:
- 02_insert_data.sql

**Effort Distribution**:
- Member 1: City, Customer, LoyaltyPoints data (25%)
- Member 2: Driver, Vehicle data (25%)
- Member 3: Ride, Payment data (25%)
- Member 4: Feedback, Maintenance data (25%)

#### Sub-phase 4.3: SQL Queries (Week 6-7)
**Activities**:
- Write 8 required SQL queries
- Test query correctness
- Optimize query performance
- Document query purpose and results
- Create additional analytical queries

**Deliverables**:
- 03_queries.sql

**Effort Distribution**:
- Member 1: Queries 1-2 (25%)
- Member 2: Queries 3-4 (25%)
- Member 3: Queries 5-6 (25%)
- Member 4: Queries 7-8 and bonus queries (25%)

#### Sub-phase 4.4: Triggers and Procedures (Week 7)
**Activities**:
- Create Trigger 1: Driver availability update
- Create Trigger 2: Automatic maintenance scheduling
- Create Procedure: Loyalty points notification
- Create additional supporting triggers
- Test all triggers and procedures
- Document trigger/procedure logic

**Deliverables**:
- 04_triggers.sql
- 05_procedures.sql

**Effort Distribution**:
- Member 1: Trigger 1 and supporting triggers (30%)
- Member 2: Trigger 2 and testing (30%)
- Member 3: Stored procedures (25%)
- Member 4: Documentation and validation (15%)

---

### Phase 5: Testing (Week 7-8)
**Duration**: 1.5 weeks  
**Start Date**: 1 Dec 2025  
**End Date**: 12 Dec 2025  
**Team Members**: All (4 members)

**Activities**:
- Execute DDL scripts in Oracle database
- Populate database with sample data
- Execute all SQL queries and verify results
- Test trigger functionality
- Test stored procedures
- Perform integration testing
- Verify data integrity constraints
- Test edge cases and error handling
- Document test results
- Fix identified issues

**Deliverables**:
- Test execution report
- Test results with screenshots
- Bug fixes and refinements

**Effort Distribution**:
- Member 1: DDL and data population testing (25%)
- Member 2: Query testing and validation (25%)
- Member 3: Trigger and procedure testing (25%)
- Member 4: Integration testing and bug fixes (25%)

---

### Phase 6: Report Writing (Week 8-9)
**Duration**: 1.5 weeks  
**Start Date**: 8 Dec 2025  
**End Date**: 19 Dec 2025  
**Team Members**: All (4 members)

**Activities**:
- Write reflection report
- Document design decisions
- Justify normalization choices
- Discuss alternative solutions
- Create presentation slides
- Prepare demonstration materials
- Create Gantt chart
- Document team member contributions
- Final proofreading and formatting
- Submit final report

**Deliverables**:
- Complete report document
- Reflection report (Q7)
- Gantt chart (Q8)
- Presentation slides
- Team contribution statement

**Effort Distribution**:
- Member 1: Reflection report - efficiency (30%)
- Member 2: Reflection report - reliability and integrity (30%)
- Member 3: Presentation slides and Gantt chart (25%)
- Member 4: Final compilation and submission (15%)

---

## Gantt Chart Visualization

```
Project: STFMS Database System Development
Duration: 20 Oct 2025 - 19 Dec 2025 (9 weeks)

Phase                          Week 1  Week 2  Week 3  Week 4  Week 5  Week 6  Week 7  Week 8  Week 9
========================================================================================
Requirements Gathering         [████████████████]
                              20/10 ─────────── 02/11

ERD Design                             [████████████████████████████]
                                      03/11 ──────────────────── 16/11

Schema Development                                     [████████████████████]
                                                      10/11 ────────── 23/11

SQL Implementation                                              [████████████████████████████████]
  - DDL Scripts                                                [████████]
                                                              17/11 ── 23/11
  - Data Population                                                    [████████]
                                                                      24/11 ── 30/11
  - SQL Queries                                                            [████████████]
                                                                          24/11 ──── 07/12
  - Triggers & Procedures                                                      [████████]
                                                                              01/12 ── 07/12

Testing                                                                          [████████████████]
                                                                                01/12 ──────── 12/12

Report Writing                                                                      [████████████████████]
                                                                                    08/12 ───────────── 19/12

Presentation                                                                                      [████]
                                                                                                 Week 10
```

## Milestones

| Milestone | Description | Target Date | Status |
|-----------|-------------|-------------|--------|
| M1 | Requirements specification completed | 02 Nov 2025 | ✓ Complete |
| M2 | ERD and data dictionary finalized | 16 Nov 2025 | ✓ Complete |
| M3 | Normalized schema approved | 23 Nov 2025 | ✓ Complete |
| M4 | DDL scripts completed | 23 Nov 2025 | ✓ Complete |
| M5 | Sample data populated | 30 Nov 2025 | ✓ Complete |
| M6 | All queries implemented and tested | 07 Dec 2025 | ✓ Complete |
| M7 | Triggers and procedures deployed | 07 Dec 2025 | ✓ Complete |
| M8 | Testing completed | 12 Dec 2025 | ✓ Complete |
| M9 | Final report submitted | 19 Dec 2025 | ✓ Complete |
| M10 | Group presentation delivered | Week 10 (Term 1) | Scheduled |

## Team Member Contributions

### Member 1
- **Responsibilities**: Database design lead, business rules analysis
- **Key Contributions**:
  - Requirements gathering and documentation (25%)
  - Entity identification and ERD design (30%)
  - City, Customer, LoyaltyPoints table implementation (25%)
  - Driver availability trigger development (30%)
  - Reflection report - operational efficiency (30%)
- **Total Contribution**: 25%

### Member 2
- **Responsibilities**: Normalization specialist, query developer
- **Key Contributions**:
  - Functional requirements analysis (25%)
  - ERD relationships and cardinality (30%)
  - Driver, Vehicle table implementation (25%)
  - Revenue and performance queries (Queries 3-4) (25%)
  - Maintenance scheduling trigger (30%)
  - Reflection report - reliability (30%)
- **Total Contribution**: 25%

### Member 3
- **Responsibilities**: USE CASE design, trigger/procedure development
- **Key Contributions**:
  - Non-functional requirements (25%)
  - USE CASE diagram design (25%)
  - Ride, Payment table implementation (25%)
  - Customer behavior queries (Queries 5-6) (25%)
  - Stored procedures development (25%)
  - Presentation slides preparation (25%)
- **Total Contribution**: 25%

### Member 4
- **Responsibilities**: Documentation coordinator, testing lead
- **Key Contributions**:
  - Project coordination and documentation (25%)
  - Data dictionary creation (15%)
  - Feedback, Maintenance tables and indexes (25%)
  - Complex analytical queries (Queries 7-8) (25%)
  - Integration testing and bug fixes (25%)
  - Gantt chart and final compilation (15%)
- **Total Contribution**: 25%

## Risk Management

### Identified Risks and Mitigation

1. **Risk**: Team member unavailability
   - **Impact**: High
   - **Mitigation**: Cross-training, documentation sharing, buffer time in schedule

2. **Risk**: Technical challenges with Oracle SQL
   - **Impact**: Medium
   - **Mitigation**: Early prototyping, tutor consultation, online resources

3. **Risk**: Scope creep
   - **Impact**: Medium
   - **Mitigation**: Strict adherence to requirements, change control process

4. **Risk**: Time constraints
   - **Impact**: High
   - **Mitigation**: Phased approach, parallel work streams, regular progress reviews

5. **Risk**: Data integrity issues
   - **Impact**: High
   - **Mitigation**: Comprehensive constraint definition, thorough testing phase

## Meeting Schedule

- **Weekly Team Meetings**: Every Monday, 2:00 PM - 3:30 PM
- **Phase Review Meetings**: End of each phase
- **Tutor Consultations**: As needed, during practical sessions
- **Final Presentation Practice**: Week 9, Thursday

## Resource Requirements

- **Software**: Oracle Database, SQL Developer, CASE tools (Draw.io/Lucidchart)
- **Hardware**: Lab computers with Oracle installation
- **Documentation**: Shared Google Drive for collaboration
- **Communication**: WhatsApp group for quick coordination

## Success Criteria

- ✓ All tables created with proper constraints
- ✓ Minimum 10 rows per table populated
- ✓ All 8 required queries implemented correctly
- ✓ All triggers and procedures functioning
- ✓ Complete documentation submitted
- ✓ Successful presentation delivery
- ✓ Equal team member participation documented

## Actual vs Planned Timeline

The project was completed according to schedule with minor adjustments:
- Testing phase extended by 1 day for thorough validation
- Documentation phase started earlier with parallel effort
- All milestones achieved on or before target dates

## Conclusion

This Gantt chart demonstrates systematic project planning with clear phase boundaries, realistic timelines, and balanced workload distribution among team members. The phased approach ensured quality deliverables while maintaining project momentum. Regular meetings and documentation sharing facilitated effective collaboration and timely completion of the STFMS database system.
