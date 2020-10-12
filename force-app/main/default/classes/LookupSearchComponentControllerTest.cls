@isTest
public class LookupSearchComponentControllerTest {
    @isTest static void createRecordTryPart() {
                account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        String objName='account';
        String fieldName='name';
         String value='r';
        
   
        Test.startTest();   
        LookupSearchComponentController.getResults(objName,fieldName,value) ;
        Test.stopTest();  
    }
}