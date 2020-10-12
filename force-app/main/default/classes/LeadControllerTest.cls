@isTest
public class LeadControllerTest {
    static testMethod void testName(){
        Lead leadObject = new Lead();
        leadObject.LastName = 'TESTLEAD';
        leadObject.Company = 'XYZ';
        leadObject.Status = 'C1: New';
        leadObject.LeadSource = 'Cold Call';
        insert leadObject;
        
        String jsonLead = JSON.serialize(leadObject);
        
        Test.startTest();
        LeadController.getleadvalues(leadObject.id);
        LeadController.createRecord(jsonLead);
        Test.stopTest();
    }
}