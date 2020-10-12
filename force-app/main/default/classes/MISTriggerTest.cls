@isTest
public class MISTriggerTest {
    @isTest
    public static void unitTest(){
        Account acc = new Account(Name ='Test');
        insert acc;
        Location__c loc = new Location__c();
        loc.Name= 'test';
        insert loc;
        
        
        City__c s = new City__c();
        s.Account__c = acc.Id;
        insert s;
        
        Campus__c camp = new Campus__c();
        camp.Location__c = s.Id;
        camp.Account__c = acc.Id;
        insert camp;
        
        
        
        
        Vehicle__c vh = new Vehicle__c();
         vh.Name = 'MP09213421';
        vh.City__c = s.id;
        vh.Finance_Type__c ='Owned';
        vh.Financer__c = 'Intelligrow';
        vh.Delivery_Date__c = system.today().addDays(3);
        vh.VIN_Number__c= '12345678901234567';
         vh.Re_enter_VIN_Number__c='12345678901234567';
        vh.Finance_Type__c='Owned';
        vh.Financer__c = 'ALD';
        vh.Delivery_Date__c = system.today().addDays(3);
        vh.Site__c = camp.Id;
        vh.Lease_Loan_Amount__c= 1000;
        vh.Lease_Loan_Start_Date__c = system.today();
        vh.Lease_Loan_End_Date__c= system.today().addDays(3);
        vh.OEM__c ='Tata';
        vh.Manufacturing_Date__c = system.today().addDays(4);
        vh.Vehicle_Registration_Number__c = 'GJ01RX0349';
        vh.Date_of_Purchase__c=system.today().addDays(2);
        vh.RC_Registration_Date__c = system.today().addDays(1);
        insert vh;
        
        Service_Provider__c sp = new Service_Provider__c();
        //sp.Name ='test';
        sp.Address__c = 'test';
        sp.Last_Name__c = 'Test';
        
        sp.Site__c = camp.Id;
        sp.Location__c = 'Bangalore';
        insert sp;
        
        MIS__c ms = new MIS__c();
        ms.DriverId__c = 'test';
        ms.VehicleNo__c = 'GJ01RX0349';
        ms.ClientName__c = 'test1';
        ms.ClientFacility__c = 'test2';
        
        insert ms;
    }
}