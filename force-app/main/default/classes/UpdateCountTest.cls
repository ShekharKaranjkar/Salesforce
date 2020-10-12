@isTest
public class UpdateCountTest {
   static testMethod void getFields() {

       Contract_Terms__c ct=new Contract_Terms__c();
       ct.Root_of_penalty__c='Taxi Payment';
       ct.Name='rag';
       insert ct;
        
       ct.Root_of_penalty__c='Revenue ramp down';
       update ct;
       
       Penalties__c p=new Penalties__c();
       p.Contract_Terms__c=ct.id;
             insert p;
        
        Test.startTest();
        vehicleController.getFields();
        Test.stopTest();
    }
}