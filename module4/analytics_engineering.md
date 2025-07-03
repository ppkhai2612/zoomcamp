# Analytics Engineering (dbt)

Analytics Engineering: is a data role that manages the company’s data stack (combine data engineer and data analyst). The main responsible is control the ETL process (data modeling, data orchestration, data warehouse,...). https://towardsdatascience.com/analytics-engineer-the-newest-data-career-role-b312a73d57d7/

dbt: https://www.notion.so/phuockhai/dbt-2161e0bbbf3980fab715eff20469853f

### Setting up the environment

There are 2 options:

- Cloud (BigQuery): https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/dbt_cloud_setup.md

    - Create a BigQuery service account: grant BigQuery Admin, create and download key
    - Create a dbt cloud project: upload the key to configure development environment
    - Add Github repository: deploy keys to Github (make sure to tick on "allow write access")

        *Note: there are 2 keys, the ones dbt use to access BigQuery, another dbt use to access to Github repo*

- Local (Postgres): https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main/04-analytics-engineering/docker_setup

### Starting a dbt project & Building the first model

#### Model & Materializations
- Model: a model is a `.sql` file that includes a SELECT statement dbt will compile and run in DWH
- Materializations are strategies for persisting dbt models in a warehouse. Ex: ephemeral, table, view, incremental

#### Sources & Seeds

- Sources
    - Raw tables in your data warehouse that serves as the starting point for your data transformations
    - Source help to track lineage and ensure that your models are built on the correct data

- Seeds
    - CSV files in dbt project (typically in *seeds* directory), that dbt can load into your data warehouse using the `dbt seed` command
    - Seeds are best suited to static data which changes infrequently. Ex: a lookup table include a list of mappings of country codes to country names

#### Jinja and macros

- Jinja: is a fast, expressive, extensible templating engine. Special placeholders in the template allow writing code similar to Python syntax. Then the template is passed data to render the final document

    Some syntax:
    - Expressions `{{ ... }}`: used for variables and macros
    - Statements `{% ... %}`: used for if, for, set or modify variables, define macros
    - Comments `{# ... #}`

- Macros: are pieces of code that can be reused multiple times – they are analogous to "functions" in other programming languages

#### Packages
- Libraries help programmers operate with leverage: they can spend more time focusing on their unique business logic, and less time implementing code that someone else has already spent the time perfecting. (`packages.yml` or `dependencies.yml`)
- `package-lock.yml` contains a record of all packages installed => If subsequent `dbt deps` runs contain no changes to `dependencies.yml` or `packages.yml`, dbt-core installs from `package-lock.yml`

#### Variables
- Provide data to models for compilation
- Variables can be defined in two ways: in the `dbt_project.yml` or the command line
- Variable precedence:
    - On the command line with `--vars`
    - In the `dbt_project.yml`
    - *Default* argument of *var* function

Data lineage: is the process of tracking and documenting the journey of data from its source to its final destination. It provides a clear, end-to-end view of how data moves, transforms, and evolves throughout your organization. https://www.getdbt.com/blog/what-is-data-lineage

Configurations and properties: properties describe resources, while configurations control how dbt builds them in the warehouse

dbt commands

- `dbt build`: run models, test tests, snapshot snapshots, seed seeds

    - `dbt seed`: load csv files in the *seeds* directory into data warehouse
    - `dbt run`: executes compiled SQL model files against the current target database
        - `dbt compile`: compile executable SQL from source, model, test, and analysis files (these compiled SQL files in the `target/` directory)
    - `dbt snapshot`
    - `dbt test`: runs data tests defined on models, sources, snapshots, and seeds and unit tests defined on SQL models

- `dbt deps`: pulls the most recent version of the dependencies listed in [packages.yml](packages.yml) from git

### Testing and Documenting

#### Testing

- Data tests are assertions you make about your resources in dbt project (models, sources, seeds and snapshots) -> improve the integrity of the SQL

- There are two ways of defining data tests in dbt:
    - A singular data test: write *.sql* file in *tests* directory
    - A generic data test: dbt provides 4 generic data tests: unique, not_null, accepted_values and relationships

#### Documenting 
dbt provides a way to generate documentation for project and render it as a website
- Information about your project: including model code, a DAG of your project, any tests you've added to a column, and more.
- Information about your data warehouse: including column data types, and table sizes. This information is generated by running queries against the information schema.
- Importantly, dbt also provides a way to add descriptions to models, columns, sources, and more, to further enhance your documentation.

Steps to generate documentation:
- `dbt docs generate`: compile relevant information about dbt project and warehouse into `manifest.json` and `catalog.json` files, respectively
- Ensure you've created the models with `dbt run` or `dbt build` to view the documentation for all columns, not just those described in your project
- Run the `dbt docs serve` if you're developing locally to use these *.json* files to populate a local website

### Deployment

Deployment: process of taking data models that have been developed, tested and documented into a production environment. The main purpose is to enable these models to run automatically, periodically, and provide transformed data for analysis or reporting purposes.

Steps:
- Create a deployment environment
- Create a deploy job (schedule to run job on weekdays at 12:00 UTC)
    - Tick on `run source freshness` (enable `dbt source freshness`) to
        - find all source with freshness
        - create a query to find MAX of loaded_at_field => last modified of source table
        - result is saved in `sources.json` and tick on `generate docs on run`

CI/CD (Continuous Integration / Continuous Development): automates the manual human intervention traditionally needed to get new code from a commit into production, encompassing the build, test (including integration tests, unit tests, and regression tests), and deploy phases, as well as infrastructure provisioning => get CI/CD right and downtime is minimized and code releases happen faster
- Create a CI job in dbt to trigger every time someone opens a pull request

Artifacts: when running dbt jobs, dbt generates and saves artifacts. You can use these artifacts, like `manifest.json`, `catalog.json`, and `sources.json` to power different aspects of the dbt platform

### Visualizing the transformed data
- Use Looker Studio to make dashboard
    