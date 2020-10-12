@isTest
public class ContractAutoPopulateCRMhelper_Test {
    
    static testMethod void testName(){
       List<Costs_Risk_Matrix__c> crmlist = new List<Costs_Risk_Matrix__c>();
         String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Opportunity' and Name = 'Actual'].Id;
       
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
        Opportunity opp = new Opportunity();
        opp.RecordTypeId=strRecordTypeId;
        opp.AccountId = Acc.Id;
        opp.CloseDate = system.today();
        opp.Name = 'Test Opp';
        opp.StageName = 'M1: Solution Sent for Approval';
        insert opp;
        
        Contract cts = new Contract();
         cts.AccountId = Acc.Id;
        cts.Opportunity__c = opp.Id;
        cts.StartDate = system.today();
        cts.Status = 'Upload Signed Contract';
        insert cts;
        
        Costs_Risk_Matrix__c crm = new Costs_Risk_Matrix__c();
        crm.Are_the_man_hours_put_into_billing_okay__c ='re';
        crm.Opportunity__c = opp.Id;
        crm.Contract__c = cts.Id;
         crmlist.add(crm);
        
        Test.startTest();
        insert crmlist;
        ContractAutoPopulateCRMhelper.crmlists(crmlist);
        Test.stopTest();
        
    }

}