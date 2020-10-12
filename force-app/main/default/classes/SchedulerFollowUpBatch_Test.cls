@IsTest
public class SchedulerFollowUpBatch_Test {

    @istest
    static void startschedule(){
        List<Account>acclist =new List<Account>();
        For(Integer i=0;i<100;i++){
                Account Acc = new Account();
        Acc.Name = 'Test 15:56';
        Acc.Lithium_Bank_Account__c  = 'Bangalore';
        Acc.Lithium_Billing_Entity__c  = 'Canara Bank';
        Acc.Invoice_Creation_Date__c = system.today().addDays(-16);
        Acc.Payment_Terms__c = '15';
            acclist.add(Acc);
        }
       
        
        Test.startTest();
         Insert acclist;
        String CRON_EXP = '0 0 0 15 3 ? *';
         String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new SchedulerFollowUpBatch());
        Test.stopTest();
    }
}