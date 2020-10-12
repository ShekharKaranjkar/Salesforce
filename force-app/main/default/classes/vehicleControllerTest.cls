@isTest
public class vehicleControllerTest {
    
    static testMethod void getId() {
        
        
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        
        
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        
        
        
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=acc.id;
        Campus.Lithium_Bank_Account__c='State Bank';
        campus.PAN__c='XXXXX1234X';
        campus.GSTN__c='qwertyuiopasdfg';
        campus.Invoice_Creation_Date__c=system.today();
        campus.Payment_Terms__c= '30';
        campus.Billing_City__c='mrt';
        campus.Billing_State_Province__c='tp';
        campus.Billing_Street__c='ee';
        campus.Billing_Zip_Postal_Code__c='ff';
        campus.Shipping_City__c='ff';
        campus.Shipping_State_Province__c='ff';
        campus.Shipping_Street__c='ff';
        campus.Shipping_Zip_Postal_Code__c='ff';
        insert campus;
        
        Vehicle__c v2 = new Vehicle__c();
         v2.Name = 'MP09213421';
        v2.City__c = c.id;
        v2.Finance_Type__c ='Owned';
        v2.Financer__c = 'Intelligrow';
        v2.Delivery_Date__c = system.today().addDays(3);
        v2.Site__c=campus.Id;
        v2.VIN_Number__c='12345678901234567';
        v2.Re_enter_VIN_Number__c='12345678901234567';
        v2.Lease_Loan_Amount__c= 1000;
        v2.Status1__c='New';
        v2.Lease_Loan_Start_Date__c = system.today();
        v2.Lease_Loan_End_Date__c= system.today().addDays(3);
        v2.OEM__c ='Tata';
        v2.Manufacturing_Date__c = system.today().addDays(4);
      //  v2.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v2.Date_of_Purchase__c=system.today().addDays(2);
        v2.RC_Registration_Date__c = system.today().addDays(1); 
      //  v2.Task_Stage__c = false;
        v2.All_Vehicle_Documents_Received__C = false;
        v2.Is_Accessories_filled__c = true;
        v2.Vehicle_Registration_Number__c ='Tn52za1234';
        insert v2;

        String RecordtypeID = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Scheduled Maintenance'].Id;
        Test.startTest();
        vehicleController.getId(v2.id);
         IssueOverRideController.getFieldswithSectionHeaders(RecordtypeID);

        Test.stopTest();
    }
    
    static testMethod void getFields() {

        
        Test.startTest();
        vehicleController.getFields();
        Test.stopTest();
    }
 /*   static testMethod void getFieldswithSectionHeaders() {
  String RecordtypeID = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Scheduled Maintenance'].Id;
        Issues__c iss = new Issues__c();
        iss.Scheduled_Maintenance_Type__c = 'Scheduled Service';
        iss.RecordTypeId = RecordtypeID;
        insert iss;
        
        Test.startTest();
        IssueOverRideController.getFieldswithSectionHeaders(RecordtypeID);
        Test.stopTest();
    }*/

}