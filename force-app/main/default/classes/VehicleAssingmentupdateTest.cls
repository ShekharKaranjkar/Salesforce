@isTest
public class VehicleAssingmentupdateTest {
    @testSetup static void methodName() {
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
        
    }
        
    static Testmethod void VehicleAssingmentupdateClass(){
        Id devRecordTypeId = Schema.SObjectType.Issues__c.getRecordTypeInfosByName().get('Scheduled Maintenance').getRecordTypeId();
        Campus__c campus = [Select id from Campus__c limit 1];
        
        list<Vehicle_Assignment__c> vhlist = new list<Vehicle_Assignment__c>();
               City__c c = [Select id from City__c limit 1];
        Vehicle__c v1 = new Vehicle__c();
          v1.Name = 'MP09213421';
      v1.City__c = c.id;
        v1.Finance_Type__c ='Owned';
        v1.Financer__c = 'Intelligrow';
        v1.Delivery_Date__c = system.today().addDays(3);
        v1.Site__c=campus.Id;
        v1.VIN_Number__c='12345678901234567';
        v1.Re_enter_VIN_Number__c='12345678901234567';
        v1.Lease_Loan_Amount__c= 1000;
        v1.Status1__c='New';
        v1.Lease_Loan_Start_Date__c = system.today();
        v1.Lease_Loan_End_Date__c= system.today().addDays(3);
        v1.OEM__c ='Tata';
        v1.Manufacturing_Date__c = system.today().addDays(4);
        v1.Vehicle_Registration_Number__c = 'GJ01RX0349';
        v1.Date_of_Purchase__c=system.today().addDays(2);
        v1.RC_Registration_Date__c = system.today().addDays(1);
        // vhlist.add(v1);
        insert v1;
        
        Service_Provider__c sp=new Service_Provider__c();
     //   sp.Service_Provider_Name1__c='test';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
      //  sp.Phone__c=1234567890;
      //sp.Vehicle_Assigned_To__c='www';
        
        insert sp;
        Vehicle_Assignment__c va=new Vehicle_Assignment__c();
        
        va.Service_Provider__c=sp.id;
        va.Vehicle__c=v1.id;
        vhlist.add(va);
        insert vhlist;
        delete vhlist;
        
        Test.startTest();
        VehicleAssingmentupdate.updateVehicleAndServiceProvider(vhlist);
        Test.stopTest();
        
        
    }  
}