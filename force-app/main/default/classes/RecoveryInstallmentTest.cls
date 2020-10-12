@isTest
public class RecoveryInstallmentTest {
    @isTest static void testMethod1() {
        list<Driver_Recovery__c> driverList=new list<Driver_Recovery__c>();
        Driver_Recovery__c drObj=new Driver_Recovery__c();
        drObj.Total_Loss_incurred__c=20;
        drObj.Total_Number_of_Installments__c=8;
        driverList.add(drObj);
        
      
        
        Test.startTest();   
      insert  driverList;
        Test.stopTest();  
    }
}