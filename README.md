# PDF Scraping
The process outlines how to scrape and extract multiple tables from PDF documents using the location coordinates of specific strings. Please note assumptions below:
1. The table structure in the PDF documents remains consistent, with fixed column headers and formats, including font, spacing, and padding.
2. The tables in the PDF documents are actual tables, not screenshots.
3. The location of the tables is variable; for instance, the same table might appear on page 2, page 5, or elsewhere in the document. 

## Prerequisites:
```
import re
import PyPDF2 as pdfs
import tabula
from tabula.io import read_pdf
```

## Methodologies
Imagine there are 3 different tables in the same PDF file and the task is to extract the yellow highlighted product table:


### Part II. Develop Sequences, Triggers, functions, procedures and indexes to support daily operation. 
For details, please refer to attached SQL scripts.
#### 1. Inventory stock
To ensure the inventory has sufficient stock through the daily operation, the system will automatically prompt a message as reminder for supplements when the inventory is low. Additionally, when the inventory quantities are updated as a result of new orders being placed or restocking, a summary information of each inventory item and its corresponding quantity will be automatically generated
```
Select * from Inventory where InventoryID = ‘IV-0001’;
```

<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/c419376f-3445-4d8b-9f98-89ec1eec94ff" alt="Diagramt" width="400"/>

```
Update Inventory 
Set InventoryQuantity = 50 where InventoryID = ‘IV-0001’;
```

<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/e2cbb9f9-1a70-422f-a916-1cf6e998d68a" alt="Diagramt" width="300"/>

#### 2. Employee Evaluation
The function computes the evaluation score to facilitate the employee evaluation process. The delivery manager uses this information to allocate the bonus amount to the employee. 
```
Execute employee_rating_calc;
Select employee_rating_calc (‘E019’, 8) as rating from Dual;
```
<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/dfbaeb57-d1bd-40c1-b6c2-13be7b4fe4ad" alt="Diagramt" width="500"/>

#### 3. Billing Consolidation
The procedure computes outstanding amounts by each customer per month. 
```
Execute MV_Company_Billing;
Execute get_company_billing;
Execute company_billing_job;
```
<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/ed0c478b-a073-4575-8563-4f35aa598241" alt="Diagramt" width="200"/>
