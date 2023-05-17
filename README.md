# Advanced-Relational-Database-Management
This project is aimed to create an internal database management system for company ABC which supplies bottles of energy water to gyms in Pittsburgh city. Below is a summary of how they operate their business: 
1. Company ABC has a secret recipe for making this energy and the cost of goods sold is nearly zero. 
2. Company ABC also supplies three different size of cup holders. 
3. All products delivered by drivers in their assigned routes. 
4. Customers can sign an annual contract with Sales representatives of Company ABC or directly place an order with the driver upon the delivery of the prior order. 
5. Customers will be given an extra discount for referring new customers. 

Below is a high-level workflow:   
<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/ea2c184e-9cb2-4860-af79-688385516945" alt="Diagramt" width="500"/>

In addition, the management of company ABC believe it is very important to maintain segregation of duties between sales, finance, and operations departments. And Performance evaluation is conducted on drivers regularly to ensure customer satisfaction.
<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/9440752b-2a0e-43fa-903c-c74f689b1624" alt="Diagramt" width="500"/>

## Database Design:
### 1. Develop an ERD
The following busienss rules are incorproated while developing the entity relationship diagram:
1. Contract
- Each customer has at least one contract. However, they may only have up to one active contract at a time
- Contract estimates are modifiable and can be updated in an active contract based on customer needs.
2. Inventory
- Company ABC only has one inventory at a specific location
- Company ABC has a separate system in place to track all returns made by clients
3. Billing
- A contract must be paid up front and all at once. Each contract is associated with one row in the billing table
4. Delivery
- Each customer is assigned to one delivery route based on location.
- Each driver has up to one route. However, one route may have multiple drivers.
- Each route has a difficulty level based on route distance and the size/number of deliveries on that route.

Below is the ERD:
![image](https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/9399abaf-967f-4838-923a-54e9078c5654)

### 2. Develop Sequences, Triggers, functions, procedures and indexes to support daily operation. 
For details, please refer to attached code zip package.
#### Inventory stock
To ensure the inventory has sufficient stock through the daily operation, the system will automatically prompt a message as reminder for supplements when the inventory is low. Additionally, when the inventory quantities are updated as a result of new orders being placed or restocking, a summary information of each inventory item and its corresponding quantity will be automatically generated
```
Select * from Inventory where InventoryID = ‘IV-0001’;
```

<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/c419376f-3445-4d8b-9f98-89ec1eec94ff" alt="Diagramt" width="300"/>

```
Update Inventory 
Set InventoryQuantity = 50 where InventoryID = ‘IV-0001’;
```

<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/e2cbb9f9-1a70-422f-a916-1cf6e998d68a" alt="Diagramt" width="300"/>

#### Employee Evaluation
The function computes the evaluation score to facilitate the employee evaluation process. The delivery manager uses this information to allocate the bonus amount to the employee. 
```
Execute employee_rating_calc;
Select employee_rating_calc (‘E019’, 8) as rating from Dual;
```
<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/dfbaeb57-d1bd-40c1-b6c2-13be7b4fe4ad" alt="Diagramt" width="300"/>

#### Billing Consolidation
The procedure computes outstanding amounts by each customer per month. 
```
Execute MV_Company_Billing;
Execute get_company_billing;
Execute company_billing_job;
```
<img src="https://github.com/leege8/Advanced-Relational-Database-Management/assets/124459825/ed0c478b-a073-4575-8563-4f35aa598241" alt="Diagramt" width="200"/>
