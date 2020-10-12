@isTest
public class OperationsEngagementController_Test {
    static testmethod void testmethod1(){
        Operations_And_Engagement__c b = new Operations_And_Engagement__c();
        b.City__c ='Bng';
        b.Name = 'st';
        
        insert b;
        Test.startTest();
        OperationsEngagementController.getSetting();
        Test.stopTest();
    }
}