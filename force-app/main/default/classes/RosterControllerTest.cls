@istest
public class RosterControllerTest {
    
    @testSetup static void roster(){
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
        campus.Site_Incharge__c= userInfo.getUserId();
        insert campus;
        Service_Provider__c service1 = new Service_Provider__c( );
        //   service1.Service_Provider_Name1__c='TEST_Service';
        service1.Driving_License_Number__c='1234567890123456'; 
        service1.Address__c='asd';
        service1.Phone_Number__c='1234567890';
        service1.Aadhar_Number__c='123456789012';
        service1.Name='test';
        service1.Site__c=campus.id;
        service1.Phone__c = 1234567;
        service1.Location__c ='Bangalore';
        service1.Last_Name__c='rag';
        
        insert service1;
        
        Approval_Request__c ap = new Approval_Request__c();
        ap.status__c='Requested';
        insert ap;
        
        list<Rostering__c> r=new list<Rostering__c>();
        Rostering__c ro = new Rostering__c();
        ro.status__c='Requested';
        ro.Approval_Request__c=ap.Id;
        ro.Lithium_ID__c=service1.Id;
        ro.Shift_Start_Date__c=system.today();
        ro.Shift_End_Date__c=system.today().addDays(1);
       ro.Start_Time__c=Time.newInstance(1, 2, 3, 4);
        ro.End_Time__c=Time.newInstance(1, 2, 3, 4).addHours(3);
        r.add(ro); 
        insert r;
    }
    @isTest static void getShiftPicklist() {
        Test.startTest();
        RosterController.getShiftPicklist();
        
        Test.stopTest(); 
    }
    @isTest static void getServiceProvider() {
        Test.startTest();
        RosterController.getServiceProvider();
        
        Test.stopTest(); 
    }
    
    @isTest static void saveRoster() {
                Campus__c   Campus=[select id from Campus__c limit 1 ];
        list<Rostering__c> r=new list<Rostering__c>();
        Rostering__c ro = new Rostering__c();
        
        r.add(ro);
        Test.startTest();
        RosterController.saveRoster(r,r,r,Campus.Id);
        
        Test.stopTest(); 
    }
    @isTest static void approvalRequest() {
        list<Approval_Request__c> ap=[select id,status__c from Approval_Request__c];
        
        ap[0].status__c='Approved';
        update ap;
        
        
    }
    
    
}