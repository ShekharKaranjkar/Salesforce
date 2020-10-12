@IsTest
public class ContractHandler_Test {
    static testmethod void contractactivation(){
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Opportunity' and Name = 'Actual'].Id;        
        Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Insert Acc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'testtest';
        opp.AccountId = Acc.id;
        opp.CloseDate = system.today() +5;
        opp.RecordTypeId =strRecordTypeId ;
        opp.StageName = 'M1: Solution Sent for Approval';
        insert opp;
        Contract contractte= new Contract();
        contractte.Name = 'test';
        contractte.AccountId = acc.Id;
        contractte.StartDate = system.today();
        contractte.Opportunity__c = opp.Id;
        contractte.Status = 'Upload Signed Contract';
        insert contractte;
        
        //Contract con =[select id,Status,Task_Stage__c,Question__c from Contract where id =:contractte.Id ];
        Map<id,Contract>contactractMap =new Map<id,Contract>();
        contactractMap.put(contractte.Id,contractte);
        List<Contract>contactractList =new List<Contract>();
        Contract contractte1= new Contract();
        contractte1.Id=contractte.id;
        contractte1.Status = 'Active';
        contractte1.Question__c = true;
        contractte1.Task_Stage__c = true;
        contactractList.add(contractte1);
        
        map<id,task> taskmap = new map<id,task>();
        
        List<Task> tas = [Select id,Status from Task where whatid=:contractte.id];
        
        for (Task tasktask :tas ){
            tasktask.Status = 'Completed';
        }       
        test.startTest();
        update tas;
        test.stopTest();
        
        
    }
}