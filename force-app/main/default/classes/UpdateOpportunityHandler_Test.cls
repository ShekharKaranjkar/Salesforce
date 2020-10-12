@isTest
public class UpdateOpportunityHandler_Test {
    static Testmethod void isStatusChecked(){
           String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Opportunity' and Name = 'Actual'].Id;
        
        Map<Id,Opportunity> oldOpportunityMap = new Map<Id,Opportunity> ();
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
      //  Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Development').getRecordTypeId();

        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName = 'M1: Solution Sent for Approval';
        opp.CloseDate = system.today()+2;
        opp.AccountId = Acc.id;
        opp.Question__c = true;
        opp.Task_Stage__c = true;
        insert opp;
        List<Task>taskList = [Select Id,Status from Task where whatid=:opp.id];
        For(task t:taskList){
            t.Status = 'Completed';
        }
        update taskList;
        
        
        Test.startTest();
        
        opp.Question__c = true;
        opp.Task_Stage__c = true;
        update opp;
     
        Opportunity opp1 =[Select id,Stagename,Question__c,Task_Stage__c,(Select Id,Status from Tasks) from opportunity where id=:opp.id];
        List<task>tasklist2 = new List<Task>();
            For(task t:opp1.tasks){
            t.Status = 'Completed';
                tasklist.add(t);
        }
        update taskList2;
           opp1.Question__c = true;
        opp1.Task_Stage__c = true;
        update opp1;
        Test.stopTest();
            }
}