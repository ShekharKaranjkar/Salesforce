@isTest
public class LeaveHistoryController_Test {
    
    static TestMethod void  onLoad(){

        account ac=new account();
        ac.Name='rag';
        ac.Lithium_Billing_Entity__c='Pune';
        ac.Lithium_Bank_Account__c='State Bank';
        insert ac;
        
        Contact con = new Contact();
        con.LastName='tetse';
        con.AccountId = ac.Id;
        
        insert con;
        City__c c=new City__c();
        c.Account__c=ac.id;
        insert c;
        Campus__c   Campus=new Campus__c();
        Campus.Name='rag';
        Campus.Location__c=c.id;
        Campus.Account__c=ac.id;
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
        
        
        Service_Provider__c sp=new Service_Provider__c();
        sp.Name='test';
        sp.Last_Name__c = 'test1';
        sp.Driving_License_Number__c='1234567890123456';
        sp.Address__c='209,ga';
        sp.Phone_Number__c='9992734422';
        sp.Aadhar_Number__c='123456789012';
        sp.Location__c='Hyderabad';
        sp.Site__c=campus.id;
        sp.Phone__c=1234567890;
        sp.Status__c = 'Active';
        insert sp;
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Leave__c' and Name = 'Planned EOS'].Id;
        Leave__c lea = new Leave__c();
        lea.RecordTypeId = strRecordTypeId;
        lea.From_date__c=system.today().addDays(10);
        lea.To_date__c = system.today().addDays(10);
        lea.Reason__c ='Family Emergency';
        lea.Service_Provider__c= sp.Id;
        insert lea;
        
        Test.startTest();
        LeaveHistoryController.LeaveHistoryMethod();
        Test.stopTest();         
        
    }
    
}