# Data Warehouse (BigQuery)

### Introduction

Data Warehouse (definition, OLTP & OLAP): https://phuockhai.notion.site/Data-Warehouse-2101e0bbbf39800c90d8f2248a8908b7?pvs=74

BigQuery (resources organizing, table, cost, partitioning & clustering, best pratices, architecture): https://phuockhai.notion.site/BigQuery-2161e0bbbf3980c49700f4cbe221f4f6

Code: [big_query.sql](big_query.sql)

### Machine Learning in BigQuery

*ML development: data collection -> processing -> model building -> validation -> deployment*

#### Model building

A typical model development workflow in BigQuery ML

- Create a model (`CREATE MODEL`)
- Preprocessing (automatically or manual)
- Refine the model to fit the training data by performing hyperparameter tuning
- Evaluate the model
- Perform Inference
- Provide Explainability
- Learn more about the components that comprize the model (using model weights)

Code: [big_query_ml.sql](big_query_ml.sql)

#### Deployment

Instruction: [ml_model_deployment.txt](ml_model_deployment.txt)

After follow the instruction, can check model status via endpoint http://localhost:8501/v1/models/tip_model
