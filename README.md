# dbt_getground

## Language and Script
- SQL

## Databases
1. Development: dbt_pearl
2. Deployment: dbt_prod
3. Warehouse (OLAP): Locally hosted Snowflake DB

## Tools and Technology Used
1. SQL
2. Snowflake

## Approach:

### Database and Schema Setup:
- Created two databases and schemas, one for development (dbt_pearl) and the other for deployment (dbt_prod).

### Version Control:
- Created a Git repository called dbt_getground.
- Cloned the repository using the link: [https://github.com/oluchinwade/dbt_getground.git](https://github.com/oluchinwade/dbt_getground.git).

### Environment Configuration:
- Initialized dbt core on the local system.
- Configured the `profile.yml` file along with the `dbt_project.yml` file to match Snowflake credentials for seamless integration.
- Configured the package.yml file.
- Run 'dbt deps' to install project dependencies.

### Data Preparation:
- Uploaded CSV files into the seed folder.
- Executed the command `dbt seed --select partners referrals sales_people` to load the data into the respective database tables.

### Data Transformations:
- Performed light data transformations in the staging files, including:
  - Conversion of `created_at` and `updated_at` from Unix nano to timestamp format.
  - Removal of null values in `lead_sales_contact`.
  - Conversion of `is_bound` binary data to boolean (true/false).
- Data transformation operations were conducted in the `marts` folder.
- Merged three tables into one called `fct_referrals.sql`.
- Run 'dbt build' for both testing and running the project.

### Query Analysis:
- Utilized the `queries.sql` file to store all SQL queries used for analyzing the transformed data in `fct_referral.sql`.

**Documentation:** [dbt_getground](http://localhost:8080/#!/overview/dbt_getground)

**Note:** 
- Ensure to update the Snowflake credentials in the `profile.yml` file.
- Run `dbt run` command to execute the data transformations.
- Maintain version control throughout the project development process. Happy coding! 🚀
