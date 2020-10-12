@isTest
public class LookupInventoryControllerTest {
    @isTest static void createRecordTryPart() {
         
        Inventory_Product__c inven=new Inventory_Product__c();
        inven.Name='test';
        inven.Stock__c=300;
        insert inven;
        String objName='Inventory_Product__c';
        String fieldName='name';
         String value='t';
        
   
        Test.startTest();   
        LookupInventoryController.getResults(objName,fieldName,value) ;
        Test.stopTest();  
    }
}