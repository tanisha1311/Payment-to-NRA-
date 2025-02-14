# Payment-to-NRA
# Introduction
The Payment to Non-Resident Aliens (NRA) Project aims to track and manage payments made to non-resident individuals on campus while ensuring compliance with IRS regulations. These payments include service-related fees, non-service-related reimbursements, awards, and guest expenses. The system ensures that taxpayer status is verified, proper tax forms are submitted, and withholding tax rates are applied based on visa types and tax treaties. The project was developed in multiple phases, transitioning from entity-relationship modeling (EER) to relational databases and finally to a graph-based model in Neo4J.

# Phase 1: Conceptual Model Development
In this phase, the EER diagram was designed to define key entities and their relationships. The major components included:
- Non-Resident Alien (NRA) : The individual receiving the payment.
- Visa & Documents : Key attributes to determine tax exemptions and eligibility.
- Payments & Tax Withholding :  Captures payment type, tax withholding rate, and tax treaty exemptions.
- Department Admin & Accounts Payable Services : Responsible for reviewing and approving payments.
- Account Payable Services Eligibility List : Ensures compliance before processing payments.

Defined important relationships, such as:
- NRAs submitting documents.
- Payments being verified by Accounts Payable Services.
- Department Admins supervising payment approvals.

<img width="613" alt="image" src="https://github.com/user-attachments/assets/b527ee49-e988-4201-8239-4d5f3db763b7" />

# Phase 2: Relational Database Design & Queries
Designed a relational database schema, ensuring:
- Referential integrity between NRAs, payments, and tax documents.
- Unique identifiers for SSNs, visa numbers, and tax treaties.
- Efficient queries for payment tracking, tax compliance, and financial reporting.

Queries implemented in SQL for:
- Tracking payments per NRA.
- Identifying tax treaty benefits.
- Listing departments processing payments.
- Finding NRAs with high-value transactions.

# Phase 3: Graph Database Implementation (Neo4J)
Transitioned from a relational database to a graph database model.
The new model provided better visualization of relationships between:
- NRAs, Payments, Department Admins, and Departments.
- Key relationships like “RECEIVES,” “APPROVES,” “PART_OF,” and “SUPERVISES” were implemented.

Cypher queries were developed to:

- Retrieve all payments made to NRAs.
- Identify high-value transactions.
- List department admins who approved payments.
- Calculate total department-wise payments.

<img width="703" alt="image" src="https://github.com/user-attachments/assets/ea51d482-4d4a-468c-bbe9-2810c705ce19" />
