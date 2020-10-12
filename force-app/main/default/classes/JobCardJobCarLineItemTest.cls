@IsTest
public class JobCardJobCarLineItemTest {
    
    
    @testSetup static void setup() {
        
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
        Vehicle__c v1 = new Vehicle__c();
                  v1.Name = 'MP09213421';
        v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Financer__c = 'Intelligrow';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Name='GJ01RX0349234';
        v1.Site__c=campus.Id;
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Status1__c='New';
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349234';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        // vhlist.add(v1);
        insert v1;
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Vehicle_Assigned_To__c=v1.id;
        
        insert sp;
        
        Id recSwapped = Schema.SObjectType.Service_Center__c.getRecordTypeInfosByName().get('Lithium WorkShop').getRecordTypeId();
        
        Service_Center__c ser = new Service_Center__c();
        ser.Name = 'Mettur';
        // ser.OwnerId = usrObj.id;
        ser.Pincode__c = 636401;
        ser.Zip_Postal_Code__c = 636401;
        ser.RecordTypeId = recSwapped;
        ser.Location__Latitude__s =11.7863 ;
        ser.Location__Longitude__s=77.8008 ;
        insert ser;
        Vehicle_Assignment__c va=new Vehicle_Assignment__c();
        
        va.Service_Provider__c=sp.id;
        va.Vehicle__c=v1.id;
        Test.startTest();
        insert va;
        
        Issues__c issue= new Issues__c();
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Issues__c' and Name = 'Breakdown'].Id;
        
        issue.Vehicle__c = v1.id;
        issue.Service_Provider__c = sp.id;
        issue.RecordTypeId = strRecordTypeId;
        // issue.Latitude__Latitude__s=12.9569;
        issue.Current_Location__Latitude__s=12.9569;
        issue.Current_Location__Longitude__s=77.7011;
        // issue.Latitude__Longitude__s= 77.7011;
        insert issue;
        
        Job_Card__c j=new Job_Card__c();
        j.Campus__c=campus.id;
        j.Issues__c=issue.id;
        insert j;
        
        Inventory_Product__c inven=new Inventory_Product__c();
        inven.Name='test';
        inven.Stock__c=300;
        insert inven;
        List<Job_Card_Line_Item__c> jList=new  List<Job_Card_Line_Item__c>();
        Job_Card_Line_Item__c jc=new Job_Card_Line_Item__c();
        jc.Job_Card__c=j.id;
        jc.Quantity__c=20;
        jc.Inventory_Product__c=inven.id;
        
        insert jc;
        jList.add(jc);
        Job_Card_Line_Item__c jc1=new Job_Card_Line_Item__c();
        jc1.Job_Card__c=j.id;
        jc1.Quantity__c=20;
        jc1.Parts__c='Swapped';
        jc1.Inventory_Product__c=inven.id;
        
        insert jc1;
        jList.add(jc1);
        Job_Card_Line_Item__c jc2=new Job_Card_Line_Item__c();
        jc2.Job_Card__c=j.id;
        jc1.Parts__c='Inventory';
        jc2.Quantity__c=20;
        jc2.Inventory_Product__c=inven.id;
        
        insert jc2;
        jList.add(jc2);
        Job_Card_Line_Item__c jc3=new Job_Card_Line_Item__c();
        jc3.Job_Card__c=j.id;
        jc3.Quantity__c=20;
        jc1.Parts__c='General';
        jc3.Inventory_Product__c=inven.id;
        
        insert jc3;
        jList.add(jc3);
        
        
    }
    @isTest static void testMethod1() {
        Issues__c i=[select id,name from Issues__c limit 1];
        Test.startTest();   
        JobCardJobCarLineItem.getIssue(i.id) ;
        Test.stopTest();  
    }
    @isTest static void getInventory() {
        
        Test.startTest();   
        JobCardJobCarLineItem.getInventory() ;
        Test.stopTest();  
    }
   /* 
    
    @isTest static void createRecordCatchPart() {
        List<Job_Card__c> j=[select id,name from Job_Card__c limit 1];
        Issues__c IdIssue=[select id,name from Issues__c limit 1];
        List<String>deleteIds=new  List<String>();
        List<Job_Card_Line_Item__c> i=[select id,name from Job_Card_Line_Item__c limit 1];
        deleteIds.add(i[0].Id);
        Test.startTest();   
        JobCardJobCarLineItem.createRecord(j,i,IdIssue.id,deleteIds) ;
        Test.stopTest();  
    }
*/
    @isTest static void createRecordTryPart() {
        List<Job_Card__c> j=[select id,name from Job_Card__c limit 1];
        Issues__c IdIssue=[select id,name from Issues__c limit 1];
        List<String>deleteIds=new  List<String>();
        List<Job_Card_Line_Item__c> i=[select id,name,Parts__c,Quantity__c,Inventory_Product__c from Job_Card_Line_Item__c];
        deleteIds.add(i[0].Id);
        Test.startTest();   
        JobCardJobCarLineItem.createRecord(j,i,IdIssue.id,deleteIds) ;
        Test.stopTest();  
    }
}