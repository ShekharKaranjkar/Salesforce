@isTest
public class QualifierOppControllerTest {

    static testMethod void testName(){
        Opportunity opp = new Opportunity();
        opp.Name = 'TESTLEAD';
        opp.StageName ='M1: Solution Sent for Approval';
        opp.CloseDate = System.today();
        insert opp;
        
        String jsonOpportunity = JSON.serialize(opp);
        
        Test.startTest();
        QualifierOppController.getleadvalues(opp.id);
        QualifierOppController.createRecord(jsonOpportunity);
        Test.stopTest();
    }
}