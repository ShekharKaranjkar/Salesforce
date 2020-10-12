@isTest
public class AssignToLookUpTest {
    static testMethod void testMethod1() 
    {
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        City__c c=new City__c();
        c.Account__c=acc.id;
        insert c;
        

        Test.startTest();
        string searchKeyWord ='r';
        string ObjectName ='City__c';
    Sobject  testt=   Database.Query('Select Id FROM '+ObjectName);
        AssignToLookUp.fetchLookUpValues(searchKeyWord,ObjectName,testt);

        
        Test.stopTest();
    }
}