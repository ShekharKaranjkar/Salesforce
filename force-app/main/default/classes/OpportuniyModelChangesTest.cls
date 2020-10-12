@isTest
public class OpportuniyModelChangesTest {

    
     static testMethod void getDependentMapList() {
       account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
         
         list<Opportunity> op=new list<Opportunity>();
        Opportunity ol=new Opportunity();
        ol.name='ragh';
        ol.StageName='M1: Solution Sent for Approval';
        ol.CloseDate=system.today();
        ol.AccountId=acc.id;
        ol.Electricity_included__c=false;
        insert ol;
         op.add(ol);
         
         City__c c=new City__c();
         c.Account__c=acc.id;
         insert c;
         
         list<Campus__c> cList=new list<Campus__c>();
         
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
            cList.add(campus);
         
             Campus__c   Campus2=new Campus__c();
         Campus2.Name='rag';
         Campus2.Location__c=c.id;
         Campus2.Account__c=acc.id;
         Campus2.Lithium_Bank_Account__c='State Bank';
      
         campus2.PAN__c='XXXXX1234X';
         campus2.GSTN__c='qwertyuiopasdfg';
         campus2.Invoice_Creation_Date__c=system.today();
         campus2.Payment_Terms__c= '30';
         campus2.Billing_City__c='mrt';
         campus2.Billing_State_Province__c='tp';
         campus2.Billing_Street__c='ee';
         campus2.Billing_Zip_Postal_Code__c='ff';
         campus2.Shipping_City__c='ff';
             campus2.Shipping_State_Province__c='ff';
             campus2.Shipping_Street__c='ff';
             campus2.Shipping_Zip_Postal_Code__c='ff';
         cList.add(campus2);

             insert cList;
         
         
        Test.startTest();
        Oppchange.OppchangeMethod(op);
        Test.stopTest();
    }
    

    
}