@isTest
public class oppmomTest {
	    static testMethod void testName(){
        Lead leadObject = new Lead();
        leadObject.LastName = 'TESTLEAD';
        leadObject.Company = 'XYZ';
        leadObject.Status = 'C1: New';
        leadObject.LeadSource = 'Cold Call';
        insert leadObject;
            
        Task taskObject = new Task();
        taskObject.OwnerId = UserInfo.getUserId();
        taskObject.Subject='Donni';
        taskObject.Status='Not Started';
        taskObject.Priority='Normal';
		taskObject.WhoId = leadObject.id;
        insert taskObject; 
        
        String jsonLead = JSON.serialize(leadObject);
            
            Lead leadObject1 = new Lead();
            leadObject1.LastName = 'TESTLEAD';
            leadObject1.Company = 'XYZ';
            leadObject1.Status = 'C1: New';
            leadObject1.LeadSource = 'Cold Call';
            leadObject1.Is_Highly_Qualified__c ='TEST';
            leadObject1.Task_Stage__c = false;
            leadObject1.Have_you_met_boss_of_the_contact__c = 'TEST';
            leadObject1.Roster_Data_Parameters_checked__c = 'TEST';
            leadObject1.Have_you_identified_EV_initiative_key_dr__c = 'TEST';
            insert leadObject1;
        
        Test.startTest();
        oppmom.createRecord(jsonLead);
        oppmom.getleadvalues(leadObject1.id);
        oppmom.updateLead(leadObject1.id);
            
        Test.stopTest();
    }
}